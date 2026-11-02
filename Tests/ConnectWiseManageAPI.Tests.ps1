$ErrorActionPreference = 'Stop'
$ModuleName = 'ConnectWiseManageAPI'

$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master") {
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\$($ModuleName)\$($ModuleName).psm1 -Force

Describe "Parameters PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest
        It 'Get function fields' {
            $MandatoryParams = @('condition', 'orderBy', 'childConditions', 'customFieldConditions', 'page', 'pageSize', 'fields', 'all')
            $ExcludeFunction = @('Get-CWMChargeCode','Get-CWMReportColumn', 'Get-CWMSystemInfo')
            try {
                $GetFunctions = (Get-Module ConnectWiseManageAPI).ExportedCommands.Keys | Where-Object {$_ -like 'Get-CWM*'}
                foreach($Function in $GetFunctions){
                    if($ExcludeFunction -contains $Function){ continue }
                    $FunctionParams = (Get-Command $Function).Parameters.Keys
                    foreach($TestParam in $MandatoryParams){
                        if($FunctionParams -notcontains $TestParam){
                            Write-Output "$Function is missing, $TestParam"
                        }
                    }

                }
            }
            catch {
                $Result = $_
            }
            $Result | Should -Be $null
        }
    }
}


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
        It 'Get function fields' {
            $MandatoryParams = @('condition', 'orderBy', 'childConditions', 'customFieldConditions', 'page', 'pageSize', 'fields', 'all')
            try {
                $GetFunctions = (Get-Module ConnectWiseManageAPI).ExportedCommands.Keys | Where-Object {$_ -like 'Get-CWM*'}
                foreach($Function in $GetFunctions){
                    $FunctionParams = (Get-Command $Function).Parameters.Keys
                    foreach($TestParam in $MandatoryParams){
                        if($FunctionParams -notcontains $TestParam){
                            Write-Output "$Function is missing, $TestParam"
                        }
                    }

                }
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
                $conditions = @('closedFlag = false','closedFlag = true','board/id = 1')
                foreach($condition in $conditions){
                    $Tickets = Get-CWMTicket -Condition $condition -ErrorAction Stop
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

Describe "Invoke-CWMWebRequest  PS$PSVersion redirect handling tests" {
    Context 'Redirect responses' {
        BeforeEach {
            InModuleScope $ModuleName {
                $script:CWMServerConnection = @{ Headers = @{ Accept = 'application/json' }; Session = $null; Version = '2025.1' }
            }
        }
        AfterEach {
            InModuleScope $ModuleName { $script:CWMServerConnection = $null }
        }

        It 'refuses an HTTPS to HTTP redirect without following it' {
            Mock -ModuleName $ModuleName Invoke-WebRequest { [pscustomobject]@{ StatusCode = 307; Headers = @{ Location = 'http://example.test/insecure' } } }
            $Arguments = @{ Uri = 'https://example.test/api'; Method = 'Post'; Body = '{}'; Headers = @{} }
            $Err = $null
            $null = Invoke-CWMWebRequest -Arguments $Arguments -ErrorVariable Err -ErrorAction SilentlyContinue
            "$Err" | Should -Match 'Refused insecure redirect'
            Assert-MockCalled -ModuleName $ModuleName Invoke-WebRequest -Exactly 1 -Scope It
        }
        It 'refuses to turn a POST into a GET on a 302' {
            Mock -ModuleName $ModuleName Invoke-WebRequest { [pscustomobject]@{ StatusCode = 302; Headers = @{ Location = 'https://example.test/other' } } }
            $Arguments = @{ Uri = 'https://example.test/api'; Method = 'Post'; Body = '{}'; Headers = @{} }
            $Err = $null
            $null = Invoke-CWMWebRequest -Arguments $Arguments -ErrorVariable Err -ErrorAction SilentlyContinue
            "$Err" | Should -Match 'Refused redirect'
            Assert-MockCalled -ModuleName $ModuleName Invoke-WebRequest -Exactly 1 -Scope It
        }
        It 'follows a same-host HTTPS 307 for a POST' {
            Mock -ModuleName $ModuleName Invoke-WebRequest { [pscustomobject]@{ StatusCode = 307; Headers = @{ Location = '/moved' } } } -ParameterFilter { $Uri -eq 'https://example.test/api' }
            Mock -ModuleName $ModuleName Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Headers = @{} } } -ParameterFilter { $Uri -eq 'https://example.test/moved' }
            $Arguments = @{ Uri = 'https://example.test/api'; Method = 'Post'; Body = '{}'; Headers = @{} }
            $Result = Invoke-CWMWebRequest -Arguments $Arguments -ErrorAction Stop
            $Result.StatusCode | Should -Be 200
            Assert-MockCalled -ModuleName $ModuleName Invoke-WebRequest -Exactly 2 -Scope It
        }
    }
}

Describe "New-CWMCompanyServiceTemplate  PS$PSVersion body tests" {
    Context 'Company default' {
        It 'defaults company to the parent company' {
            Mock -ModuleName $ModuleName Invoke-CWMNewMaster { $Arguments }
            $Result = New-CWMCompanyServiceTemplate -parentId 20371 -name 'T' -board @{ id = 1 } -status @{ id = 2 } -summary 'S'
            $Result.company.id | Should -Be 20371
        }
        It 'keeps a supplied company' {
            Mock -ModuleName $ModuleName Invoke-CWMNewMaster { $Arguments }
            $Result = New-CWMCompanyServiceTemplate -parentId 20371 -name 'T' -board @{ id = 1 } -status @{ id = 2 } -summary 'S' -company @{ id = 5 }
            $Result.company.id | Should -Be 5
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