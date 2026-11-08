#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Live create/update/delete tests against a real ConnectWise Manage server. USE A SANDBOX, NOT PRODUCTION.
# Tagged 'Integration' and 'Write'. They run only with
#     ./Tests/Invoke-Tests.ps1 -Test -Live
# AND $env:CWMAllowWrite = 'yes' (set it in Tests/live.local.ps1 only for a sandbox server).
#
# Every record is created under a new company whose identifier starts with 'PSTEST' and is deleted again in
# AfterAll. If a run is interrupted, ./Tools/Remove-CWMTestData.ps1 finds and removes leftover PSTEST records.
# Nothing here sends email, posts to finance, or submits time.

BeforeDiscovery {
    $script:NoWrite = [string]::IsNullOrEmpty($env:CWMServer) -or $env:CWMAllowWrite -ne 'yes'
}

BeforeAll {
    Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
    if ($env:CWMServer -and $env:CWMAllowWrite -eq 'yes') {
        Connect-CWM -Server $env:CWMServer -Company $env:CWMCompany -PubKey $env:CWMAPIMemberPub `
            -PrivateKey $env:CWMAPIMemberPriv -ClientID $env:CWMClientID -Force -ErrorAction Stop
    }
    # Identifier max length is 25: PSTEST + yyMMddHHmmss = 18
    $script:RunId = 'PSTEST' + (Get-Date -Format 'yyMMddHHmmss')
    # Records to delete in AfterAll, newest first: @{ Command; Splat }
    $script:Created = New-Object System.Collections.Generic.List[object]
    function Add-Cleanup([string]$Command, [hashtable]$Splat) { $script:Created.Insert(0, @{ Command = $Command; Splat = $Splat }) }
}

AfterAll {
    foreach ($Item in $script:Created) {
        $Splat = $Item.Splat
        try { & $Item.Command @Splat -Confirm:$false -ErrorAction Stop }
        catch { Write-Warning "Cleanup failed: $($Item.Command) $($Splat | Out-String) $_" }
    }
    Disconnect-CWM -ErrorAction SilentlyContinue
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Live write: company, contact and notes' -Tag 'Integration', 'Write' -Skip:$NoWrite {

    BeforeAll {
        $TypeId = @(Get-CWMCompanyType -pageSize 1 -ErrorAction Stop)[0].id
        $NewCompany = @{
            identifier = $RunId
            name       = "$RunId PowerShell module test"
            site       = @{ name = 'Main' }
            types      = @(@{ id = $TypeId })
        }
        $script:Company = New-CWMCompany @NewCompany -ErrorAction Stop
        Add-Cleanup 'Remove-CWMCompany' @{ id = $Company.id }
    }

    It 'New-CWMCompany creates the company' {
        $Company.id | Should -BeGreaterThan 0
        (Get-CWMCompany -id $Company.id -ErrorAction Stop).identifier | Should -Be $RunId
    }

    It 'Update-CWMCompany changes one field (Single)' {
        Update-CWMCompany -id $Company.id -Operation replace -Path 'website' -Value 'https://example.com' -ErrorAction Stop
        (Get-CWMCompany -id $Company.id -ErrorAction Stop).website | Should -Be 'https://example.com'
    }

    It 'Update-CWMCompany changes several fields (Bulk)' {
        Update-CWMCompany -id $Company.id -ErrorAction Stop -PatchOperations @(
            @{ op = 'replace'; path = 'phoneNumber'; value = '5555550100' }
            @{ op = 'replace'; path = 'name'; value = "$RunId bulk update" }
        )
        $Result = Get-CWMCompany -id $Company.id -ErrorAction Stop
        $Result.phoneNumber | Should -Be '5555550100'
        $Result.name | Should -Be "$RunId bulk update"
    }

    It 'New/Update/Remove-CWMCompanyContact' {
        $Contact = New-CWMCompanyContact -firstName 'Pester' -lastName $RunId -company @{ id = $Company.id } -ErrorAction Stop
        Add-Cleanup 'Remove-CWMCompanyContact' @{ id = $Contact.id }
        $Contact.id | Should -BeGreaterThan 0

        Update-CWMCompanyContact -id $Contact.id -Operation replace -Path 'title' -Value 'Test contact' -ErrorAction Stop
        (Get-CWMCompanyContact -id $Contact.id -ErrorAction Stop).title | Should -Be 'Test contact'

        Remove-CWMCompanyContact -id $Contact.id -Confirm:$false -ErrorAction Stop
        $script:Created.RemoveAll({ param($i) $i.Command -eq 'Remove-CWMCompanyContact' -and $i.Splat.id -eq $Contact.id }) | Out-Null
        @(Get-CWMCompanyContact -condition "id = $($Contact.id)" -ErrorAction Stop).Count | Should -Be 0
    }

    It 'New/Get/Remove-CWMCompanyNote' {
        $Note = New-CWMCompanyNote -id $Company.id -text "$RunId note" -ErrorAction Stop
        $Note.id | Should -BeGreaterThan 0
        (Get-CWMCompanyNote -CompanyID $Company.id -id $Note.id -ErrorAction Stop).text | Should -Be "$RunId note"
        Remove-CWMCompanyNote -parentId $Company.id -NoteId $Note.id -Confirm:$false -ErrorAction Stop
    }
}

Describe 'Live write: ticket and ticket note' -Tag 'Integration', 'Write' -Skip:$NoWrite {

    BeforeAll {
        $script:TicketCompany = New-CWMCompany -identifier "$($RunId)T" -name "$RunId ticket test" `
            -site @{ name = 'Main' } -types @(@{ id = @(Get-CWMCompanyType -pageSize 1 -ErrorAction Stop)[0].id }) -ErrorAction Stop
        Add-Cleanup 'Remove-CWMCompany' @{ id = $TicketCompany.id }
        $script:Board = @(Get-CWMServiceBoard -condition 'inactiveFlag = false' -pageSize 1 -ErrorAction Stop)[0]
    }

    It 'New/Update/Remove-CWMTicket with a note' {
        $Ticket = New-CWMTicket -summary "$RunId ticket" -company @{ id = $TicketCompany.id } -board @{ id = $Board.id } -ErrorAction Stop
        Add-Cleanup 'Remove-CWMTicket' @{ id = $Ticket.id }
        $Ticket.id | Should -BeGreaterThan 0

        Update-CWMTicket -id $Ticket.id -Operation replace -Path 'summary' -Value "$RunId ticket updated" -ErrorAction Stop
        (Get-CWMTicket -id $Ticket.id -ErrorAction Stop).summary | Should -Be "$RunId ticket updated"

        $Note = New-CWMTicketNote -parentId $Ticket.id -text "$RunId note" -internalAnalysisFlag $true -ErrorAction Stop
        $Note.id | Should -BeGreaterThan 0
        (Get-CWMTicketNote -parentId $Ticket.id -ErrorAction Stop).id | Should -Contain $Note.id
    }
}
