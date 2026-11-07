#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline unit tests for the master function changes (GetMaster id/pageId, ActionMaster, SetMaster,
# UpdateMaster PatchOperations for issue #53, NewMaster id 0 warning), the Update-* parameter set pattern
# (Update-CWMProductCatalog) and the endpoint functions ported from PR #82.
# Invoke-WebRequest is mocked (or a local HttpListener is used), so no ConnectWise server or network is needed.
# The PR #82 functions are not in FunctionsToExport yet, so they are called inside InModuleScope.

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force
    . "$PSScriptRoot/Helpers/CWMTestServer.ps1"
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Step A master functions' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{
                Server   = 'example.invalid'
                Codebase = 'v4_6_release'
                BasePath = 'apis/3.0'
                Headers  = @{ ClientID = 'test' }
            }
            Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '{}'; Headers = @{} } }
        }
    }

    Context 'Invoke-CWMGetMaster' {
        It 'builds the URL from $Arguments.id when no $id is in scope' {
            InModuleScope ConnectWiseManageAPI {
                & {
                    Remove-Variable -Name id -ErrorAction SilentlyContinue
                    Invoke-CWMGetMaster -Arguments @{ id = 7 } -Endpoint '/service/tickets' | Out-Null
                }
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/7'
                }
            }
        }
        It 'ignores an $id variable in the caller scope' {
            InModuleScope ConnectWiseManageAPI {
                & {
                    $id = 999
                    $null = $id
                    Invoke-CWMGetMaster -Arguments @{ id = 7 } -Endpoint '/service/tickets' | Out-Null
                    Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/boards' | Out-Null
                }
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/7' }
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/boards' }
                Should -Invoke Invoke-WebRequest -Times 0 -ParameterFilter { $Uri -like '*999*' }
            }
        }
        It 'adds pageId to the query string' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMGetMaster -Arguments @{ pageId = 50; pageSize = 10 } -Endpoint '/service/tickets' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets?pageId=50&pageSize=10'
                }
            }
        }
        It 'adds pageId after the other query parameters' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMGetMaster -Arguments @{ condition = 'id>1'; pageId = 0 } -Endpoint '/service/tickets' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets?conditions=id%3e1&pageId=0'
                }
            }
        }
        It 'sends no pageId when it is not given' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMGetMaster -Arguments @{ condition = 'id>1' } -Endpoint '/service/tickets' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 0 -ParameterFilter { $Uri -like '*pageId*' }
            }
        }
    }

    Context 'Invoke-CWMActionMaster' {
        It 'sends a POST with no body and no content type' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMActionMaster -Endpoint '/company/companies/1/serviceTemplates/2/link' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'Post' -and $null -eq $Body -and $null -eq $ContentType -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/company/companies/1/serviceTemplates/2/link'
                }
            }
        }
        It 'sends nothing with -WhatIf' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMActionMaster -Endpoint '/x' -WhatIf | Out-Null
                Should -Invoke Invoke-WebRequest -Times 0
            }
        }
        It 'converts a JSON response' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '{"id":5}'; Headers = @{} } }
                (Invoke-CWMActionMaster -Endpoint '/x').id | Should -Be 5
            }
        }
    }

    Context 'Invoke-CWMSetMaster' {
        It 'sends a PUT with a utf-8 JSON body without route ids or common parameters' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMSetMaster -Arguments @{ parentId = 1; id = 2; name = 'N'; board = @{ id = 3 }; Verbose = $false } -Endpoint '/company/companies/1/serviceTemplates/2' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = $Body | ConvertFrom-Json
                    $Method -eq 'Put' -and
                    $ContentType -eq 'application/json; charset=utf-8' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/company/companies/1/serviceTemplates/2' -and
                    $B.name -eq 'N' -and $B.board.id -eq 3 -and
                    $null -eq $B.PSObject.Properties['id'] -and $null -eq $B.PSObject.Properties['parentId'] -and $null -eq $B.PSObject.Properties['Verbose']
                }
            }
        }
        It 'sends nothing with -WhatIf' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMSetMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WhatIf | Out-Null
                Should -Invoke Invoke-WebRequest -Times 0
            }
        }
    }

    Context 'Invoke-CWMNewMaster id 0 warning' {
        It 'warns when the API returns id 0' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 201; Content = '{"id":0}'; Headers = @{} } }
                $null = Invoke-CWMNewMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WarningVariable Warnings -WarningAction SilentlyContinue
                $Warnings | Should -HaveCount 1
                "$Warnings" | Should -Match 'id 0'
            }
        }
        It 'does not warn for a real id or a response without id' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 201; Content = '{"id":5}'; Headers = @{} } }
                $null = Invoke-CWMNewMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WarningVariable Warnings1 -WarningAction SilentlyContinue
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 201; Content = '{"name":"x"}'; Headers = @{} } }
                $null = Invoke-CWMNewMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WarningVariable Warnings2 -WarningAction SilentlyContinue
                $Warnings1 | Should -BeNullOrEmpty
                $Warnings2 | Should -BeNullOrEmpty
            }
        }
    }

    Context 'Invoke-CWMUpdateMaster' {
        It 'sends a single operation as a one-element JSON array' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'Replace'; Path = 'summary'; Value = 'x' } -Endpoint '/service/tickets/1' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Method -eq 'Patch' -and $ContentType -eq 'application/json; charset=utf-8' -and
                    $Body.Trim().StartsWith('[') -and $B.Count -eq 1 -and
                    $B[0].op -eq 'replace' -and $B[0].path -eq 'summary' -and $B[0].value -eq 'x'
                }
            }
        }
        It 'sends every PatchOperation (hashtables and PSCustomObjects) in one request' {
            InModuleScope ConnectWiseManageAPI {
                $Operations = @(
                    @{ op = 'replace'; path = 'summary'; value = 'New' }
                    [pscustomobject]@{ op = 'Add'; path = 'status'; value = @{ id = 10 } }
                    @{ op = 'replace'; path = 'budgetHours'; value = 2.5 }
                )
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = $Operations } -Endpoint '/service/tickets/1' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $B.Count -eq 3 -and
                    $B[0].op -eq 'replace' -and $B[0].path -eq 'summary' -and $B[0].value -eq 'New' -and
                    $B[1].op -eq 'add' -and $B[1].path -eq 'status' -and $B[1].value.id -eq 10 -and
                    $B[2].path -eq 'budgetHours' -and $B[2].value -eq 2.5
                }
            }
        }
        It 'uses PatchOperations as the whole body and ignores Operation/Path/Value' {
            InModuleScope ConnectWiseManageAPI {
                # A $null Operation would throw in the single-operation path (.toLower()), so this also proves it did not run
                $Arguments = @{ PatchOperations = @(@{ op = 'replace'; path = 'summary'; value = 'A' }); Operation = $null; Path = 'ignored'; Value = 'ignored' }
                Invoke-CWMUpdateMaster -Arguments $Arguments -Endpoint '/service/tickets/1' -ErrorAction Stop | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Body.Trim().StartsWith('[') -and $B.Count -eq 1 -and $B[0].path -eq 'summary' -and $Body -notmatch 'ignored'
                }
            }
        }
        It 'leaves value out of remove operations' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'remove'; Path = 'contact'; Value = $null } -Endpoint '/service/tickets/1' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @(
                        @{ op = 'remove'; path = 'contact'; value = 'should not be sent' }
                        [pscustomobject]@{ op = 'remove'; path = 'site' }
                    )
                } -Endpoint '/service/tickets/2' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Uri -like '*/tickets/1' -and $B.Count -eq 1 -and $B[0].op -eq 'remove' -and $Body -notmatch '"value"'
                }
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Uri -like '*/tickets/2' -and $B.Count -eq 2 -and $Body -notmatch '"value"'
                }
            }
        }
        It 'unwraps a PSObject-wrapped array value in both modes' {
            InModuleScope ConnectWiseManageAPI {
                # [psobject] wrapping makes Windows PowerShell 5.1 serialize {"value":[1,2,3],"Count":3}
                $Wrapped = [psobject]@(1, 2, 3)
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'list'; Value = $Wrapped } -Endpoint '/a/1' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @(@{ op = 'replace'; path = 'list'; value = $Wrapped }) } -Endpoint '/a/2' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @([pscustomobject]@{ op = 'replace'; path = 'list'; value = $Wrapped }) } -Endpoint '/a/3' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 3 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $B.Count -eq 1 -and $Body -notmatch '"Count"' -and (@($B[0].value) -join ',') -eq '1,2,3'
                }
            }
        }
        It 'writes an error and sends nothing when PatchOperations is empty or malformed' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @() } -Endpoint '/a/1' -ErrorVariable Err1 -ErrorAction SilentlyContinue | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @(@{ path = 'x'; value = 1 }) } -Endpoint '/a/1' -ErrorVariable Err2 -ErrorAction SilentlyContinue | Out-Null
                $Err1 | Should -Not -BeNullOrEmpty
                $Err2 | Should -Not -BeNullOrEmpty
                Should -Invoke Invoke-WebRequest -Times 0
            }
        }
    }

    Context 'Update-CWMProductCatalog parameter sets' {
        It 'keeps working positionally' {
            InModuleScope ConnectWiseManageAPI {
                Update-CWMProductCatalog 123 replace price 49.99 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Method -eq 'Patch' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/procurement/catalog/123' -and
                    $B.Count -eq 1 -and $B[0].op -eq 'replace' -and $B[0].path -eq 'price' -and $B[0].value -eq '49.99'
                }
            }
        }
        It 'accepts a named single operation' {
            InModuleScope ConnectWiseManageAPI {
                Update-CWMProductCatalog -catalogId 123 -Operation replace -Path description -Value 'D' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Uri -like '*/procurement/catalog/123' -and $B.Count -eq 1 -and $B[0].path -eq 'description' -and $B[0].value -eq 'D'
                }
            }
        }
        It 'accepts -PatchOperations' {
            InModuleScope ConnectWiseManageAPI {
                Update-CWMProductCatalog -id 123 -PatchOperations @(
                    @{ op = 'replace'; path = 'price'; value = 49.99 }
                    @{ op = 'replace'; path = 'cost'; value = 30 }
                ) | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ })
                    $Uri -like '*/procurement/catalog/123' -and $B.Count -eq 2 -and $B[0].path -eq 'price' -and $B[1].path -eq 'cost'
                }
            }
        }
        It 'has Single (default) and Bulk parameter sets' {
            $Command = Get-Command Update-CWMProductCatalog
            $Command.DefaultParameterSet | Should -Be 'Single'
            @($Command.ParameterSets.Name | Sort-Object) | Should -Be @('Bulk', 'Single')
        }
        It 'rejects mixing -PatchOperations with -Operation' {
            InModuleScope ConnectWiseManageAPI {
                { Update-CWMProductCatalog -id 1 -Operation replace -Path p -Value v -PatchOperations @(@{ op = 'replace'; path = 'p'; value = 1 }) } | Should -Throw
            }
        }
    }
}

Describe 'Step A SetMaster against a local HTTP server' {

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
        }
    }

    It 'sends a utf-8 JSON body as UTF-8 bytes' {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Url = $script:Url } {
            param($Url)
            Mock New-CWMUrl { "$Url/object" }
            $Result = Invoke-CWMSetMaster -Arguments @{ name = [string][char]0x0142 } -Endpoint '/x' # l with stroke, not in Latin-1
            $Result.id | Should -Be 1
        }
        # 0x0142 in UTF-8 is C5 82. Latin-1 would have sent '?' (3F).
        $script:TestServer.State.LastBodyHex | Should -Match 'C5 82'
        $script:TestServer.State.LastContentType | Should -Match 'charset=utf-8'
    }
}

Describe 'PR #82 endpoint functions' {

    BeforeEach {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{
                Server   = 'example.invalid'
                Codebase = 'v4_6_release'
                BasePath = 'apis/3.0'
                Headers  = @{ ClientID = 'test' }
            }
            Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '{"id":9}'; Headers = @{} } }
        }
    }

    It '<Name> sends <Method> <Path>' -ForEach @(
        @{ Name = 'Get-CWMCompanyServiceTemplate (list)'; Method = 'GET'; Path = '/company/companies/250/serviceTemplates'; Call = { Get-CWMCompanyServiceTemplate -parentId 250 } }
        @{ Name = 'Get-CWMCompanyServiceTemplate (id)'; Method = 'GET'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Get-CWMCompanyServiceTemplate -companyId 250 -templateId 15 } }
        @{ Name = 'Get-CWMCompanyServiceTemplate (pageId)'; Method = 'GET'; Path = '/company/companies/250/serviceTemplates?pageId=40'; Call = { Get-CWMCompanyServiceTemplate -parentId 250 -pageId 40 } }
        @{ Name = 'New-CWMCompanyServiceTemplate'; Method = 'Post'; Path = '/company/companies/250/serviceTemplates'; Call = { New-CWMCompanyServiceTemplate -parentId 250 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } } }
        @{ Name = 'Set-CWMCompanyServiceTemplate'; Method = 'Put'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Set-CWMCompanyServiceTemplate -parentId 250 -id 15 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } } }
        @{ Name = 'Update-CWMCompanyServiceTemplate'; Method = 'Patch'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -Operation replace -Path summary -Value 'S' } }
        @{ Name = 'Remove-CWMCompanyServiceTemplate'; Method = 'Delete'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Remove-CWMCompanyServiceTemplate -parentId 250 -id 15 -Confirm:$false } }
        @{ Name = 'Add-CWMCompanyServiceTemplateLink'; Method = 'Post'; Path = '/company/companies/250/serviceTemplates/15/link'; Call = { Add-CWMCompanyServiceTemplateLink -parentId 250 -id 15 } }
        @{ Name = 'Remove-CWMCompanyServiceTemplateLink'; Method = 'Post'; Path = '/company/companies/250/serviceTemplates/15/unlink'; Call = { Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15 } }
        @{ Name = 'Copy-CWMCompanyServiceTemplate'; Method = 'Post'; Path = '/company/companies/250/serviceTemplates/15/copy'; Call = { Copy-CWMCompanyServiceTemplate -parentId 250 -id 15 } }
        @{ Name = 'Invoke-CWMCompanyServiceTemplateGenerate'; Method = 'Post'; Path = '/company/companies/250/serviceTemplates/15/generate'; Call = { Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 } }
        @{ Name = 'Get-CWMServiceTemplateResource (list)'; Method = 'GET'; Path = '/service/templates/15/resources'; Call = { Get-CWMServiceTemplateResource -parentId 15 } }
        @{ Name = 'Get-CWMServiceTemplateResource (id)'; Method = 'GET'; Path = '/service/templates/15/resources/3'; Call = { Get-CWMServiceTemplateResource -templateId 15 -resourceId 3 } }
        @{ Name = 'New-CWMServiceTemplateResource'; Method = 'Post'; Path = '/service/templates/15/resources'; Call = { New-CWMServiceTemplateResource -parentId 15 -member @{ id = 140 } } }
        @{ Name = 'Set-CWMServiceTemplateResource'; Method = 'Put'; Path = '/service/templates/15/resources/3'; Call = { Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ id = 140 } } }
        @{ Name = 'Update-CWMServiceTemplateResource'; Method = 'Patch'; Path = '/service/templates/15/resources/3'; Call = { Update-CWMServiceTemplateResource -parentId 15 -id 3 -Operation replace -Path hours -Value 2 } }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ ExpectedMethod = $Method; Path = $Path; Call = $Call } {
            param($ExpectedMethod, $Path, $Call)
            # Re-create the script block here so it runs in the module scope, where the new functions are visible
            $null = & ([scriptblock]::Create($Call.ToString()))
            $ExpectedUri = "https://example.invalid/v4_6_release/apis/3.0$Path"
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Method -eq $ExpectedMethod -and $Uri -eq $ExpectedUri }
        }
    }

    It 'action endpoints send no body' {
        InModuleScope ConnectWiseManageAPI {
            Add-CWMCompanyServiceTemplateLink -parentId 250 -id 15 | Out-Null
            Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15 | Out-Null
            Copy-CWMCompanyServiceTemplate -parentId 250 -id 15 | Out-Null
            Should -Invoke Invoke-WebRequest -Times 3 -Exactly -ParameterFilter { $Method -eq 'Post' -and $null -eq $Body }
        }
    }

    It 'New-CWMCompanyServiceTemplate defaults company to the parent company' {
        InModuleScope ConnectWiseManageAPI {
            New-CWMCompanyServiceTemplate -parentId 250 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } | Out-Null
            New-CWMCompanyServiceTemplate -parentId 251 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } -company @{ id = 7 } | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $B = $Body | ConvertFrom-Json
                $Uri -like '*/companies/250/*' -and $B.company.id -eq 250 -and $null -eq $B.PSObject.Properties['parentId']
            }
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $B = $Body | ConvertFrom-Json
                $Uri -like '*/companies/251/*' -and $B.company.id -eq 7
            }
        }
    }

    It 'New-CWMCompanyServiceTemplate passes a copy, not $PSBoundParameters, to Invoke-CWMNewMaster' {
        InModuleScope ConnectWiseManageAPI {
            Mock Invoke-CWMNewMaster { $script:CapturedArguments = $Arguments }
            New-CWMCompanyServiceTemplate -parentId 250 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } | Out-Null
            $script:CapturedArguments | Should -BeOfType [hashtable]
            $script:CapturedArguments.company.id | Should -Be 250
            $script:CapturedArguments.name | Should -Be 'N'
        }
    }

    It 'Set-* functions leave the route ids out of the body' {
        InModuleScope ConnectWiseManageAPI {
            Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ id = 140 } -hours 1.5 | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $B = $Body | ConvertFrom-Json
                $B.member.id -eq 140 -and $B.hours -eq 1.5 -and
                $null -eq $B.PSObject.Properties['id'] -and $null -eq $B.PSObject.Properties['parentId']
            }
        }
    }

    It 'Invoke-CWMCompanyServiceTemplateGenerate sends only generateAllRecordsFlag' {
        InModuleScope ConnectWiseManageAPI {
            Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 -generateAllRecordsFlag $true | Out-Null
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                $B = $Body | ConvertFrom-Json
                $B.generateAllRecordsFlag -eq $true -and @($B.PSObject.Properties).Count -eq 1
            }
        }
    }

    It '<Name> supports positional, Single and Bulk calls' -ForEach @(
        @{ Name = 'Update-CWMCompanyServiceTemplate'; Path = '/company/companies/250/serviceTemplates/15' }
        @{ Name = 'Update-CWMServiceTemplateResource'; Path = '/service/templates/250/resources/15' }
    ) {
        InModuleScope ConnectWiseManageAPI -Parameters @{ Name = $Name; Path = $Path } {
            param($Name, $Path)
            & $Name 250 15 replace summary 'P' | Out-Null
            & $Name -parentId 250 -id 15 -Operation replace -Path summary -Value 'N' | Out-Null
            & $Name -parentId 250 -id 15 -PatchOperations @(@{ op = 'replace'; path = 'summary'; value = 'B1' }, @{ op = 'remove'; path = 'contact' }) | Out-Null
            $ExpectedUri = "https://example.invalid/v4_6_release/apis/3.0$Path"
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ }); $Uri -eq $ExpectedUri -and $B.Count -eq 1 -and $B[0].value -eq 'P' }
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ }); $Uri -eq $ExpectedUri -and $B.Count -eq 1 -and $B[0].value -eq 'N' }
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $B = @(ConvertFrom-Json $Body | ForEach-Object { $_ }); $Uri -eq $ExpectedUri -and $B.Count -eq 2 -and $B[0].value -eq 'B1' -and $B[1].op -eq 'remove' }
        }
    }
}
