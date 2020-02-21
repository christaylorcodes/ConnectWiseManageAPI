$CWMServer = 'https://staging.connectwisedev.com/'
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
        # API key
        It 'should connect with api key' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMPub
                    privatekey = $env:CWMPriv
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Connected = $true                   
            }
            catch {
                $Connected = $false 
            }
            $Connected | Should -Be $true
        }
        It 'should fail with invalid api key' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = '123'
                    privatekey = $env:CWMPriv
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Connected = $true                   
            }
            catch {
                $Connected = $false 
            }
            $Connected | Should -Be $false
        }
        # Client ID
        It 'should fail with invalid Client ID' {
            try {
                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    pubkey = $env:CWMPub
                    privatekey = $env:CWMPriv
                    clientid = '123'
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Connected = $true                   
            }
            catch {
                $Connected = $false 
            }
            $Connected | Should -Be $false
        }
        # Cookie
        It 'should connect with username and password' {
            try {
                $Password = ConvertTo-SecureString -AsPlainText -Force $env:CWMUserPassword
                $Credentials = New-Object PSCredential $env:CWMUserName, $Password

                $CWMConnectionInfo = @{
                    Server = $CWMServer
                    Company = $env:CWMCompany
                    Credentials = $Credentials
                    clientid = $env:CWMClientID
                }

                Connect-CWM @CWMConnectionInfo -Force -ErrorAction Stop
                $Connected = $true                   
            }
            catch {
                $Connected = $false 
            }
            $Connected | Should -Be $true
        }
    }
}