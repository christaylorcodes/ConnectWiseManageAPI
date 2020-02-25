$CWMServer = 'https://api-staging.connectwisedev.com/'
$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psm1 -Force

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

Describe "Get-CWMContact  PS$PSVersion Integrations tests" {

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
                $Contacts = Get-CWMContact -ErrorAction Stop
                $Result = ($Contacts | Measure-Object).Count
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be 25
        }
    }
}