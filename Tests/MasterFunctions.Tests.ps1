#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for the Invoke-CWM*Master functions: URL building, request bodies, content types and
# the PatchOperations body of Invoke-CWMUpdateMaster (issue #53). Invoke-WebRequest is mocked.

BeforeAll {
    . "$PSScriptRoot/Helpers/TestSetup.ps1"
}

AfterAll {
    Remove-CWMTestSetup
}

Describe 'Master functions' {

    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse
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
        It 'returns one object for a one-element array, N objects for N and nothing for none' {
            Set-CWMTestResponse -Content '[{"id":1}]'
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets' | Should -BeOfType [pscustomobject]
            }
            Set-CWMTestResponse -Content '[{"id":1},{"id":2},{"id":3}]'
            InModuleScope ConnectWiseManageAPI {
                @(Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets').Count | Should -Be 3
            }
            Set-CWMTestResponse -Content '[]'
            InModuleScope ConnectWiseManageAPI {
                @(Invoke-CWMGetMaster -Arguments @{} -Endpoint '/service/tickets').Count | Should -Be 0
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
            Set-CWMTestResponse -Content '{"id":5}'
            InModuleScope ConnectWiseManageAPI {
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

    Context 'Invoke-CWMNewMaster' {
        It 'sends JSON with charset=utf-8 by default' {
            InModuleScope ConnectWiseManageAPI {
                $null = Invoke-CWMNewMaster -Arguments @{ summary = 'x' } -Endpoint '/service/tickets'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $ContentType -eq 'application/json; charset=utf-8' }
            }
        }
        It 'keeps a caller-supplied ContentType' {
            InModuleScope ConnectWiseManageAPI {
                $null = Invoke-CWMNewMaster -Arguments @{ Body = 'raw'; ContentType = 'multipart/form-data; boundary=x' } -Endpoint '/system/documents'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $ContentType -eq 'multipart/form-data; boundary=x' }
            }
        }
        It 'summarizes a byte[] body in verbose output instead of failing' {
            InModuleScope ConnectWiseManageAPI {
                $Verbose = Invoke-CWMNewMaster -Arguments @{ Body = [byte[]](1, 2, 3); ContentType = 'multipart/form-data; boundary=x' } -Endpoint '/system/documents' -Verbose 4>&1 |
                    Where-Object { $_ -is [System.Management.Automation.VerboseRecord] }
                ($Verbose | Out-String) | Should -Match '\[3 bytes\]'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Body -is [byte[]] }
            }
        }
        It 'warns when the API returns id 0' {
            Set-CWMTestResponse -StatusCode 201 -Content '{"id":0}'
            InModuleScope ConnectWiseManageAPI {
                $null = Invoke-CWMNewMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WarningVariable Warnings -WarningAction SilentlyContinue
                $Warnings | Should -HaveCount 1
                "$Warnings" | Should -Match 'id 0'
            }
        }
        It 'does not warn for a real id or a response without id' {
            foreach ($Content in '{"id":5}', '{"name":"x"}') {
                Set-CWMTestResponse -StatusCode 201 -Content $Content
                InModuleScope ConnectWiseManageAPI {
                    $null = Invoke-CWMNewMaster -Arguments @{ name = 'N' } -Endpoint '/x' -WarningVariable Warnings -WarningAction SilentlyContinue
                    $Warnings | Should -BeNullOrEmpty
                }
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
}
