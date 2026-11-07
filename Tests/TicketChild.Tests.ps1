#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for New-CWMTicketChild (bundle / merge, issue #34). Invoke-WebRequest is mocked.

BeforeAll {
    . "$PSScriptRoot/Helpers/TestSetup.ps1"
}

AfterAll {
    Remove-CWMTestSetup
}

Describe 'New-CWMTicketChild' {

    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse -Content '{"success":true}'
    }

    Context 'Bundle' {
        It 'POSTs childTicketIds to attachChildren and returns the parsed response' {
            $Result = New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201, 202 -OperationType Bundle
            $Result.success | Should -BeTrue
            $global:CWMTestRequests | Should -HaveCount 1
            $Request = $global:CWMTestRequests[0]
            $Request.Method | Should -Be 'Post'
            $Request.Uri | Should -Be "$CWMTestBaseUri/service/tickets/100/attachChildren"
            $B = $Request.Body | ConvertFrom-Json
            @($B.PSObject.Properties.Name) | Should -Be @('childTicketIds')
            @($B.childTicketIds) -join ',' | Should -Be '201,202'
        }
        It 'sends a single child ID as a JSON array' {
            New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle | Out-Null
            $global:CWMTestRequests[0].Body | Should -Match '"childTicketIds"\s*:\s*\[\s*201\s*\]'
        }
        It 'sends nothing with -WhatIf' {
            New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle -WhatIf | Out-Null
            $global:CWMTestRequests | Should -HaveCount 0
        }
        It 'rejects merge-only parameters' {
            { New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle -StatusID 5 } | Should -Throw '*only be used with -OperationType Merge*'
            $global:CWMTestRequests | Should -HaveCount 0
        }
    }

    Context 'Merge' {
        It 'POSTs mergeTicketIds and a nested status object to merge' {
            $Info = @{ status_href = 'https://example.invalid/service/boards/1/statuses/5' }
            New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201, 202 -OperationType Merge -StatusID 5 -StatusName 'Closed' -Sort 3 -_info $Info | Out-Null
            $Request = $global:CWMTestRequests[0]
            $Request.Method | Should -Be 'Post'
            $Request.Uri | Should -Be "$CWMTestBaseUri/service/tickets/100/merge"
            $B = $Request.Body | ConvertFrom-Json
            @($B.mergeTicketIds) -join ',' | Should -Be '201,202'
            $B.status.id | Should -Be 5
            $B.status.name | Should -Be 'Closed'
            $B.status.sort | Should -Be 3
            # _info must stay a JSON object, not be flattened to a string by a shallow ConvertTo-Json
            $B.status._info | Should -BeOfType [pscustomobject]
            $B.status._info.status_href | Should -Be 'https://example.invalid/service/boards/1/statuses/5'
        }
        It 'sends only the status id when the optional status fields are not given' {
            New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Merge -StatusID 5 | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            @($B.status.PSObject.Properties.Name) | Should -Be @('id')
            $B.status.id | Should -Be 5
        }
        It 'requires -StatusID for a merge' {
            { New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Merge } | Should -Throw '*requires -StatusID*'
            $global:CWMTestRequests | Should -HaveCount 0
        }
    }

    Context 'Parameters' {
        It '<Name> is mandatory in every parameter set' -ForEach @(
            @{ Name = 'ParentTicketID' }
            @{ Name = 'ChildTicketIDs' }
            @{ Name = 'OperationType' }
        ) {
            $Attributes = (Get-Command New-CWMTicketChild).Parameters[$Name].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] })
            $Attributes.Mandatory | Should -Not -Contain $false
            $Attributes.Mandatory | Should -Contain $true
        }
        It 'StatusID is mandatory in the Merge set' {
            $Attributes = (Get-Command New-CWMTicketChild).Parameters['StatusID'].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] })
            ($Attributes | Where-Object ParameterSetName -EQ 'Merge').Mandatory | Should -BeTrue
        }
        It 'rejects a parent ticket ID of 0' {
            { New-CWMTicketChild -ParentTicketID 0 -ChildTicketIDs 201 -OperationType Bundle } | Should -Throw
        }
    }

    Context 'Help' {
        It 'has bundle, merge and unbundle examples' {
            $Help = Get-Help New-CWMTicketChild -Full
            $Help.Synopsis | Should -Not -BeNullOrEmpty
            # Windows PowerShell 5.1 puts example lines after the first into the remarks, so search the whole text
            $Code = $Help.Examples | Out-String -Width 500
            $Code | Should -Match 'OperationType Bundle'
            $Code | Should -Match 'OperationType Merge'
            $Code | Should -Match 'parentTicketId'
        }
    }
}
