#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline unit tests for the knowledge base, invoice, opportunity note, project ticket all-notes and
# service template functions. Invoke-WebRequest is mocked, so no ConnectWise server or network is needed.

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force
}

AfterAll {
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Step D endpoint functions' {

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

    Context 'Get-CWMKnowledgeBaseArticle' {
        It 'GETs the list endpoint' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMKnowledgeBaseArticle | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles'
                }
            }
        }
        It 'GETs a single article by id' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMKnowledgeBaseArticle -id 42 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles/42'
                }
            }
        }
        It 'GETs the count endpoint with conditions, orderBy, fields and paging' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMKnowledgeBaseArticle -count -condition "title contains 'VPN'" | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles/count?conditions=title+contains+%27VPN%27'
                }
                Get-CWMKnowledgeBaseArticle -orderBy 'id desc' -fields 'id', 'title' -page 2 -pageSize 10 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles?fields=id%2ctitle&orderBy=id+desc&pageSize=10&page=2'
                }
            }
        }
    }

    Context 'New-CWMKnowledgeBaseArticle' {
        It 'POSTs the article body to the collection' {
            InModuleScope ConnectWiseManageAPI {
                New-CWMKnowledgeBaseArticle -title 'T' -issue 'I' -resolution 'R' -board @{ id = 1 } | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = $Body | ConvertFrom-Json
                    $Method -eq 'Post' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles' -and
                    $B.title -eq 'T' -and $B.issue -eq 'I' -and $B.resolution -eq 'R' -and $B.board.id -eq 1
                }
            }
        }
        It 'requires title, issue and resolution' {
            InModuleScope ConnectWiseManageAPI {
                $Params = (Get-Command New-CWMKnowledgeBaseArticle).Parameters
                foreach ($Name in 'title', 'issue', 'resolution') {
                    $Params[$Name].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
                }
            }
        }
    }

    Context 'Update-CWMKnowledgeBaseArticle' {
        It 'PATCHes the article with a single operation' {
            InModuleScope ConnectWiseManageAPI {
                Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'title' -Value 'New' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $B = @($Body | ConvertFrom-Json)
                    $Method -eq 'Patch' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles/42' -and
                    $B[0].op -eq 'replace' -and $B[0].path -eq 'title' -and $B[0].value -eq 'New'
                }
            }
        }
    }

    Context 'Remove-CWMKnowledgeBaseArticle' {
        It 'DELETEs the article' {
            InModuleScope ConnectWiseManageAPI {
                Remove-CWMKnowledgeBaseArticle -id 42 -Confirm:$false | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'Delete' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/knowledgeBaseArticles/42'
                }
            }
        }
        It 'sends nothing with -WhatIf' {
            InModuleScope ConnectWiseManageAPI {
                Remove-CWMKnowledgeBaseArticle -id 42 -WhatIf | Out-Null
                Should -Invoke Invoke-WebRequest -Times 0
            }
        }
        It 'declares ConfirmImpact High' {
            InModuleScope ConnectWiseManageAPI {
                $Binding = (Get-Command Remove-CWMKnowledgeBaseArticle).ScriptBlock.Attributes.Where({ $_ -is [System.Management.Automation.CmdletBindingAttribute] })[0]
                $Binding.ConfirmImpact | Should -Be 'High'
            }
        }
    }

    Context 'Get-CWMInvoice' {
        It 'GETs the list endpoint' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMInvoice | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/finance/invoices'
                }
            }
        }
        It 'GETs a single invoice by id' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMInvoice -id 1001 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/finance/invoices/1001'
                }
            }
        }
    }

    Context 'Get-CWMOpportunityNote' {
        It 'GETs the notes of the opportunity' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMOpportunityNote -parentId 500 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/sales/opportunities/500/notes'
                }
            }
        }
        It 'sends -condition to the API as conditions=' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMOpportunityNote -opportunityId 500 -condition "text contains 'pricing'" | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/sales/opportunities/500/notes?conditions=text+contains+%27pricing%27'
                }
            }
        }
        It 'GETs a single note by id' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMOpportunityNote -parentId 500 -id 12 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/sales/opportunities/500/notes/12'
                }
            }
        }
    }

    Context 'Get-CWMProjectTicketAllNote' {
        It 'GETs allNotes of the project ticket' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMProjectTicketAllNote -ticketId 9876 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -ceq 'https://example.invalid/v4_6_release/apis/3.0/project/tickets/9876/allNotes'
                }
            }
        }
    }

    Context 'Get-CWMServiceTemplate' {
        It 'GETs the list endpoint' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMServiceTemplate | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'GET' -and $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/templates'
                }
            }
        }
        It 'GETs a single template by id' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMServiceTemplate -id 15 | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/templates/15'
                }
            }
        }
    }

    Context 'Get-CWMTicket -childConditions (issue #38 example)' {
        It 'sends childConditions in the search body' {
            InModuleScope ConnectWiseManageAPI {
                Get-CWMTicket -childConditions 'configurations/id=1234' | Out-Null
                Should -Invoke Invoke-WebRequest -Times 1 -Exactly -ParameterFilter {
                    $Method -eq 'Post' -and
                    $Uri -eq 'https://example.invalid/v4_6_release/apis/3.0/service/tickets/search' -and
                    ($Body | ConvertFrom-Json).childConditions -eq 'configurations/id=1234'
                }
            }
        }
    }
}
