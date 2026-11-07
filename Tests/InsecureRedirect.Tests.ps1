#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Unit tests for the Connect-CWM -AllowInsecureRedirect workaround. No ConnectWise server or network needed.

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
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
}

Describe 'Connect-CWM -AllowInsecureRedirect on a cached connection' {

    It 'applies the switch without -Force and without contacting the server' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{} }
            Mock Invoke-RestMethod { throw 'should not be called' }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -AllowInsecureRedirect
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeTrue
            Should -Invoke Invoke-RestMethod -Times 0
        }
    }

    It 'can be turned off again with -AllowInsecureRedirect:$false' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{}; AllowInsecureRedirect = $true }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k' -AllowInsecureRedirect:$false
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeFalse
        }
    }

    It 'leaves the setting unchanged when the switch is not passed' {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{ Server = 'example.invalid'; Headers = @{}; AllowInsecureRedirect = $true }
            Connect-CWM -Server 'example.invalid' -Company 'c' -ClientID 'id' -PubKey 'p' -PrivateKey 'k'
            $script:CWMServerConnection.AllowInsecureRedirect | Should -BeTrue
        }
    }
}
