#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for behaviour that must be identical on Windows PowerShell 5.1 and PowerShell 7.
# Run on both: powershell.exe -c Invoke-Pester ./Tests  and  pwsh -c Invoke-Pester ./Tests
# Requests go to a local HttpListener (Tests/Helpers/CWMTestServer.ps1), so each edition's real
# Invoke-WebRequest exceptions are exercised. No ConnectWise server or network access is needed.

BeforeAll {
    Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
    . "$PSScriptRoot/Helpers/CWMTestServer.ps1"
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'ConvertFrom-CWMJson' {

    It 'writes each element of a top-level array separately' {
        InModuleScope ConnectWiseManageAPI {
            $Result = @(ConvertFrom-CWMJson '[{"id":1},{"id":2}]')
            $Result.Count | Should -Be 2
            $Result[0] | Should -BeOfType [pscustomobject]
            $Result[1].id | Should -Be 2
        }
    }

    It 'returns a single-element array as the element itself' {
        InModuleScope ConnectWiseManageAPI {
            $Result = ConvertFrom-CWMJson '[{"id":1}]'
            $Result | Should -BeOfType [pscustomobject]
            $Result.id | Should -Be 1
        }
    }

    It 'returns a top-level object as itself' {
        InModuleScope ConnectWiseManageAPI {
            $Result = ConvertFrom-CWMJson '{"id":1,"name":"x"}'
            $Result | Should -BeOfType [pscustomobject]
            $Result.name | Should -Be 'x'
        }
    }

    It 'writes nothing for an empty array, empty string or null' {
        InModuleScope ConnectWiseManageAPI {
            @(ConvertFrom-CWMJson '[]').Count | Should -Be 0
            @(ConvertFrom-CWMJson '').Count | Should -Be 0
            @(ConvertFrom-CWMJson $null).Count | Should -Be 0
        }
    }

    It 'keeps nested arrays intact' {
        InModuleScope ConnectWiseManageAPI {
            $Result = @(ConvertFrom-CWMJson '[[1,2],[3]]')
            $Result.Count | Should -Be 2
            $Result[0].Count | Should -Be 2
        }
    }

    It 'gives a flat list when called once per page' {
        InModuleScope ConnectWiseManageAPI {
            function Get-TwoPages { ConvertFrom-CWMJson '[{"id":1},{"id":2}]'; ConvertFrom-CWMJson '[{"id":3}]' }
            $Result = @(Get-TwoPages)
            $Result.Count | Should -Be 3
            $Result.id | Should -Be @(1, 2, 3)
        }
    }

    It 'throws on invalid JSON so callers can report it' {
        InModuleScope ConnectWiseManageAPI {
            { ConvertFrom-CWMJson '{not json' } | Should -Throw
        }
    }
}

Describe 'Get-CWMResponseHeader' {

    It 'joins a string[] header value (PowerShell 7 shape) into one string' {
        InModuleScope ConnectWiseManageAPI {
            $Response = [pscustomobject]@{ Headers = @{ Link = [string[]]@('<a>; rel="next"', '<b>; rel="prev"') } }
            Get-CWMResponseHeader -Response $Response -Name 'Link' | Should -Be '<a>; rel="next", <b>; rel="prev"'
        }
    }

    It 'returns a string header value (5.1 shape) unchanged' {
        InModuleScope ConnectWiseManageAPI {
            $Response = [pscustomobject]@{ Headers = @{ 'api-current-version' = '2025.1' } }
            Get-CWMResponseHeader -Response $Response -Name 'api-current-version' | Should -BeExactly '2025.1'
        }
    }

    It 'returns $null for a missing header or response' {
        InModuleScope ConnectWiseManageAPI {
            Get-CWMResponseHeader -Response ([pscustomobject]@{ Headers = @{} }) -Name 'Link' | Should -BeNullOrEmpty
            Get-CWMResponseHeader -Response $null -Name 'Link' | Should -BeNullOrEmpty
        }
    }
}

Describe 'Invoke-CWMWebRequest against a local HTTP server' {

    BeforeAll {
        $script:TestServer = Start-CWMTestServer
        $script:Url = $script:TestServer.Url
    }

    AfterAll {
        Stop-CWMTestServer $script:TestServer
    }

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'localhost'; Headers = @{ ClientID = 'test' } }
            $script:ErrBody = $null
            Mock Start-Sleep {}
        }
    }

    It 'surfaces the ConnectWise code, message, field errors and HTTP status of a 400' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/error400"; Method = 'Post'; Body = '{}' } -ErrorVariable Err -ErrorAction SilentlyContinue
            $Text = $Err | Out-String
            $Text | Should -Match 'InvalidObject'
            $Text | Should -Match 'Ticket object is invalid'
            $Text | Should -Match 'summary is required'
            $Text | Should -Match 'HTTP status: 400'
            $script:ErrBody.code | Should -Be 'InvalidObject'
        }
    }

    It 'adds the re-authenticate hint for Unauthorized' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/unauthorized" } -ErrorVariable Err -ErrorAction SilentlyContinue
            ($Err | Out-String) | Should -Match "Connect-CWM -Force"
        }
    }

    It 'includes a non-JSON error body and does not retry a 500' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/html500" } -ErrorVariable Err -ErrorAction SilentlyContinue
            ($Err | Out-String) | Should -Match 'proxy error'
            Should -Invoke Start-Sleep -Times 0 -Exactly
        }
        $script:TestServer.State.Counts['/html500'] | Should -Be 1
    }

    It 'retries a GET that fails with 503 and returns the later success' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Result = Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/flaky"; Method = 'Get' } -WarningAction SilentlyContinue
            $Result.StatusCode | Should -Be 200
            Should -Invoke Start-Sleep -Times 1 -Exactly -ParameterFilter { $Seconds -eq 2 }
        }
        $script:TestServer.State.Counts['/flaky'] | Should -Be 2
    }

    It 'never retries a POST that fails with 503 (it may already have been applied)' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/always503"; Method = 'Post'; Body = '{}' } -ErrorAction SilentlyContinue
        }
        $script:TestServer.State.Counts['/always503'] | Should -Be 1
    }

    It 'never retries a POST that fails with 500' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/always500"; Method = 'Post'; Body = '{}' } -ErrorAction SilentlyContinue
        }
        $script:TestServer.State.Counts['/always500'] | Should -Be 1
    }

    It 'retries a 429 on any method and honours Retry-After' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Result = Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/throttled"; Method = 'Post'; Body = '{}' } -WarningAction SilentlyContinue
            $Result.StatusCode | Should -Be 200
            Should -Invoke Start-Sleep -Times 1 -Exactly -ParameterFilter { $Seconds -eq 1 }
        }
        $script:TestServer.State.Counts['/throttled'] | Should -Be 2
    }

    It 'stops after MaxRetry attempts and says so' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/always503" } -MaxRetry 2 -ErrorVariable Err -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            ($Err | Out-String) | Should -Match 'Failed after 2 retries'
            Should -Invoke Start-Sleep -Times 2 -Exactly
        }
    }

    It 'stores api-current-version as a string' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $null = Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/version" }
            $script:CWMServerConnection.'api-current-version' | Should -BeOfType [string]
            $script:CWMServerConnection.'api-current-version' | Should -BeExactly '2025.1'
        }
    }

    It 'does not modify the caller''s hashtable or headers' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Headers = @{ Custom = '1' }
            $Arguments = @{ Uri = "$Url/object"; Headers = $Headers; Version = '2020.1' }
            $null = Invoke-CWMWebRequest -Arguments $Arguments
            $Arguments.ContainsKey('Version') | Should -BeTrue
            $Arguments.ContainsKey('WebSession') | Should -BeFalse
            $Headers.Keys | Should -Be @('Custom')
        }
    }

    It 'debug output summarizes a byte[] body and redacts Authorization' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Arguments = @{ Uri = "$Url/object"; Method = 'Post'; Body = [byte[]](1, 2, 3); Headers = @{ Authorization = 'Basic secret' } }
            # Not -Debug: on 5.1 that means 'Inquire' and would prompt
            $DebugPreference = 'Continue'
            $Debug = Invoke-CWMWebRequest -Arguments $Arguments 5>&1 |
                Where-Object { $_ -is [System.Management.Automation.DebugRecord] }
            $Text = $Debug | Out-String
            $Text | Should -Match '\[3 bytes\]'
            $Text | Should -Match '\[redacted\]'
            $Text | Should -Not -Match 'secret'
            $Arguments.Headers.Authorization | Should -Be 'Basic secret'
        }
    }

    It 'does not change the global ProgressPreference' {
        $global:ProgressPreference = 'Continue'
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $null = Invoke-CWMWebRequest -Arguments @{ Uri = "$Url/object" }
        }
        $global:ProgressPreference | Should -Be 'Continue'
    }

    It 'sends a utf-8 JSON body as UTF-8 bytes' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            Mock New-CWMUrl { "$Url/object" }
            $null = Invoke-CWMNewMaster -Arguments @{ summary = [string][char]0x0142 } -Endpoint '/service/tickets' # l with stroke, not in Latin-1
        }
        # 0x0142 in UTF-8 is C5 82. Latin-1 would have sent '?' (3F).
        $script:TestServer.State.LastBodyHex | Should -Match 'C5 82'
        $script:TestServer.State.LastContentType | Should -Match 'charset=utf-8'
    }

    It 'Invoke-CWMAllResult returns a flat list of records across pages' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            $Result = @(Invoke-CWMAllResult -Arguments @{ Uri = "$Url/page1"; Method = 'Get' })
            $Result.Count | Should -Be 3
            $Result.id | Should -Be @(1, 2, 3)
            $Result | ForEach-Object { $_ | Should -BeOfType [pscustomobject] }
        }
    }
}

Describe 'Master functions' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{ ClientID = 'test' }; BasePath = 'apis/3.0'; Codebase = 'v4_6_release/' }
        }
    }

    It 'Invoke-CWMNewMaster sends JSON with charset=utf-8 by default' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"id":1}' } }
            $null = Invoke-CWMNewMaster -Arguments @{ summary = 'x' } -Endpoint '/service/tickets'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.ContentType -eq 'application/json; charset=utf-8' }
        }
    }

    It 'Invoke-CWMNewMaster keeps a caller-supplied ContentType' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"id":1}' } }
            $null = Invoke-CWMNewMaster -Arguments @{ Body = 'raw'; ContentType = 'multipart/form-data; boundary=x' } -Endpoint '/system/documents'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.ContentType -eq 'multipart/form-data; boundary=x' }
        }
    }

    It 'Invoke-CWMNewMaster summarizes a byte[] body in verbose output instead of failing' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"id":1}' } }
            $Verbose = Invoke-CWMNewMaster -Arguments @{ Body = [byte[]](1, 2, 3); ContentType = 'multipart/form-data; boundary=x' } -Endpoint '/system/documents' -Verbose 4>&1 |
                Where-Object { $_ -is [System.Management.Automation.VerboseRecord] }
            ($Verbose | Out-String) | Should -Match '\[3 bytes\]'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.Body -is [byte[]] }
        }
    }

    It 'Invoke-CWMUpdateMaster sends JSON with charset=utf-8' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"id":1}' } }
            $null = Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'summary'; Value = 'x' } -Endpoint '/service/tickets/1'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.ContentType -eq 'application/json; charset=utf-8' }
        }
    }

    It 'Invoke-CWMGetMaster returns one object for a one-element array and N objects for N' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '[{"id":1}]' } }
            $One = Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets'
            $One | Should -BeOfType [pscustomobject]
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '[{"id":1},{"id":2},{"id":3}]' } }
            @(Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets').Count | Should -Be 3
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '[]' } }
            @(Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets').Count | Should -Be 0
        }
    }
}

Describe 'Connect-CWM authentication branches' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = $null
            Mock Invoke-RestMethod { [pscustomobject]@{ Codebase = 'v4_6_release/' } }
            Mock Get-CWMSystemInfo { [pscustomobject]@{ version = 'v2025.1' } }
        }
    }

    It 'uses impersonation when MemberID is passed with API keys' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"publicKey":"imppub","privateKey":"imppriv","expiration":"2030-01-01T00:00:00Z"}' } }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -MemberID 'jdoe' -Force

            $script:CWMServerConnection.ConnectionMethod | Should -Be 'Impersonation'
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter {
                $Arguments.Uri -like '*/system/members/jdoe/tokens' -and
                $Arguments.Body -is [string] -and $Arguments.Body -match '"memberIdentifier":\s*"jdoe"' -and
                $Arguments.Headers.Authorization -eq ('Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('c+p:k')))
            }
            $Expected = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('c+imppub:imppriv'))
            $script:CWMServerConnection.Headers.Authorization | Should -Be $Expected
        }
    }

    It 'uses plain API key auth without MemberID' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { throw 'should not be called' }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -Force
            $script:CWMServerConnection.ConnectionMethod | Should -Be 'Key'
            Should -Invoke Invoke-CWMWebRequest -Times 0
        }
    }

    It 'returns (instead of breaking out of the caller) when cookie login fails' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"Success":false}' } }
            $Credentials = New-Object PSCredential 'user', (ConvertTo-SecureString 'pw' -AsPlainText -Force)
            $Reached = $false
            foreach ($i in 1) {
                Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -Credentials $Credentials -Force -ErrorAction SilentlyContinue
                $Reached = $true
            }
            $Reached | Should -BeTrue
        }
    }
}

Describe 'TLS setup on module import (Windows PowerShell only)' -Skip:($PSVersionTable.PSEdition -eq 'Core') {

    BeforeAll { $script:SavedProtocol = [Net.ServicePointManager]::SecurityProtocol }
    AfterAll { [Net.ServicePointManager]::SecurityProtocol = $script:SavedProtocol }

    It 'leaves SystemDefault alone so the OS can negotiate TLS 1.2/1.3' {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]0
        Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
        [int][Net.ServicePointManager]::SecurityProtocol | Should -Be 0
    }

    It 'adds TLS 1.2 to an explicit list that lacks it, keeping the existing entries' {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11
        Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
        [Net.ServicePointManager]::SecurityProtocol | Should -Be ([Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12)
    }
}
