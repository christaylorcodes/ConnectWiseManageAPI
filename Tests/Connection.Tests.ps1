#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for Connect-CWM (authentication branches, -AllowInsecureRedirect) and Disconnect-CWM.
# No ConnectWise server or network is needed.

BeforeAll {
    . "$PSScriptRoot/Helpers/TestSetup.ps1"
}

AfterAll {
    Remove-CWMTestSetup
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

Describe 'API version (always the server''s current version)' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = $null
            Mock Invoke-RestMethod { [pscustomobject]@{ Codebase = 'v4_6_release/' } }
            Mock Get-CWMSystemInfo { [pscustomobject]@{ version = 'v2025.1.12345' } }
            Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '{"id":1}'; Headers = @{} } }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -Force
        }
    }

    It 'sends the auto-detected version in the Accept header' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection.Version | Should -BeExactly '2025.1'
            $script:CWMServerConnection.Headers.Accept | Should -BeExactly 'application/vnd.connectwise.com+json; version=2025.1'
            Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets' | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $Headers.Accept -eq 'application/vnd.connectwise.com+json; version=2025.1'
            }
        }
    }

    It 'keeps the detected version when a cached connection is reused' {
        InModuleScope ConnectWiseManageAPI {
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            Should -Invoke Invoke-RestMethod -Times 1 -Exactly
            $script:CWMServerConnection.Headers.Accept | Should -BeExactly 'application/vnd.connectwise.com+json; version=2025.1'
        }
    }

    It 'ignores a Version key in -Arguments: not in the body and the Accept header is unchanged' {
        InModuleScope ConnectWiseManageAPI {
            Invoke-CWMNewMaster -Arguments @{ summary = 'x'; Version = '2019.1' } -Endpoint '/service/tickets' | Out-Null
            Invoke-CWMSetMaster -Arguments @{ id = 5; summary = 'x'; Version = '2019.1' } -Endpoint '/service/tickets/5' | Out-Null
            Should -Invoke Invoke-WebRequest -Times 2 -Exactly -ParameterFilter {
                $Headers.Accept -eq 'application/vnd.connectwise.com+json; version=2025.1' -and
                $Body -match '"summary"' -and $Body -notmatch 'Version' -and $Body -notmatch '2019\.1'
            }
        }
    }

    It 'has no -Version parameter on Connect-CWM' {
        (Get-Command Connect-CWM).Parameters.ContainsKey('Version') | Should -BeFalse
    }

    It 'has a single parameter set on New-CWMTicket without version parameters' {
        $Command = Get-Command New-CWMTicket
        @($Command.ParameterSets).Count | Should -Be 1
        foreach ($Name in 'Version', 'VersionAutomatic', 'project', 'phase', 'wbsCode', 'locationId', 'businessUnitId') {
            $Command.Parameters.ContainsKey($Name) | Should -BeFalse -Because "$Name was removed"
        }
        $Set = $Command.ParameterSets[0]
        ($Set.Parameters | Where-Object IsMandatory).Name | Sort-Object | Should -Be @('company', 'summary')
        @($Set.Parameters | Where-Object Position -GE 0).Count | Should -Be 0
        $Command.Parameters.ContainsKey('mergedParentTicket') | Should -BeTrue
    }
}

Describe 'Invoke-CWMWebRequest insecure redirect workaround' {

    BeforeAll {
        # Pester builds a mock from the real command's signature. On PowerShell < 7.4 (e.g. Windows PowerShell 5.1)
        # Invoke-WebRequest has no -AllowInsecureRedirect, so the tests that force the feature flag on would fail to
        # bind. Shadow it with a stand-in function that accepts the parameter. A function takes precedence over a
        # cmdlet, so Mock picks up this signature instead. In real use the module never sets the flag there.
        InModuleScope ConnectWiseManageAPI {
            if (-not (Get-Command Invoke-WebRequest -CommandType Cmdlet).Parameters.ContainsKey('AllowInsecureRedirect')) {
                function script:Invoke-WebRequest {
                    param($Uri, $Method, $Headers, $Body, $ContentType, $WebSession, $SessionVariable,
                        $MaximumRedirection, [switch]$AllowInsecureRedirect, [switch]$UseBasicParsing)
                }
            }
        }
    }

    AfterAll {
        InModuleScope ConnectWiseManageAPI {
            Remove-Item Function:\Invoke-WebRequest -ErrorAction SilentlyContinue
        }
    }

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMSupportsInsecureRedirect = $true
            $script:CWMServerConnection = @{
                Server                = 'example.invalid'
                Headers               = @{ ClientID = 'test' }
                AllowInsecureRedirect = $true
            }
            Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 201; Headers = @{} } }
        }
    }

    It 'adds AllowInsecureRedirect with MaximumRedirection 0 on POST when enabled' {
        InModuleScope ConnectWiseManageAPI {
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Post'; Headers = @{} } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $AllowInsecureRedirect -eq $true -and $MaximumRedirection -eq 0
            }
        }
    }

    It 'leaves the request alone when the connection did not opt in' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection.AllowInsecureRedirect = $false
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Post'; Headers = @{} } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                -not $AllowInsecureRedirect -and -not $PSBoundParameters.ContainsKey('MaximumRedirection')
            }
        }
    }

    It 'does nothing when PowerShell lacks the parameter (5.1 / 7.0-7.3)' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMSupportsInsecureRedirect = $false
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Post'; Headers = @{} } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                -not $AllowInsecureRedirect -and -not $PSBoundParameters.ContainsKey('MaximumRedirection')
            }
        }
    }

    It 'does not add AllowInsecureRedirect when the caller set a non-zero MaximumRedirection' {
        InModuleScope ConnectWiseManageAPI {
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Post'; Headers = @{}; MaximumRedirection = 5 } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                -not $AllowInsecureRedirect -and $MaximumRedirection -eq 5
            }
        }
    }

    It 'restores the default redirect count on GET instead of disabling the check' {
        InModuleScope ConnectWiseManageAPI {
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Get'; Headers = @{} } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                -not $AllowInsecureRedirect -and $MaximumRedirection -eq 50
            }
        }
    }

    It 'reports an InsecureRedirection error with the may-have-been-created warning' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection.AllowInsecureRedirect = $false
            Mock Invoke-WebRequest {
                throw [System.Management.Automation.ErrorRecord]::new(
                    [System.InvalidOperationException]::new(), 'InsecureRedirection', 'InvalidOperation', $null)
            }
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Post'; Headers = @{} } -ErrorVariable Err -ErrorAction SilentlyContinue
            ($Err | Out-String) | Should -Match 'MAY HAVE BEEN CREATED'
            ($Err | Out-String) | Should -Match 'AllowInsecureRedirect'
        }
    }

    It 'does not say a record may have been created when a GET hits an insecure redirection' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection.AllowInsecureRedirect = $false
            Mock Invoke-WebRequest {
                throw [System.Management.Automation.ErrorRecord]::new(
                    [System.InvalidOperationException]::new(), 'InsecureRedirection', 'InvalidOperation', $null)
            }
            $Err = $null
            Invoke-CWMWebRequest -Arguments @{ Uri = 'https://example.invalid/x'; Method = 'Get'; Headers = @{} } -ErrorVariable Err -ErrorAction SilentlyContinue
            $Text = ($Err | ForEach-Object { $_.ToString() }) -join ' '
            $Text | Should -Match 'insecure redirection'
            $Text | Should -Match 'Nothing was changed'
            $Text | Should -Not -Match 'MAY HAVE BEEN CREATED'
        }
    }
}

Describe 'Connect-CWM -AllowInsecureRedirect on a cached connection' {

    It 'applies the switch without -Force and without contacting the server' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Company = 'c'; ConnectionMethod = 'Key'; Headers = @{} }
            Mock Invoke-RestMethod { throw 'should not be called' }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -AllowInsecureRedirect
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeTrue
            Should -Invoke Invoke-RestMethod -Times 0
        }
    }

    It 'can be turned off again with -AllowInsecureRedirect:$false' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Company = 'c'; ConnectionMethod = 'Key'; Headers = @{}; AllowInsecureRedirect = $true }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -AllowInsecureRedirect:$false
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeFalse
        }
    }

    It 'leaves the setting unchanged when the switch is not passed' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Company = 'c'; ConnectionMethod = 'Key'; Headers = @{}; AllowInsecureRedirect = $true }
            Mock Invoke-RestMethod { throw 'should not be called' }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeTrue
        }
    }
}

Describe 'Disconnect-CWM' {

    It 'removes every connection variable' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{ Authorization = 'Basic x' } }
            $script:CWMSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            Disconnect-CWM
            Get-Variable -Name CWMServerConnection -Scope Script -ErrorAction SilentlyContinue | Should -BeNullOrEmpty
            Get-Variable -Name CWMSession -Scope Script -ErrorAction SilentlyContinue | Should -BeNullOrEmpty
        }
    }

    It 'leaves the module feature flags in place' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid' }
            Disconnect-CWM
            Get-Variable -Name CWMSupportsInsecureRedirect -Scope Script -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
            Get-Variable -Name CWMJsonSupportsNoEnumerate -Scope Script -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
        }
    }

    It 'is a quiet no-op when called twice' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid' }
            $script:CWMSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            Disconnect-CWM -ErrorVariable First
            Disconnect-CWM -ErrorVariable Second -Verbose 4>&1 | Out-String | Should -Match 'No ConnectWise Manage connection'
            $First | Should -BeNullOrEmpty
            $Second | Should -BeNullOrEmpty
        }
    }

    It 'does not error when only the cookie session is left' {
        InModuleScope ConnectWiseManageAPI {
            Remove-Variable -Name CWMServerConnection -Scope Script -ErrorAction SilentlyContinue
            $script:CWMSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            { Disconnect-CWM -ErrorAction Stop } | Should -Not -Throw
            Get-Variable -Name CWMSession -Scope Script -ErrorAction SilentlyContinue | Should -BeNullOrEmpty
        }
    }

    It 'causes other calls to fail after it runs' {
        Set-CWMTestConnection
        Disconnect-CWM
        { Get-CWMSystemInfo -ErrorAction Stop } | Should -Throw
    }
}

Describe 'Connect-CWM connection state (0.5.0 review)' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = $null
            $script:CWMSession = $null
            Mock Invoke-RestMethod { [pscustomobject]@{ Codebase = 'v4_6_release/' } }
            Mock Get-CWMSystemInfo { [pscustomobject]@{ version = 'v2025.1' } }
        }
    }

    It 'leaves no connection (not even the previous one) when <Case> fails' -ForEach @(
        @{ Case = 'impersonation' }
        @{ Case = 'cookie login' }
        @{ Case = 'validation' }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Case = $Case } {
            param($Case)
            $script:CWMServerConnection = @{ Server = 'old.invalid'; Company = 'c'; ConnectionMethod = 'Key'; Headers = @{ Authorization = 'Basic old' } }
            $script:CWMSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            $Base = @{ Server = 'example.invalid'; Company = 'c'; ClientID = 'id'; Force = $true; ErrorAction = 'SilentlyContinue'; WarningAction = 'SilentlyContinue' }
            switch ($Case) {
                'impersonation' {
                    Mock Invoke-CWMWebRequest { Write-Error 'token failure' }
                    Connect-CWM @Base -PubKey 'p' -PrivateKey 'k' -MemberID 'jdoe'
                }
                'cookie login' {
                    Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"Success":false}' } }
                    Connect-CWM @Base -Credentials (New-Object PSCredential 'user', (ConvertTo-SecureString 'pw' -AsPlainText -Force))
                }
                'validation' {
                    Mock Get-CWMSystemInfo { }
                    Connect-CWM @Base -PubKey 'p' -PrivateKey 'k'
                }
            }
            $script:CWMServerConnection | Should -BeNullOrEmpty
            $script:CWMSession | Should -BeNullOrEmpty
        }
    }

    It 'connects again after a failed impersonation instead of reusing a half-built connection' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { Write-Error 'token failure' }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -MemberID 'jdoe' -ErrorAction SilentlyContinue
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            $script:CWMServerConnection.ConnectionMethod | Should -Be 'Key'
            Should -Invoke Invoke-RestMethod -Times 2 -Exactly
        }
    }

    It 'connects again without -Force when the <Change> changes' -ForEach @(
        @{ Change = 'server'; Second = @{ Server = 'other.invalid'; Company = 'c'; PubKey = 'p'; PrivateKey = 'k' } }
        @{ Change = 'company'; Second = @{ Server = 'example.invalid'; Company = 'other'; PubKey = 'p'; PrivateKey = 'k' } }
        @{ Change = 'sign-in method'; Second = @{ Server = 'example.invalid'; Company = 'c'; PubKey = 'p'; PrivateKey = 'k'; MemberID = 'jdoe' } }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Second = $Second } {
            param($Second)
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"publicKey":"ip","privateKey":"ik","expiration":"2099-01-01T00:00:00Z"}' } }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            Connect-CWM @Second -ClientID 'id'
            Should -Invoke Invoke-RestMethod -Times 2 -Exactly
            $script:CWMServerConnection.Server | Should -Be $Second.Server
            $script:CWMServerConnection.Company | Should -Be $Second.Company
        }
    }

    It 'reuses the cached connection for the same server, company and sign-in method' {
        InModuleScope ConnectWiseManageAPI {
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            Connect-CWM -Server 'https://EXAMPLE.invalid/' -Company 'C' -ClientID 'id' -PubKey 'p2' -PrivateKey 'k2'
            Should -Invoke Invoke-RestMethod -Times 1 -Exactly
        }
    }

    It 'drops a stale cookie session when an API key connection is made' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -Force
            $script:CWMSession | Should -BeNullOrEmpty
            $script:CWMServerConnection.Session | Should -BeNullOrEmpty
        }
    }

    It 'marks the cookie-session cookies Secure and stores the session only on success' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"Success":true,"Hash":"HASH1"}' } }
            Connect-CWM -Server 'example.invalid:8443' -Company 'c' -ClientID 'id' -Credentials (New-Object PSCredential 'user', (ConvertTo-SecureString 'pw' -AsPlainText -Force))
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter {
                $Arguments.WebSession -is [Microsoft.PowerShell.Commands.WebRequestSession] -and -not $Arguments.SessionVariable
            }
            $script:CWMServerConnection.ConnectionMethod | Should -Be 'Cookie'
            [object]::ReferenceEquals($script:CWMSession, $script:CWMServerConnection.Session) | Should -BeTrue
            $Cookies = @($script:CWMSession.Cookies.GetCookies([uri]'https://example.invalid:8443/'))
            ($Cookies.Name | Sort-Object) -join ',' | Should -Be 'companyName,MemberContext,memberHash,MemberID'
            $Cookies | ForEach-Object { $_.Secure | Should -BeTrue -Because "$($_.Name) holds session data" }
            @($script:CWMSession.Cookies.GetCookies([uri]'http://example.invalid:8443/')).Count | Should -Be 0
        }
    }

    It 'rejects the -Server value <Server>' -ForEach @(
        @{ Server = 'na.example.net@evil.invalid' }
        @{ Server = 'https://user:pw@evil.invalid' }
        @{ Server = 'evil.invalid#' }
        @{ Server = 'evil.invalid?x=1' }
        @{ Server = 'evil.invalid\x' }
        @{ Server = 'evil invalid' }
        @{ Server = 'https://' }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Server = $Server } {
            param($Server)
            { Connect-CWM -Server $Server -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -Force } | Should -Throw '*Invalid -Server*'
            Should -Invoke Invoke-RestMethod -Times 0
            $script:CWMServerConnection | Should -BeNullOrEmpty
        }
    }

    It 'accepts the -Server value <Server> as <Expected>' -ForEach @(
        @{ Server = 'na.myconnectwise.net'; Expected = 'na.myconnectwise.net' }
        @{ Server = 'cw.company.com'; Expected = 'cw.company.com' }
        @{ Server = 'cw.company.com:8443'; Expected = 'cw.company.com:8443' }
        @{ Server = 'https://na.myconnectwise.net/'; Expected = 'na.myconnectwise.net' }
        @{ Server = 'HTTPS://cw.company.com/v4_6_release/apis/3.0'; Expected = 'cw.company.com' }
        @{ Server = 'http://cw.company.com'; Expected = 'cw.company.com' }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Server = $Server; Expected = $Expected } {
            param($Server, $Expected)
            Connect-CWM -Server $Server -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -Force
            $script:CWMServerConnection.Server | Should -BeExactly $Expected
            Should -Invoke Invoke-RestMethod -Times 1 -Exactly -ParameterFilter { ([uri]$Uri).OriginalString -eq "https://$Expected/login/companyinfo/c" }
        }
    }

    It 'URL-escapes Company and MemberID' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"publicKey":"ip","privateKey":"ik","expiration":"2099-01-01T00:00:00Z"}' } }
            Connect-CWM -Server 'example.invalid' -Company 'My Co/1' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -MemberID 'j doe/x?y' -Force
            Should -Invoke Invoke-RestMethod -Times 1 -Exactly -ParameterFilter { ([uri]$Uri).OriginalString -eq 'https://example.invalid/login/companyinfo/My%20Co%2F1' }
            Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter {
                $Arguments.Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/system/members/j%20doe%2Fx%3Fy/tokens' -and
                $Arguments.Body -match '"memberIdentifier":\s*"j doe/x\?y"'
            }
            $script:CWMServerConnection.MemberID | Should -Be 'j doe/x?y'
        }
    }

    It 'sends requests as the impersonated member, not with the API key' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '{"publicKey":"imppub","privateKey":"imppriv","expiration":"2099-01-01T00:00:00Z"}' } }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -MemberID 'jdoe' -Force
            $ApiKeyAuth = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes('c+p:k'))
            $script:CWMServerConnection.Headers.Authorization | Should -Not -Be $ApiKeyAuth
            $script:CWMServerConnection.Headers.ContainsKey('x-cw-usertype') | Should -BeFalse
            $script:CWMServerConnection.Expiration | Should -BeOfType [datetime]
        }
    }
}

Describe 'New-CWMDebugReport' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            Mock Get-CWMSystemInfo { [pscustomobject]@{ version = 'v2025.1' } }
            $Session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            $Session.Cookies.Add((New-Object System.Net.Cookie 'memberHash', 'HASHSECRET', '/', 'example.invalid'))
            $script:CWMServerConnection = @{
                Server           = 'example.invalid'
                Company          = 'c'
                ConnectionMethod = 'Key'
                Codebase         = 'v4_6_release/'
                BasePath         = 'apis/3.0'
                Headers          = @{ Authorization = 'Basic AUTHSECRET'; ClientID = 'CLIENTSECRET' }
                Session          = $Session
            }
        }
    }

    It 'never includes headers or the session, even with -Hash:$false' {
        $Report = New-CWMDebugReport -Hash:$false
        $Report | Should -Not -Match 'AUTHSECRET|CLIENTSECRET|HASHSECRET|Authorization|Cookies'
        $Report | Should -Match 'example\.invalid'
        $Report | Should -Match '"ConnectionMethod":\s*"Key"'
        ($Report | ConvertFrom-Json).PSObject.Properties.Name | Should -Not -Contain 'Errors'
    }

    It 'hashes the server name by default' {
        $Report = New-CWMDebugReport
        $Report | Should -Not -Match 'example\.invalid|AUTHSECRET'
    }
}
