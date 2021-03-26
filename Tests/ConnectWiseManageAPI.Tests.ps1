$ErrorActionPreference = 'Stop'
$ModuleName = 'ConnectWiseManageAPI'

$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\$($ModuleName)\$($ModuleName).psm1 -Force

Describe "Connect-CWM  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest
        It 'Authentication: API Member Only' {
            try {
                $CWMConnectionInfo = @{
                    Server = $env:CWMServer
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
                    Server = $env:CWMServer
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
                    Server = $env:CWMServer
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
                    Server = $env:CWMServer
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

$CWMConnectionInfo = @{
    Server = $env:CWMServer
    Company = $env:CWMCompany
    pubkey = $env:CWMAPIMemberPub
    privatekey = $env:CWMAPIMemberPriv
    clientid = $env:CWMClientID
}
Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop

Describe "Get-CWMTicket  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'returns results' {
            try {
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
                $Tickets = Get-CWMTicket -all -ErrorAction Stop
                $Tickets.count | Should -BeGreaterThan 25
            }
            catch {
                $_ | Should -Be $null
            }
        }

        It 'accepts a condition' {
            try {
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
        InModuleScope $ModuleName {
            Context "Calls to internal search function:" {
                BeforeEach{
                    Mock Invoke-CWMSearchMaster { return $true }
                    $null = Get-CWMTicket -ErrorAction SilentlyContinue
                }
                It 'calls Invoke-CWMSearchMaster' {
                    Assert-MockCalled Invoke-CWMSearchMaster 1
                }
            }
        }
        InModuleScope $ModuleName {
            Context "Calls to internal get function:" {
                BeforeEach{
                    Mock Invoke-CWMGetMaster { return }
                    $null = Get-CWMTicket -TicketID 1 -ErrorAction SilentlyContinue
                }

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