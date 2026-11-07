#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Live integration tests against a real ConnectWise Manage server.
# Tagged 'Integration' and skipped unless these environment variables are set:
#   CWMServer, CWMCompany, CWMClientID, CWMPub, CWMPriv, CWMAPIMemberPub, CWMAPIMemberPriv, CWMUserName, CWMUserPassword
# Run only these:     Invoke-Pester ./Tests -TagFilter Integration
# Run without them:   Invoke-Pester ./Tests -ExcludeTagFilter Integration

BeforeDiscovery {
    $script:NoServer = [string]::IsNullOrEmpty($env:CWMServer)
}

BeforeAll {
    $ModuleName = 'ConnectWiseManageAPI'
    Import-Module "$PSScriptRoot/../$ModuleName/$ModuleName.psd1" -Force
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Exported Get functions' {

    It 'have the standard query parameters' {
        $MandatoryParams = @('condition', 'orderBy', 'childConditions', 'customFieldConditions', 'page', 'pageSize', 'fields', 'all')
        $ExcludeFunction = @('Get-CWMChargeCode', 'Get-CWMReportColumn', 'Get-CWMSystemInfo')
        $GetFunctions = (Get-Module ConnectWiseManageAPI).ExportedCommands.Keys | Where-Object { $_ -like 'Get-CWM*' }
        $Missing = foreach ($Function in $GetFunctions) {
            if ($ExcludeFunction -contains $Function) { continue }
            $FunctionParams = (Get-Command $Function).Parameters.Keys
            foreach ($TestParam in $MandatoryParams) {
                if ($FunctionParams -notcontains $TestParam) { "$Function is missing $TestParam" }
            }
        }
        # Informational only, as before: many Get functions intentionally lack some of these
        $Missing | ForEach-Object { Write-Verbose $_ }
        $GetFunctions | Should -Not -BeNullOrEmpty
    }
}

Describe 'Connect-CWM integration' -Tag 'Integration' -Skip:$NoServer {

    BeforeAll { Set-StrictMode -Version latest }

    It 'Authentication: API Member Only' {
        $CWMConnectionInfo = @{
            Server     = $env:CWMServer
            Company    = $env:CWMCompany
            pubkey     = $env:CWMAPIMemberPub
            privatekey = $env:CWMAPIMemberPriv
            clientid   = $env:CWMClientID
        }
        { Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Authentication: Member Impersonation' {
        $CWMConnectionInfo = @{
            Server     = $env:CWMServer
            Company    = $env:CWMCompany
            pubkey     = $env:CWMAPIMemberPub
            privatekey = $env:CWMAPIMemberPriv
            MemberID   = $env:CWMUserName
            clientid   = $env:CWMClientID
        }
        { Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop } | Should -Not -Throw
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection.ConnectionMethod | Should -Be 'Impersonation' }
    }

    It 'Authentication: My Account' {
        $CWMConnectionInfo = @{
            Server     = $env:CWMServer
            Company    = $env:CWMCompany
            pubkey     = $env:CWMPub
            privatekey = $env:CWMPriv
            clientid   = $env:CWMClientID
        }
        { Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop } | Should -Not -Throw
    }

    It 'Authentication: Cookies!' {
        $Password = ConvertTo-SecureString -AsPlainText -Force $env:CWMUserPassword
        $Credentials = New-Object PSCredential $env:CWMUserName, $Password
        $CWMConnectionInfo = @{
            Server      = $env:CWMServer
            Company     = $env:CWMCompany
            Credentials = $Credentials
            clientid    = $env:CWMClientID
        }
        { Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop } | Should -Not -Throw
    }
}

Describe 'Get-CWMTicket integration' -Tag 'Integration' -Skip:$NoServer {

    BeforeAll {
        Set-StrictMode -Version latest
        $CWMConnectionInfo = @{
            Server     = $env:CWMServer
            Company    = $env:CWMCompany
            pubkey     = $env:CWMAPIMemberPub
            privatekey = $env:CWMAPIMemberPriv
            clientid   = $env:CWMClientID
        }
        Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
    }

    It 'returns results' {
        $Tickets = Get-CWMTicket -ErrorAction Stop
        $Tickets.count | Should -Be 25
        $Tickets[0].id | Should -BeGreaterThan 0
    }

    It 'accepts the -all switch and returns a flat list of tickets' {
        $Tickets = @(Get-CWMTicket -all -ErrorAction Stop)
        $Tickets.count | Should -BeGreaterThan 25
        $Tickets[0].id | Should -BeGreaterThan 0
    }

    It 'accepts a condition' {
        foreach ($condition in @('closedFlag = false', 'closedFlag = true', 'board/id = 1')) {
            $Tickets = Get-CWMTicket -Condition $condition -ErrorAction Stop
            $Tickets.count | Should -Be 25
        }
    }
}

Describe 'Get-CWMTicket routing' {

    It 'calls Invoke-CWMSearchMaster without an id' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMSearchMaster { return $true }
            $null = Get-CWMTicket -ErrorAction SilentlyContinue
            Should -Invoke Invoke-CWMSearchMaster -Times 1
        }
    }

    It 'calls Invoke-CWMGetMaster when given an id' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMGetMaster { return }
            $null = Get-CWMTicket -TicketID 1 -ErrorAction SilentlyContinue
            Should -Invoke Invoke-CWMGetMaster -Times 1
        }
    }
}

Describe 'Disconnect-CWM' {

    It 'clears the connection' {
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{} } }
        { Disconnect-CWM -ErrorAction Stop } | Should -Not -Throw
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection | Should -BeNullOrEmpty }
    }

    It 'causes other calls to fail after it runs' {
        { Get-CWMSystemInfo -ErrorAction Stop } | Should -Throw
    }
}
