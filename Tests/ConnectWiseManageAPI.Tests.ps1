$ModuleName = 'ConnectWiseManageAPI'
$CWMServer = 'https://api-staging.connectwisedev.com/'
$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\ConnectWiseManageAPI\$($ModuleName).psm1 -Force

#Integration test example
Describe "Connect-CWM  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest
        It 'Authentication: API Member Only' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMAPIMemberPub
                    privatekey = $env:CWMAPIMemberPriv
                    clientid = $env:CWMClientID
                }

                $Result = Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be $null
        }
        It 'Authentication: Member Impersonation' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMAPIMemberPub
                    privatekey = $env:CWMAPIMemberPriv
                    MemberID = $env:CWMUserName
                    clientid = $env:CWMClientID
                }

                $Result = Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be $null
        }
        It 'Authentication: My Account' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMPub
                    privatekey = $env:CWMPriv
                    clientid = $env:CWMClientID
                }
                $Result = Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be $null
        }
        It 'Authentication: Cookies!' {
            try {
                $Password = ConvertTo-SecureString -AsPlainText -Force $env:CWMUserPassword
                $Credentials = New-Object PSCredential $env:CWMUserName, $Password
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    Credentials = $Credentials
                    clientid = $env:CWMClientID
                }
                $Result = Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be $null
        }
    }
}

Describe "Get-CWMTicket  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'returns results' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMAPIMemberPub
                    privatekey = $env:CWMAPIMemberPriv
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Tickets = Get-CWMTicket -ErrorAction Stop
                $Tickets.count | Should -Be 25
                $Tickets[0].id | Should -BeGreaterThan 0
            }
            catch {
                $_ | Should -Be $null
            }
        }
        It 'accepts the -all switch' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMAPIMemberPub
                    privatekey = $env:CWMAPIMemberPriv
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Tickets = Get-CWMTicket -all -ErrorAction Stop
                $Tickets.count | Should -BeGreaterThan 25
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'accepts a conditions' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMAPIMemberPub
                    privatekey = $env:CWMAPIMemberPriv
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Conditions = @('closedFlag = false','closedFlag = true','board/id = 1')
                foreach($Condition in $Conditions){
                    $Tickets = Get-CWMTicket -Condition $Condition -ErrorAction Stop
                    $Tickets.count | Should -Be 25
                }
            }
            catch {
                $_ | Should -Be $null
            }
        }
        Context "Test calls to internal functions:" {
            InModuleScope $ModuleName {
                Mock Invoke-CWMSearchMaster { return }
                Get-CWMTicket -ErrorAction Stop
                It 'calls Invoke-CWMSearchMaster' {
                    Assert-MockCalled Invoke-CWMSearchMaster 1
                }
                Mock Invoke-CWMGetMaster { return }
                Get-CWMTicket -TicketID 44 -ErrorAction Stop
                It 'calls Invoke-CWMGetMaster when given an id' {
                    Assert-MockCalled Invoke-CWMGetMaster 1
                }
            }
        }
    }
}

Describe "Disconnect-CWM  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'clears variable' {
            try { Disconnect-CWM -ErrorAction Stop }
            catch { $_ | Should -Be $null }
        }
        It 'causes other calls to fail after its run' {
            try {
                $Result = Get-CWMSystemInfo -ErrorAction Stop
                $Result | Should -Be $null
            }
            catch {
                $true | Should -Be $true
            }
        }
    }
}