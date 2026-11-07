#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline unit tests for New-CWMTicketChild (bundle / merge, issue #34) and Disconnect-CWM.
# Invoke-WebRequest is mocked, so no ConnectWise server or network is needed.

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'New-CWMTicketChild' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{
                Server   = 'example.invalid'
                Codebase = 'v4_6_release'
                BasePath = 'apis/3.0'
                Headers  = @{ ClientID = 'test' }
            }
            Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '{"success":true}'; Headers = @{} } }
        }
    }

    Context 'Bundle' {
        It 'POSTs childTicketIds to attachChildren' {
            InModuleScope ConnectWiseManageAPI {
                New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201, 202 -OperationType Bundle | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = $Body | ConvertFrom-Json
                    $Method -eq 'Post' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/100/attachChildren' -and
                    @($B.PSObject.Properties.Name) -join ',' -eq 'childTicketIds' -and
                    (@($B.childTicketIds) -join ',') -eq '201,202'
                }
            }
        }
        It 'sends a single child ID as a JSON array' {
            InModuleScope ConnectWiseManageAPI {
                New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Body -match '"childTicketIds"\s*:\s*\[\s*201\s*\]'
                }
            }
        }
        It 'returns the parsed response' {
            InModuleScope ConnectWiseManageAPI {
                (New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle).success | Should -BeTrue
            }
        }
        It 'sends nothing with -WhatIf' {
            InModuleScope ConnectWiseManageAPI {
                New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle -WhatIf | Out-Null
                Should -Invoke Invoke-WebRequest -Times 0 -Exactly
            }
        }
        It 'rejects merge-only parameters' {
            InModuleScope ConnectWiseManageAPI {
                { New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Bundle -StatusID 5 } | Should -Throw '*only be used with -OperationType Merge*'
                Should -Invoke Invoke-WebRequest -Times 0 -Exactly
            }
        }
    }

    Context 'Merge' {
        It 'POSTs mergeTicketIds and a nested status object to merge' {
            InModuleScope ConnectWiseManageAPI {
                $Info = @{ status_href = 'https://example.invalid/service/boards/1/statuses/5' }
                New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201, 202 -OperationType Merge -StatusID 5 -StatusName 'Closed' -Sort 3 -_info $Info | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = $Body | ConvertFrom-Json
                    $Method -eq 'Post' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/100/merge' -and
                    (@($B.mergeTicketIds) -join ',') -eq '201,202' -and
                    $B.status.id -eq 5 -and
                    $B.status.name -eq 'Closed' -and
                    $B.status.sort -eq 3 -and
                    # _info must stay a JSON object, not be flattened to a string by a shallow ConvertTo-Json
                    $B.status._info -is [pscustomobject] -and
                    $B.status._info.status_href -eq 'https://example.invalid/service/boards/1/statuses/5'
                }
            }
        }
        It 'sends only the status id when the optional status fields are not given' {
            InModuleScope ConnectWiseManageAPI {
                New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Merge -StatusID 5 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = $Body | ConvertFrom-Json
                    (@($B.status.PSObject.Properties.Name) -join ',') -eq 'id' -and $B.status.id -eq 5
                }
            }
        }
        It 'requires -StatusID for a merge' {
            InModuleScope ConnectWiseManageAPI {
                { New-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -OperationType Merge } | Should -Throw '*requires -StatusID*'
                Should -Invoke Invoke-WebRequest -Times 0 -Exactly
            }
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
        It 'declares StatusName' {
            (Get-Command New-CWMTicketChild).Parameters.ContainsKey('StatusName') | Should -BeTrue
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
}
