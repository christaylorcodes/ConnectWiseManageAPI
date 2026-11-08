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
        It 'writes no output object when the response is not JSON' {
            Set-CWMTestResponse -Content 'not json'
            InModuleScope ConnectWiseManageAPI {
                $Out = @(Invoke-CWMGetMaster -Arguments @{} -Endpoint '/x' -ErrorVariable Err -ErrorAction SilentlyContinue)
                $Out | Should -HaveCount 0
                "$Err" | Should -Match 'converting the results from JSON'
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

Describe 'Master function regressions (0.5.0 review)' {

    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse
    }

    Context 'Invoke-CWMUpdateMaster PSCustomObject values' {
        It 'sends every property of a PSCustomObject from a Get response, in both modes' {
            Set-CWMTestResponse -Content '{"id":1,"board":{"id":3,"name":"Help Desk"},"tasks":[{"id":1,"notes":"a"},{"id":2,"notes":"b"}]}'
            InModuleScope ConnectWiseManageAPI {
                $Ticket = Invoke-CWMGetMaster -Arguments @{ id = 1 } -Endpoint '/service/tickets'
                $Ticket.board | Should -BeOfType [pscustomobject]
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'board'; Value = $Ticket.board } -Endpoint '/service/tickets/1' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @(
                        @{ op = 'replace'; path = 'board'; value = $Ticket.board }
                        [pscustomobject]@{ op = 'replace'; path = 'tasks'; value = $Ticket.tasks }
                    )
                } -Endpoint '/service/tickets/2' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'tasks'; Value = $Ticket.tasks } -Endpoint '/service/tickets/3' | Out-Null

                $Bodies = @($global:CWMTestRequests | Where-Object Method -EQ 'Patch' | ForEach-Object { , @(ConvertFrom-Json $_.Body | ForEach-Object { $_ }) })
                $Bodies.Count | Should -Be 3
                $Bodies[0][0].value.id | Should -Be 3
                $Bodies[0][0].value.name | Should -Be 'Help Desk'
                $Bodies[1][0].value.name | Should -Be 'Help Desk'
                @($Bodies[1][1].value).Count | Should -Be 2
                ($Bodies[1][1].value.notes -join ',') | Should -Be 'a,b'
                ($Bodies[2][0].value.notes -join ',') | Should -Be 'a,b'
                $global:CWMTestRequests | Where-Object Method -EQ 'Patch' | ForEach-Object { $_.Body | Should -Not -Match '"value":\s*\{\s*\}' }
            }
        }
    }

    Context '$Result from the caller''s scope' {
        It 'returns nothing under -WhatIf even when the caller has a $Result variable' {
            InModuleScope ConnectWiseManageAPI {
                $Out = & {
                    $Result = 'LEAKED'
                    $null = $Result
                    Invoke-CWMNewMaster -Arguments @{ summary = 'x' } -Endpoint '/x' -WhatIf
                    Invoke-CWMSetMaster -Arguments @{ name = 'x' } -Endpoint '/x' -WhatIf
                    Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'a'; Value = 1 } -Endpoint '/x' -WhatIf
                    Invoke-CWMRemoveMaster -Endpoint '/x' -WhatIf
                    Invoke-CWMActionMaster -Endpoint '/x' -WhatIf
                }
                @($Out | Where-Object { $null -ne $_ }) | Should -BeNullOrEmpty
                Should -Invoke Invoke-WebRequest -Times 0
            }
        }
    }

    Context 'Invoke-CWMSearchMaster' {
        It 'ignores a $URLParameters variable in the caller''s scope' {
            InModuleScope ConnectWiseManageAPI {
                & {
                    $URLParameters = '&leak=1'
                    $null = $URLParameters
                    Invoke-CWMSearchMaster -Arguments @{ condition = 'id=1' } -Endpoint '/service/tickets/search' | Out-Null
                }
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/search' -and $Method -eq 'Post'
                }
            }
        }
        It 'marks the search as read-only so 502/503/504 are retried' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-CWMWebRequest { [pscustomobject]@{ Content = '[]' } }
                Invoke-CWMSearchMaster -Arguments @{ condition = 'id=1' } -Endpoint '/service/tickets/search' | Out-Null
                Should -Invoke Invoke-CWMWebRequest -Times 1 -Exactly -ParameterFilter { $Arguments.ReadOnly -eq $true }
            }
        }
        It 'does not pass the ReadOnly key on to Invoke-WebRequest' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMSearchMaster -Arguments @{ condition = 'id=1' } -Endpoint '/service/tickets/search' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { -not $PSBoundParameters.ContainsKey('ReadOnly') }
            }
        }
        It 'Test-CWMRetryable retries a read-only POST on <Code> but never a write' -ForEach @(
            @{ Code = 502 }, @{ Code = 503 }, @{ Code = 504 }
        ) {
            InModuleScope ConnectWiseManageAPI -Parameters @{ Code = $Code } {
                param($Code)
                Test-CWMRetryable -StatusCode $Code -Method 'Post' -ReadOnly | Should -BeTrue
                Test-CWMRetryable -StatusCode $Code -Method 'Post' | Should -BeFalse
                Test-CWMRetryable -StatusCode 500 -Method 'Post' -ReadOnly | Should -BeFalse
            }
        }
    }

    Context 'Request body' {
        It 'leaves ProgressAction (PowerShell 7.4 common parameter) out of the body' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMNewMaster -Arguments @{ summary = 'x'; ProgressAction = 'SilentlyContinue' } -Endpoint '/x' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Body -match 'summary' -and $Body -notmatch 'ProgressAction' }
            }
        }
        It 'leaves -ProgressAction out of the body of New-CWMTicket' -Skip:($PSVersionTable.PSVersion -lt [version]'7.4') {
            New-CWMTicket -summary 'x' -company @{ id = 1 } -ProgressAction SilentlyContinue | Out-Null
            Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 1 -Exactly -ParameterFilter {
                $Body -match 'summary' -and $Body -notmatch 'ProgressAction'
            }
        }
    }

    Context 'Secrets in verbose output' {
        It 'masks a password in Invoke-CWMNewMaster verbose output but sends it to the API' {
            InModuleScope ConnectWiseManageAPI {
                $Verbose = Invoke-CWMNewMaster -Arguments @{ identifier = 'jdoe'; password = 'MEMBERPW123'; settings = @{ apiToken = 'TOKEN42' } } -Endpoint '/system/members' -Verbose 4>&1 |
                    Where-Object { $_ -is [System.Management.Automation.VerboseRecord] }
                $Text = $Verbose | Out-String
                $Text | Should -Not -Match 'MEMBERPW123|TOKEN42'
                $Text | Should -Match 'jdoe'
                $Text | Should -Match '\[redacted\]'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Body -match 'MEMBERPW123' }
            }
        }
        It 'masks secrets in Invoke-CWMSetMaster verbose output' {
            InModuleScope ConnectWiseManageAPI {
                $Text = Invoke-CWMSetMaster -Arguments @{ name = 'n'; privateKey = 'PRIVSECRET' } -Endpoint '/x/1' -Verbose 4>&1 |
                    Where-Object { $_ -is [System.Management.Automation.VerboseRecord] } | Out-String
                $Text | Should -Not -Match 'PRIVSECRET'
                $Text | Should -Match '"name"'
            }
        }
        It 'masks the value of a patch operation whose path is a secret' {
            InModuleScope ConnectWiseManageAPI {
                $Text = Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'password'; Value = 'NEWPW99' } -Endpoint '/system/members/1' -Verbose 4>&1 |
                    Where-Object { $_ -is [System.Management.Automation.VerboseRecord] } | Out-String
                $Text | Should -Not -Match 'NEWPW99'
                $Text | Should -Match 'password'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Body -match 'NEWPW99' }
            }
        }
    }

    Context 'ConvertTo-CWMRedacted' {
        It 'masks matching keys at any depth and keeps everything else' {
            InModuleScope ConnectWiseManageAPI {
                $In = @{
                    UserName = 'u'; Password = 'P1'
                    nested   = [pscustomobject]@{ memberHash = 'H1'; name = 'n'; deeper = @{ clientSecret = 'S1'; keep = 'k' } }
                    list     = @([pscustomobject]@{ accessToken = 'T1'; id = 1 }, @{ PRIVATEKEY = 'K1' })
                }
                $Out = ConvertTo-CWMRedacted $In
                $Json = $Out | ConvertTo-Json -Depth 10
                $Json | Should -Not -Match 'P1|H1|S1|T1|K1'
                $Out.UserName | Should -Be 'u'
                $Out.Password | Should -Be '[redacted]'
                $Out.nested.name | Should -Be 'n'
                $Out.nested.deeper.keep | Should -Be 'k'
                $Out.list[0].id | Should -Be 1
                $In.Password | Should -Be 'P1' -Because 'the input is not modified'
                $In.nested.memberHash | Should -Be 'H1'
            }
        }
        It 'handles JSON text, form text, byte[] and plain values' {
            InModuleScope ConnectWiseManageAPI {
                ConvertTo-CWMRedacted '{"summary":"x","password":"P2"}' | Should -Not -Match 'P2'
                ConvertTo-CWMRedacted '[{"op":"replace","path":"password","value":"P3"}]' | Should -Not -Match 'P3'
                $Plain = "{`n  ""summary"": ""reset""`n}"
                ConvertTo-CWMRedacted $Plain | Should -BeExactly $Plain
                ConvertTo-CWMRedacted 'UserName=u&Password=P4' | Should -BeExactly 'UserName=u&Password=[redacted]'
                ConvertTo-CWMRedacted ([byte[]](1, 2, 3, 4)) | Should -Be '[4 bytes]'
                ConvertTo-CWMRedacted 5 | Should -Be 5
                ConvertTo-CWMRedacted $null | Should -BeNullOrEmpty
            }
        }
    }

    Context 'Invoke-CWMAllResult next-page links' {
        It 'stops paging, with an error, when the next page is <Case>' -ForEach @(
            @{ Case = 'on another host'; Link = 'https://evil.invalid/v4_6_release/apis/3.0/service/tickets?page=2' }
            @{ Case = 'an http downgrade'; Link = 'http://example.invalid/v4_6_release/apis/3.0/service/tickets?page=2' }
            @{ Case = 'carrying user info'; Link = 'https://user@example.invalid/v4_6_release/apis/3.0/service/tickets?page=2' }
            @{ Case = 'a relative URL'; Link = '/v4_6_release/apis/3.0/service/tickets?page=2' }
            @{ Case = 'on another port'; Link = 'https://example.invalid:8443/v4_6_release/apis/3.0/service/tickets?page=2' }
        ) {
            InModuleScope ConnectWiseManageAPI -Parameters @{ Link = $Link } {
                param($Link)
                $script:TestLink = $Link
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = "<$($script:TestLink)>; rel=`"next`"" } } }
                $Err = $null
                $Out = Invoke-CWMAllResult -Arguments @{ Uri = 'https://example.invalid/v4_6_release/apis/3.0/service/tickets?'; Method = 'Get' } -ErrorVariable Err -ErrorAction SilentlyContinue
                @($Out).Count | Should -Be 1
                ($Err | Out-String) | Should -Match 'Stopped paging'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly
            }
        }
        It 'follows an https next page on the connected host (<Case>)' -ForEach @(
            @{ Case = 'no port'; Link = 'https://EXAMPLE.invalid/v4_6_release/apis/3.0/service/tickets?page=2' }
            @{ Case = 'default port 443'; Link = 'https://example.invalid:443/v4_6_release/apis/3.0/service/tickets?page=2' }
        ) {
            InModuleScope ConnectWiseManageAPI -Parameters @{ Link = $Link } {
                param($Link)
                $script:TestLink = $Link
                Mock Invoke-WebRequest {
                    if ($Uri -like '*page=2*') { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":2}]'; Headers = @{ Link = '' } } }
                    else { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = "<$($script:TestLink)>; rel=`"next`"" } } }
                }
                $Out = @(Invoke-CWMAllResult -Arguments @{ Uri = 'https://example.invalid/v4_6_release/apis/3.0/service/tickets?'; Method = 'Get' })
                $Out.id | Should -Be @(1, 2)
                Should -Invoke Invoke-WebRequest -Times 2 -Exactly
            }
        }
    }
}

Describe 'API best-practice review (0.5.0)' {

    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse
    }

    Context 'Paging' {
        It 'asks for the API maximum of 1000 records per page with -all' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = '' } } }
                $null = Invoke-CWMGetMaster -Arguments @{ all = $true } -Endpoint '/service/boards'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Uri -like '*pageSize=1000' }
            }
        }
        It 'keeps a smaller -pageSize with -all' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = '' } } }
                $null = Invoke-CWMGetMaster -Arguments @{ all = $true; pageSize = 50 } -Endpoint '/service/boards'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $Uri -like '*pageSize=50' -and $Uri -notlike '*pageSize=1000*' }
            }
        }
        It 'follows rel="next" when Link lists several relations' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest {
                    if ($Uri -like '*pageId=5*') { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":2}]'; Headers = @{ Link = '' } } }
                    else {
                        $Link = '<https://example.invalid/v4_6_release/apis/3.0/x?pageId=99>; rel="last", <https://example.invalid/v4_6_release/apis/3.0/x?pageId=5>; rel="next"'
                        [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = $Link } }
                    }
                }
                $Out = @(Invoke-CWMAllResult -Arguments @{ Uri = 'https://example.invalid/v4_6_release/apis/3.0/x?'; Method = 'Get' })
                $Out.id | Should -Be @(1, 2)
                Should -Invoke Invoke-WebRequest -Times 0 -ParameterFilter { $Uri -like '*pageId=99*' }
            }
        }
        It 'stops when Link has no next page' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-WebRequest { [pscustomobject]@{ StatusCode = 200; Content = '[{"id":1}]'; Headers = @{ Link = '<https://example.invalid/v4_6_release/apis/3.0/x?pageId=0>; rel="first"' } } }
                $Out = @(Invoke-CWMAllResult -Arguments @{ Uri = 'https://example.invalid/v4_6_release/apis/3.0/x?'; Method = 'Get' })
                $Out.id | Should -Be @(1)
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly
            }
        }
    }

    Context 'Dates in request bodies' {
        It 'writes dates as ISO 8601 UTC on every edition, also when nested' {
            InModuleScope ConnectWiseManageAPI {
                $When = [datetime]::new(2026, 1, 2, 3, 4, 5, [System.DateTimeKind]::Utc)
                $Arguments = @{
                    expectedCloseDate = $When
                    nested            = @{ at = [DateTimeOffset]::new(2026, 1, 2, 5, 4, 5, [timespan]::FromHours(2)) }
                    dates             = @($When)
                    ids               = @(1, 2)
                }
                Invoke-CWMNewMaster -Arguments $Arguments -Endpoint '/x' | Out-Null
                $Raw = $global:CWMTestRequests[0].Body
                $Raw | Should -Match '"expectedCloseDate":\s*"2026-01-02T03:04:05Z"'
                $Raw | Should -Match '"at":\s*"2026-01-02T03:04:05Z"'
                $Raw | Should -Match '"dates":\s*\[\s*"2026-01-02T03:04:05Z"\s*\]'
                $Raw | Should -Not -Match '"Count"'
                @(($Raw | ConvertFrom-Json).ids) | Should -Be @(1, 2)
                $Arguments.expectedCloseDate | Should -BeOfType [datetime]
            }
        }
        It 'sends a date without a kind unchanged as UTC, so a calendar date keeps its day' {
            InModuleScope ConnectWiseManageAPI {
                Invoke-CWMNewMaster -Arguments @{ expectedCloseDate = [datetime]::new(2026, 1, 2) } -Endpoint '/x' | Out-Null
                $global:CWMTestRequests[0].Body | Should -Match '"expectedCloseDate":\s*"2026-01-02T00:00:00Z"'
            }
        }
        It 'converts a local date to UTC' {
            InModuleScope ConnectWiseManageAPI {
                $Local = [datetime]::new(2026, 1, 2, 9, 0, 0, [System.DateTimeKind]::Local)
                $Expected = $Local.ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss'Z'", [cultureinfo]::InvariantCulture)
                Invoke-CWMNewMaster -Arguments @{ d = $Local } -Endpoint '/x' | Out-Null
                $global:CWMTestRequests[0].Body | Should -Match ('"d":\s*"' + [regex]::Escape($Expected) + '"')
            }
        }
        It 'sends patch values that are dates as ISO 8601 UTC' {
            InModuleScope ConnectWiseManageAPI {
                $When = [datetime]::new(2026, 1, 2, 3, 4, 5, [System.DateTimeKind]::Utc)
                Invoke-CWMUpdateMaster -Arguments @{ Operation = 'replace'; Path = 'expectedCloseDate'; Value = $When } -Endpoint '/x' | Out-Null
                Invoke-CWMUpdateMaster -Arguments @{ PatchOperations = @(@{ op = 'replace'; path = 'dates'; value = @($When) }) } -Endpoint '/x' | Out-Null
                $global:CWMTestRequests[0].Body | Should -Match '"value":\s*"2026-01-02T03:04:05Z"'
                $global:CWMTestRequests[1].Body | Should -Match '"value":\s*\[\s*"2026-01-02T03:04:05Z"\s*\]'
                $global:CWMTestRequests[1].Body | Should -Not -Match '"Count"'
            }
        }
    }

    Context 'User-Agent' {
        It 'identifies the module on every request' {
            InModuleScope ConnectWiseManageAPI {
                $null = Invoke-CWMGetMaster -Arguments @{} -Endpoint '/x'
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter { $UserAgent -match '^ConnectWiseManageAPI/\S+ PowerShell/\S+$' }
            }
        }
    }

    Context 'Get-CWMDocument -download' {
        BeforeEach {
            Mock Invoke-WebRequest -ModuleName ConnectWiseManageAPI {
                $Stream = New-Object System.IO.MemoryStream (, [byte[]](0x25, 0x50, 0x00, 0xFF))
                [pscustomobject]@{ StatusCode = 200; Content = [byte[]](0x25, 0x50, 0x00, 0xFF); RawContentStream = $Stream; Headers = @{} }
            }
        }
        It 'returns the exact bytes and does not ask for JSON' {
            $Bytes = Get-CWMDocument -id 9 -download
            , $Bytes | Should -BeOfType [byte[]]
            $Bytes | Should -Be ([byte[]](0x25, 0x50, 0x00, 0xFF))
            Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 1 -Exactly -ParameterFilter {
                $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/system/documents/9/download' -and $Headers.Accept -eq '*/*'
            }
        }
        It 'writes the bytes to -OutFile' {
            $Path = Join-Path $TestDrive 'doc.bin'
            $File = Get-CWMDocument -id 9 -download -OutFile $Path
            $File.FullName | Should -Be (Get-Item $Path).FullName
            [System.IO.File]::ReadAllBytes($Path) | Should -Be ([byte[]](0x25, 0x50, 0x00, 0xFF))
        }
    }
}
