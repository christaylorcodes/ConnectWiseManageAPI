#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for endpoint functions: the method and URL each one sends, plus the request bodies and
# parameters that need more than a routing check. Invoke-WebRequest is mocked.
# The Single/Bulk pattern of every Update-CWM* function is covered in UpdateFunctions.Tests.ps1.

BeforeAll {
    . "$PSScriptRoot/Helpers/TestSetup.ps1"
}

AfterAll {
    Remove-CWMTestSetup
}

Describe 'Endpoint functions' {

    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse
    }

    It '<Name> sends <HttpMethod> <Path>' -ForEach @(
        # Company service templates and service template resources (PR #82)
        @{ Name = 'Get-CWMCompanyServiceTemplate (list)'; HttpMethod = 'GET'; Path = '/company/companies/250/serviceTemplates'; Call = { Get-CWMCompanyServiceTemplate -parentId 250 } }
        @{ Name = 'Get-CWMCompanyServiceTemplate (id)'; HttpMethod = 'GET'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Get-CWMCompanyServiceTemplate -companyId 250 -templateId 15 } }
        @{ Name = 'Get-CWMCompanyServiceTemplate (pageId)'; HttpMethod = 'GET'; Path = '/company/companies/250/serviceTemplates?pageId=40'; Call = { Get-CWMCompanyServiceTemplate -parentId 250 -pageId 40 } }
        @{ Name = 'New-CWMCompanyServiceTemplate'; HttpMethod = 'Post'; Path = '/company/companies/250/serviceTemplates'; Call = { New-CWMCompanyServiceTemplate -parentId 250 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } } }
        @{ Name = 'Set-CWMCompanyServiceTemplate'; HttpMethod = 'Put'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Set-CWMCompanyServiceTemplate -parentId 250 -id 15 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } } }
        @{ Name = 'Update-CWMCompanyServiceTemplate'; HttpMethod = 'Patch'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -Operation replace -Path summary -Value 'S' } }
        @{ Name = 'Remove-CWMCompanyServiceTemplate'; HttpMethod = 'Delete'; Path = '/company/companies/250/serviceTemplates/15'; Call = { Remove-CWMCompanyServiceTemplate -parentId 250 -id 15 -Confirm:$false } }
        @{ Name = 'Add-CWMCompanyServiceTemplateLink'; HttpMethod = 'Post'; Path = '/company/companies/250/serviceTemplates/15/link'; Call = { Add-CWMCompanyServiceTemplateLink -parentId 250 -id 15 } }
        @{ Name = 'Remove-CWMCompanyServiceTemplateLink'; HttpMethod = 'Post'; Path = '/company/companies/250/serviceTemplates/15/unlink'; Call = { Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15 } }
        @{ Name = 'Copy-CWMCompanyServiceTemplate'; HttpMethod = 'Post'; Path = '/company/companies/250/serviceTemplates/15/copy'; Call = { Copy-CWMCompanyServiceTemplate -parentId 250 -id 15 } }
        @{ Name = 'Invoke-CWMCompanyServiceTemplateGenerate'; HttpMethod = 'Post'; Path = '/company/companies/250/serviceTemplates/15/generate'; Call = { Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 } }
        @{ Name = 'Get-CWMServiceTemplateResource (list)'; HttpMethod = 'GET'; Path = '/service/templates/15/resources'; Call = { Get-CWMServiceTemplateResource -parentId 15 } }
        @{ Name = 'Get-CWMServiceTemplateResource (id)'; HttpMethod = 'GET'; Path = '/service/templates/15/resources/3'; Call = { Get-CWMServiceTemplateResource -templateId 15 -resourceId 3 } }
        @{ Name = 'New-CWMServiceTemplateResource'; HttpMethod = 'Post'; Path = '/service/templates/15/resources'; Call = { New-CWMServiceTemplateResource -parentId 15 -member @{ id = 140 } } }
        @{ Name = 'Set-CWMServiceTemplateResource'; HttpMethod = 'Put'; Path = '/service/templates/15/resources/3'; Call = { Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ id = 140 } } }
        @{ Name = 'Update-CWMServiceTemplateResource'; HttpMethod = 'Patch'; Path = '/service/templates/15/resources/3'; Call = { Update-CWMServiceTemplateResource -parentId 15 -id 3 -Operation replace -Path hours -Value 2 } }
        @{ Name = 'Get-CWMServiceTemplate (list)'; HttpMethod = 'GET'; Path = '/service/templates'; Call = { Get-CWMServiceTemplate } }
        @{ Name = 'Get-CWMServiceTemplate (id)'; HttpMethod = 'GET'; Path = '/service/templates/15'; Call = { Get-CWMServiceTemplate -id 15 } }
        # Knowledge base (#59)
        @{ Name = 'Get-CWMKnowledgeBaseArticle (list)'; HttpMethod = 'GET'; Path = '/service/knowledgeBaseArticles'; Call = { Get-CWMKnowledgeBaseArticle } }
        @{ Name = 'Get-CWMKnowledgeBaseArticle (id)'; HttpMethod = 'GET'; Path = '/service/knowledgeBaseArticles/42'; Call = { Get-CWMKnowledgeBaseArticle -id 42 } }
        @{ Name = 'Get-CWMKnowledgeBaseArticle (count)'; HttpMethod = 'GET'; Path = '/service/knowledgeBaseArticles/count?conditions=title+contains+%27VPN%27'; Call = { Get-CWMKnowledgeBaseArticle -count -condition "title contains 'VPN'" } }
        @{ Name = 'Get-CWMKnowledgeBaseArticle (query)'; HttpMethod = 'GET'; Path = '/service/knowledgeBaseArticles?fields=id%2ctitle&orderBy=id+desc&pageSize=10&page=2'; Call = { Get-CWMKnowledgeBaseArticle -orderBy 'id desc' -fields 'id', 'title' -page 2 -pageSize 10 } }
        @{ Name = 'Update-CWMKnowledgeBaseArticle'; HttpMethod = 'Patch'; Path = '/service/knowledgeBaseArticles/42'; Call = { Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'title' -Value 'New' } }
        @{ Name = 'Remove-CWMKnowledgeBaseArticle'; HttpMethod = 'Delete'; Path = '/service/knowledgeBaseArticles/42'; Call = { Remove-CWMKnowledgeBaseArticle -id 42 -Confirm:$false } }
        # Invoices, opportunity notes, project ticket notes (#38), product catalog
        @{ Name = 'Get-CWMInvoice (list)'; HttpMethod = 'GET'; Path = '/finance/invoices'; Call = { Get-CWMInvoice } }
        @{ Name = 'Get-CWMInvoice (id)'; HttpMethod = 'GET'; Path = '/finance/invoices/1001'; Call = { Get-CWMInvoice -id 1001 } }
        @{ Name = 'Get-CWMOpportunityNote (list)'; HttpMethod = 'GET'; Path = '/sales/opportunities/500/notes'; Call = { Get-CWMOpportunityNote -parentId 500 } }
        @{ Name = 'Get-CWMOpportunityNote (condition)'; HttpMethod = 'GET'; Path = '/sales/opportunities/500/notes?conditions=text+contains+%27pricing%27'; Call = { Get-CWMOpportunityNote -opportunityId 500 -condition "text contains 'pricing'" } }
        @{ Name = 'Get-CWMOpportunityNote (id)'; HttpMethod = 'GET'; Path = '/sales/opportunities/500/notes/12'; Call = { Get-CWMOpportunityNote -parentId 500 -id 12 } }
        @{ Name = 'Get-CWMProjectTicketAllNote'; HttpMethod = 'GET'; Path = '/project/tickets/9876/allNotes'; Call = { Get-CWMProjectTicketAllNote -ticketId 9876 } }
        @{ Name = 'Update-CWMProductCatalog'; HttpMethod = 'Patch'; Path = '/procurement/catalog/123'; Call = { Update-CWMProductCatalog -id 123 -Operation replace -Path price -Value 49.99 } }
        # Picking/shipping details: parentId (product) is positional 0, id positional 1, since the '{parentId}' URL fix
        @{ Name = 'Update-CWMProductPickingShippingDetail'; HttpMethod = 'Patch'; Path = '/procurement/products/5/pickingShippingDetails/9'; Call = { Update-CWMProductPickingShippingDetail 5 9 replace quantity 2 } }
        @{ Name = 'Remove-CWMProductPickingShippingDetail'; HttpMethod = 'Delete'; Path = '/procurement/products/5/pickingShippingDetails/9'; Call = { Remove-CWMProductPickingShippingDetail 5 9 -Confirm:$false } }
        # Paths corrected against the OpenAPI spec 2026.11 (exact casing; -ceq below is case-sensitive)
        @{ Name = 'New-CWMAgreementType'; HttpMethod = 'Post'; Path = '/finance/agreements/types'; Call = { New-CWMAgreementType -name 'Managed' -Confirm:$false } }
        @{ Name = 'Get-CWMTicketAllNote'; HttpMethod = 'GET'; Path = '/service/tickets/9876/allNotes'; Call = { Get-CWMTicketAllNote -ticketId 9876 } }
        @{ Name = 'Get-CWMTicketAllNote (count)'; HttpMethod = 'GET'; Path = '/service/tickets/9876/allNotes/count'; Call = { Get-CWMTicketAllNote -parentId 9876 -count } }
        @{ Name = 'Get-CWMWarehouseBin'; HttpMethod = 'GET'; Path = '/procurement/warehouseBins'; Call = { Get-CWMWarehouseBin } }
        @{ Name = 'Get-CWMWarehouseBin (id)'; HttpMethod = 'GET'; Path = '/procurement/warehouseBins/7'; Call = { Get-CWMWarehouseBin -id 7 } }
        @{ Name = 'Get-CWMInventory'; HttpMethod = 'GET'; Path = '/procurement/warehouseBins/7/inventoryOnHand'; Call = { Get-CWMInventory -parentId 7 } }
        @{ Name = 'Get-CWMScheduleHolidayList'; HttpMethod = 'GET'; Path = '/schedule/holidayLists'; Call = { Get-CWMScheduleHolidayList } }
        @{ Name = 'Get-CWMScheduleHoliday'; HttpMethod = 'GET'; Path = '/schedule/holidayLists/3/holidays'; Call = { Get-CWMScheduleHoliday -holidayListId 3 } }
        @{ Name = 'Get-CWMMyMember'; HttpMethod = 'GET'; Path = '/system/myMembers'; Call = { Get-CWMMyMember } }
        @{ Name = 'Get-CWMMySecurity'; HttpMethod = 'GET'; Path = '/system/mySecurity'; Call = { Get-CWMMySecurity } }
        # Time sheet actions: the switch picks the endpoint
        @{ Name = 'Update-CWMTimeSheet -Approve'; HttpMethod = 'Post'; Path = '/time/sheets/55/approve'; Call = { Update-CWMTimeSheet -id 55 -Approve -Confirm:$false } }
        @{ Name = 'Update-CWMTimeSheet -Reject'; HttpMethod = 'Post'; Path = '/time/sheets/55/reject'; Call = { Update-CWMTimeSheet -id 55 -Reject -Confirm:$false } }
        @{ Name = 'Update-CWMTimeSheet -Reverse'; HttpMethod = 'Post'; Path = '/time/sheets/55/reverse'; Call = { Update-CWMTimeSheet -id 55 -Reverse -Confirm:$false } }
        @{ Name = 'Update-CWMTimeSheet -Submit'; HttpMethod = 'Post'; Path = '/time/sheets/55/submit'; Call = { Update-CWMTimeSheet -id 55 -Submit -Confirm:$false } }
        @{ Name = 'Update-CWMTimeSheet (default)'; HttpMethod = 'Post'; Path = '/time/sheets/55/submit'; Call = { Update-CWMTimeSheet -id 55 -Confirm:$false } }
        @{ Name = 'Submit-CWMTimeSheet'; HttpMethod = 'Post'; Path = '/time/sheets/55/submit'; Call = { Submit-CWMTimeSheet -id 55 -Confirm:$false } }
        # Query-string endpoints: /count goes before the query string
        @{ Name = 'Get-CWMAuditTrail'; HttpMethod = 'GET'; Path = '/system/audittrail?type=Ticket&id=5&pageSize=10'; Call = { Get-CWMAuditTrail -type Ticket -id 5 -pageSize 10 } }
        @{ Name = 'Get-CWMAuditTrail (count)'; HttpMethod = 'GET'; Path = '/system/audittrail/count?type=Ticket&id=5&deviceIdentifier=d1'; Call = { Get-CWMAuditTrail -type Ticket -id 5 -deviceIdentifier d1 -count } }
        @{ Name = 'Get-CWMDocument (id)'; HttpMethod = 'GET'; Path = '/system/documents/9'; Call = { Get-CWMDocument -id 9 } }
        @{ Name = 'Get-CWMDocument (download)'; HttpMethod = 'GET'; Path = '/system/documents/9/download'; Call = { Get-CWMDocument -id 9 -download } }
        @{ Name = 'Get-CWMDocument (record)'; HttpMethod = 'GET'; Path = '/system/documents?recordId=123&recordType=Ticket'; Call = { Get-CWMDocument -recordId 123 -recordType Ticket } }
        @{ Name = 'Get-CWMDocument (record count)'; HttpMethod = 'GET'; Path = '/system/documents/count?recordId=123&recordType=Ticket'; Call = { Get-CWMDocument -recordId 123 -recordType Ticket -count } }
        @{ Name = 'Get-CWMDocument (count)'; HttpMethod = 'GET'; Path = '/system/documents/count'; Call = { Get-CWMDocument -count } }
        # Filters that used to be dropped, and route ids that used to be missing
        @{ Name = 'Get-CWMContactType -condition'; HttpMethod = 'GET'; Path = '/company/contacts/types?conditions=description%3d%27Owner%27'; Call = { Get-CWMContactType -condition "description='Owner'" } }
        @{ Name = 'Get-CWMContactType -conditions (alias)'; HttpMethod = 'GET'; Path = '/company/contacts/types?conditions=description%3d%27Owner%27'; Call = { Get-CWMContactType -conditions "description='Owner'" } }
        @{ Name = 'Get-CWMProductAdjustmentDetail'; HttpMethod = 'GET'; Path = '/procurement/adjustments/4/details'; Call = { Get-CWMProductAdjustmentDetail -adjustmentId 4 } }
        @{ Name = 'New-CWMMarketingGroupCompany'; HttpMethod = 'Post'; Path = '/marketing/groups/3/companies'; Call = { New-CWMMarketingGroupCompany -groupId 3 -id 250 -Confirm:$false } }
        # API best-practice review: new endpoints (0.5.0)
        @{ Name = 'Get-CWMUserDefinedField (list)'; HttpMethod = 'GET'; Path = '/system/userDefinedFields'; Call = { Get-CWMUserDefinedField } }
        @{ Name = 'Get-CWMUserDefinedField (id)'; HttpMethod = 'GET'; Path = '/system/userDefinedFields/4'; Call = { Get-CWMUserDefinedField -id 4 } }
        @{ Name = 'Get-CWMUserDefinedField (count)'; HttpMethod = 'GET'; Path = '/system/userDefinedFields/count'; Call = { Get-CWMUserDefinedField -count } }
        @{ Name = 'New-CWMUserDefinedField'; HttpMethod = 'Post'; Path = '/system/userDefinedFields'; Call = { New-CWMUserDefinedField -podId 1 -caption 'C' -sequenceNumber 1 -fieldTypeIdentifier Text } }
        @{ Name = 'Update-CWMUserDefinedField'; HttpMethod = 'Patch'; Path = '/system/userDefinedFields/4'; Call = { Update-CWMUserDefinedField -id 4 -Operation replace -Path helpText -Value 'x' } }
        @{ Name = 'Remove-CWMUserDefinedField'; HttpMethod = 'Delete'; Path = '/system/userDefinedFields/4'; Call = { Remove-CWMUserDefinedField -id 4 -Confirm:$false } }
        @{ Name = 'Get-CWMAgreementAdjustment'; HttpMethod = 'GET'; Path = '/finance/agreements/12/adjustments/5'; Call = { Get-CWMAgreementAdjustment -agreementId 12 -id 5 } }
        @{ Name = 'New-CWMAgreementAdjustment'; HttpMethod = 'Post'; Path = '/finance/agreements/12/adjustments'; Call = { New-CWMAgreementAdjustment -parentId 12 -amount -50 } }
        @{ Name = 'Update-CWMAgreementAdjustment'; HttpMethod = 'Patch'; Path = '/finance/agreements/12/adjustments/5'; Call = { Update-CWMAgreementAdjustment -parentId 12 -id 5 -Operation replace -Path amount -Value 1 } }
        @{ Name = 'Remove-CWMAgreementAdjustment'; HttpMethod = 'Delete'; Path = '/finance/agreements/12/adjustments/5'; Call = { Remove-CWMAgreementAdjustment -parentId 12 -id 5 -Confirm:$false } }
        @{ Name = 'Get-CWMAgreementWorkRole'; HttpMethod = 'GET'; Path = '/finance/agreements/12/workroles/count'; Call = { Get-CWMAgreementWorkRole -parentId 12 -count } }
        @{ Name = 'New-CWMAgreementWorkRole'; HttpMethod = 'Post'; Path = '/finance/agreements/12/workroles'; Call = { New-CWMAgreementWorkRole -parentId 12 -workRole @{ id = 3 } -rateType Custom -rate 95 } }
        @{ Name = 'Update-CWMAgreementWorkRole'; HttpMethod = 'Patch'; Path = '/finance/agreements/12/workroles/5'; Call = { Update-CWMAgreementWorkRole -parentId 12 -id 5 -Operation replace -Path rate -Value 1 } }
        @{ Name = 'Remove-CWMAgreementWorkRole'; HttpMethod = 'Delete'; Path = '/finance/agreements/12/workroles/5'; Call = { Remove-CWMAgreementWorkRole -parentId 12 -id 5 -Confirm:$false } }
        @{ Name = 'Get-CWMAgreementWorkType'; HttpMethod = 'GET'; Path = '/finance/agreements/12/worktypes'; Call = { Get-CWMAgreementWorkType -parentId 12 } }
        @{ Name = 'New-CWMAgreementWorkType'; HttpMethod = 'Post'; Path = '/finance/agreements/12/worktypes'; Call = { New-CWMAgreementWorkType -parentId 12 -rateType Multiplier -billTime Billable } }
        @{ Name = 'Update-CWMAgreementWorkType'; HttpMethod = 'Patch'; Path = '/finance/agreements/12/worktypes/5'; Call = { Update-CWMAgreementWorkType -parentId 12 -id 5 -Operation replace -Path rate -Value 1 } }
        @{ Name = 'Remove-CWMAgreementWorkType'; HttpMethod = 'Delete'; Path = '/finance/agreements/12/worktypes/5'; Call = { Remove-CWMAgreementWorkType -parentId 12 -id 5 -Confirm:$false } }
        @{ Name = 'New-CWMInvoice'; HttpMethod = 'Post'; Path = '/finance/invoices'; Call = { New-CWMInvoice -type Miscellaneous -company @{ id = 250 } } }
        @{ Name = 'Update-CWMInvoice'; HttpMethod = 'Patch'; Path = '/finance/invoices/1001'; Call = { Update-CWMInvoice -id 1001 -Operation replace -Path customerPO -Value 'PO' } }
        @{ Name = 'Get-CWMInvoice -pdf'; HttpMethod = 'GET'; Path = '/finance/invoices/1001/pdf'; Call = { Get-CWMInvoice -id 1001 -pdf } }
        @{ Name = 'Get-CWMWorkRole'; HttpMethod = 'GET'; Path = '/time/workRoles/3'; Call = { Get-CWMWorkRole -id 3 } }
        @{ Name = 'Get-CWMWorkType'; HttpMethod = 'GET'; Path = '/time/workTypes'; Call = { Get-CWMWorkType } }
        @{ Name = 'Get-CWMExpenseType'; HttpMethod = 'GET'; Path = '/expense/types/count'; Call = { Get-CWMExpenseType -count } }
        @{ Name = 'Update-CWMExpenseEntry'; HttpMethod = 'Patch'; Path = '/expense/entries/9'; Call = { Update-CWMExpenseEntry -id 9 -Operation replace -Path notes -Value 'x' } }
        @{ Name = 'Remove-CWMExpenseEntry'; HttpMethod = 'Delete'; Path = '/expense/entries/9'; Call = { Remove-CWMExpenseEntry -id 9 -Confirm:$false } }
        @{ Name = 'Get-CWMConfigurationStatus'; HttpMethod = 'GET'; Path = '/company/configurations/statuses'; Call = { Get-CWMConfigurationStatus } }
        @{ Name = 'Get-CWMWorkflow'; HttpMethod = 'GET'; Path = '/system/workflows/2'; Call = { Get-CWMWorkflow -id 2 } }
    ) {
        $null = & $Call
        $ExpectedUri = "$CWMTestBaseUri$Path"
        Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 1 -Exactly -ParameterFilter { $Method -eq $HttpMethod -and $Uri -ceq $ExpectedUri }
    }

    Context 'Company service templates' {
        It 'action endpoints send no body' {
            Add-CWMCompanyServiceTemplateLink -parentId 250 -id 15 | Out-Null
            Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15 | Out-Null
            Copy-CWMCompanyServiceTemplate -parentId 250 -id 15 | Out-Null
            Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 3 -Exactly -ParameterFilter { $Method -eq 'Post' -and $null -eq $Body }
        }

        It 'New-CWMCompanyServiceTemplate defaults company to the parent company' {
            New-CWMCompanyServiceTemplate -parentId 250 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } | Out-Null
            New-CWMCompanyServiceTemplate -parentId 251 -name 'N' -summary 'S' -board @{ id = 1 } -status @{ id = 2 } -company @{ id = 7 } | Out-Null
            $First, $Second = $global:CWMTestRequests | ForEach-Object { $_.Body | ConvertFrom-Json }
            $First.company.id | Should -Be 250
            $First.PSObject.Properties['parentId'] | Should -BeNullOrEmpty
            $Second.company.id | Should -Be 7
        }

        It 'Set-* functions leave the route ids out of the body' {
            Set-CWMServiceTemplateResource -parentId 15 -id 3 -member @{ id = 140 } -hours 1.5 | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            $B.member.id | Should -Be 140
            $B.hours | Should -Be 1.5
            $B.PSObject.Properties['id'] | Should -BeNullOrEmpty
            $B.PSObject.Properties['parentId'] | Should -BeNullOrEmpty
        }

        It 'Invoke-CWMCompanyServiceTemplateGenerate sends only generateAllRecordsFlag' {
            Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 -generateAllRecordsFlag $true | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            $B.generateAllRecordsFlag | Should -BeTrue
            @($B.PSObject.Properties) | Should -HaveCount 1
        }
    }

    Context 'Knowledge base articles' {
        It 'New-CWMKnowledgeBaseArticle POSTs the article body' {
            New-CWMKnowledgeBaseArticle -title 'T' -issue 'I' -resolution 'R' -board @{ id = 1 } | Out-Null
            $Request = $global:CWMTestRequests[0]
            $Request.Method | Should -Be 'Post'
            $Request.Uri | Should -Be "$CWMTestBaseUri/service/knowledgeBaseArticles"
            $B = $Request.Body | ConvertFrom-Json
            $B.title | Should -Be 'T'
            $B.issue | Should -Be 'I'
            $B.resolution | Should -Be 'R'
            $B.board.id | Should -Be 1
        }

        It 'Remove-CWMKnowledgeBaseArticle sends nothing with -WhatIf' {
            Remove-CWMKnowledgeBaseArticle -id 42 -WhatIf | Out-Null
            $global:CWMTestRequests | Should -HaveCount 0
        }

        It 'Remove-CWMKnowledgeBaseArticle declares ConfirmImpact Medium, like the other Remove-* functions' {
            $Binding = (Get-Command Remove-CWMKnowledgeBaseArticle).ScriptBlock.Attributes.Where({ $_ -is [System.Management.Automation.CmdletBindingAttribute] })[0]
            $Binding.ConfirmImpact | Should -Be 'Medium'
        }
    }

    Context 'Get-CWMTicket' {
        It 'sends childConditions in the search body' {
            Get-CWMTicket -childConditions 'configurations/id=1234' | Out-Null
            $Request = $global:CWMTestRequests[0]
            $Request.Method | Should -Be 'Post'
            $Request.Uri | Should -Be "$CWMTestBaseUri/service/tickets/search"
            ($Request.Body | ConvertFrom-Json).childConditions | Should -Be 'configurations/id=1234'
        }

        It 'calls Invoke-CWMSearchMaster without an id' {
            Mock Invoke-CWMSearchMaster -ModuleName ConnectWiseManageAPI { $true }
            $null = Get-CWMTicket -ErrorAction SilentlyContinue
            Should -Invoke Invoke-CWMSearchMaster -ModuleName ConnectWiseManageAPI -Times 1
        }

        It 'calls Invoke-CWMGetMaster when given an id' {
            Mock Invoke-CWMGetMaster -ModuleName ConnectWiseManageAPI {}
            $null = Get-CWMTicket -TicketID 1 -ErrorAction SilentlyContinue
            Should -Invoke Invoke-CWMGetMaster -ModuleName ConnectWiseManageAPI -Times 1
        }
    }

    Context 'Get-CWMReportColumn (#65)' {
        It 'returns an ordered dictionary of column name to definition' {
            Set-CWMTestResponse -Content '[{"id":{"type":"Numeric"}},{"name":{"type":"Text"}}]'
            $Result = Get-CWMReportColumn -Report 'Service'
            $Result | Should -BeOfType [System.Collections.IDictionary]
            @($Result.Keys) | Should -Be @('id', 'name')
            $Result['id'].type | Should -Be 'Numeric'
            $Result['name'].type | Should -Be 'Text'
            $global:CWMTestRequests | Should -HaveCount 1
            $global:CWMTestRequests[0].Uri | Should -BeLike '*/system/reports/Service/columns*'
        }

        It 'also handles a single object with several column properties' {
            Set-CWMTestResponse -Content '{"id":{"type":"Numeric"},"name":{"type":"Text"}}'
            $Result = Get-CWMReportColumn -Report 'Service'
            $Result | Should -BeOfType [System.Collections.IDictionary]
            $Result.Count | Should -Be 2
        }

        It 'returns nothing, without error, for an empty result' {
            Set-CWMTestResponse -Content '[]'
            $Err = $null
            Get-CWMReportColumn -Report 'Service' -ErrorVariable Err | Should -BeNullOrEmpty
            $Err | Should -BeNullOrEmpty
        }
    }

    Context 'Request bodies checked against the OpenAPI spec 2026.11' {
        It 'Update-CWMTimeSheet never sends its switches in the body' {
            Update-CWMTimeSheet -id 55 -Approve -approvalType Tier1Update -Confirm:$false | Out-Null
            Update-CWMTimeSheet -id 55 -Reject -Confirm:$false | Out-Null
            Update-CWMTimeSheet -id 55 -Reverse -Confirm:$false | Out-Null
            Update-CWMTimeSheet -id 55 -Submit -Confirm:$false | Out-Null
            $Approve, $Reject, $Reverse, $Submit = $global:CWMTestRequests
            $A = $Approve.Body | ConvertFrom-Json
            @($A.PSObject.Properties.Name | Sort-Object) | Should -Be @('approvalType', 'id')
            $A.approvalType | Should -Be 'Tier1Update'
            @(($Reject.Body | ConvertFrom-Json).PSObject.Properties.Name) | Should -Be @('id')
            $Reverse.Body | Should -BeNullOrEmpty
            $Submit.Body | Should -BeNullOrEmpty
        }

        It 'New-CWMCompanyTeam sends location and department references, also from the old int parameters' {
            New-CWMCompanyTeam -parentId 250 -teamRole @{ id = 1 } -locationId 2 -businessUnitId 10 -Confirm:$false | Out-Null
            New-CWMCompanyTeam -parentId 250 -teamRole @{ id = 1 } -location @{ id = 3 } -department @{ id = 11 } -Confirm:$false | Out-Null
            $First, $Second = $global:CWMTestRequests | ForEach-Object { $_.Body | ConvertFrom-Json }
            $First.location.id | Should -Be 2
            $First.department.id | Should -Be 10
            $First.PSObject.Properties['locationId'] | Should -BeNullOrEmpty
            $First.PSObject.Properties['businessUnitId'] | Should -BeNullOrEmpty
            $Second.location.id | Should -Be 3
            $Second.department.id | Should -Be 11
        }

        It 'New-CWMCompanyContact sends managerContact and assistantContact references, also from the old int parameters' {
            New-CWMCompanyContact -firstName 'A' -managerContactId 5 -assistantContact @{ id = 6 } -Confirm:$false | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            $B.managerContact.id | Should -Be 5
            $B.assistantContact.id | Should -Be 6
            $B.PSObject.Properties['managerContactId'] | Should -BeNullOrEmpty
        }

        It 'renamed fields keep their old names as aliases and send the schema name' {
            New-CWMCompanySite -parentId 250 -name 'Main' -billSeperateFlag $true -Confirm:$false | Out-Null
            New-CWMCompanyConfiguration -name 'PC' -type @{ id = 1 } -company @{ id = 250 } -mobilezGuid 'g' -locationID 2 -installedby @{ id = 3 } -Confirm:$false | Out-Null
            $Site, $Config = $global:CWMTestRequests | ForEach-Object { $_.Body }
            $Site | Should -Match '"billSeparateFlag"'
            $Site | Should -Not -Match 'billSeperateFlag'
            $Config | Should -Match '"mobileGuid"'
            $Config | Should -Match '"locationId"'
            $Config | Should -Match '"installedBy"'
            $Config | Should -Not -Match 'mobilezGuid'
        }

        It 'parameters with no schema counterpart are gone' {
            foreach ($Case in @(
                    @{ Command = 'Get-CWMTicketAllNote'; Parameter = 'id' }
                    @{ Command = 'Get-CWMProjectTicketAllNote'; Parameter = 'id' }
                    @{ Command = 'New-CWMTicket'; Parameter = 'dateEntered' }
                    @{ Command = 'New-CWMTicket'; Parameter = 'enteredBy' }
                    @{ Command = 'New-CWMProductCatalog'; Parameter = 'dateEntered' }
                    @{ Command = 'New-CWMProjectTicket'; Parameter = 'externalXRef' }
                    @{ Command = 'New-CWMMember'; Parameter = 'TimeZoneSetupReference' }
                    @{ Command = 'New-CWMMember'; Parameter = 'remotePackage' }
                )) {
                (Get-Command $Case.Command).Parameters.ContainsKey($Case.Parameter) | Should -BeFalse -Because "$($Case.Command) -$($Case.Parameter)"
            }
        }
    }

    Context 'Parameters, counts and URL escaping' {
        It 'Submit-CWMTimeSheet supports -WhatIf and sends no body' {
            (Get-Command Submit-CWMTimeSheet).Parameters.ContainsKey('WhatIf') | Should -BeTrue
            Submit-CWMTimeSheet -id 55 -WhatIf | Out-Null
            $global:CWMTestRequests | Should -HaveCount 0
            Submit-CWMTimeSheet -sheetId 55 -Confirm:$false | Out-Null
            $global:CWMTestRequests | Should -HaveCount 1
            $global:CWMTestRequests[0].Body | Should -BeNullOrEmpty
        }

        It 'Get-CWMAuditTrail and Get-CWMDocument return the number for -count' {
            Set-CWMTestResponse -Content '{"count":7}'
            Get-CWMAuditTrail -type Ticket -id 5 -count | Should -Be 7
            Get-CWMDocument -recordId 1 -recordType Ticket -count | Should -Be 7
            $global:CWMTestRequests | Should -HaveCount 2
            $global:CWMTestRequests[0].Uri | Should -BeLike '*/system/audittrail/count?type=Ticket&id=5'
            $global:CWMTestRequests[1].Uri | Should -BeLike '*/system/documents/count?recordId=1&recordType=Ticket'
        }

        It 'Get-CWMAuditTrail does not change the caller''s bound parameters' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-CWMGetMaster { $script:CapturedArguments = $Arguments }
                Get-CWMAuditTrail -type Ticket -id 5 -condition 'a=1' | Out-Null
                $script:CapturedArguments | Should -BeOfType [hashtable]
                $script:CapturedArguments.ContainsKey('id') | Should -BeFalse
                $script:CapturedArguments.condition | Should -Be 'a=1'
            }
        }

        It 'escapes string values that go into the URL' {
            Get-CWMAuditTrail -type Ticket -id 'a b/c' -deviceIdentifier 'x&y' | Out-Null
            Get-CWMReportColumn -Report 'My Report/1' | Out-Null
            New-CWMMemberToken -memberIdentifier 'j doe' -Confirm:$false | Out-Null
            $Audit, $Report, $Token = $global:CWMTestRequests | ForEach-Object { ([uri]$_.Uri).AbsoluteUri }
            $Audit | Should -BeExactly "$CWMTestBaseUri/system/audittrail?type=Ticket&id=a%20b%2Fc&deviceIdentifier=x%26y"
            $Report | Should -BeExactly "$CWMTestBaseUri/system/reports/My%20Report%2F1/columns"
            $Token | Should -BeExactly "$CWMTestBaseUri/system/members/j%20doe/tokens"
        }

        It 'Get-CWMReport escapes the report name' {
            Set-CWMTestResponse -Content '{"column_definitions":[],"row_values":[]}'
            Get-CWMReport -id 'My Report' | Out-Null
            ([uri]$global:CWMTestRequests[0].Uri).AbsoluteUri | Should -BeExactly "$CWMTestBaseUri/system/reports/My%20Report"
        }

        It 'Get-CWMOpportunity sends an array -fields as a comma-separated list' {
            Get-CWMOpportunity -fields 'id', 'name' | Out-Null
            [uri]::UnescapeDataString($global:CWMTestRequests[0].Uri) | Should -BeLike '*fields=id,name*'
        }

        It 'every -customFields parameter takes an array' {
            $Commands = Get-Command -Module ConnectWiseManageAPI | Where-Object { $_.Parameters -and $_.Parameters.ContainsKey('customFields') }
            $Commands | Should -Not -BeNullOrEmpty
            # [hashtable[]] or [array]; [array] (System.Array) also accepts custom field objects copied from a Get.
            $Commands | Where-Object { $T = $_.Parameters['customFields'].ParameterType; -not ($T.IsArray -or $T -eq [array]) } |
                ForEach-Object Name | Should -BeNullOrEmpty
        }

        It 'no parameter is single-precision [float], which rounds money values' {
            Get-Command -Module ConnectWiseManageAPI | ForEach-Object {
                $C = $_; $C.Parameters.Values | Where-Object { $_.ParameterType -in [single], [single[]] } | ForEach-Object { "$($C.Name) -$($_.Name)" }
            } | Should -BeNullOrEmpty
            New-CWMOpportunity -name 'N' -type @{ id = 1 } -primarySalesRep @{ id = 1 } -company @{ id = 1 } -contact @{ id = 1 } -totalSalesTax 1234567.89 -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
            ($global:CWMTestRequests[-1].Body | ConvertFrom-Json).totalSalesTax | Should -Be 1234567.89
        }

        It 'New-CWMCompanyNote keeps the company id out of the body, by -parentId or the old -id' {
            New-CWMCompanyNote -parentId 250 -text 'a' -Confirm:$false | Out-Null
            New-CWMCompanyNote -id 251 -text 'b' -Confirm:$false | Out-Null
            $global:CWMTestRequests[0].Uri | Should -BeLike '*/company/companies/250/notes'
            $global:CWMTestRequests[1].Uri | Should -BeLike '*/company/companies/251/notes'
            foreach ($R in $global:CWMTestRequests) { ($R.Body | ConvertFrom-Json).PSObject.Properties['id'] | Should -BeNullOrEmpty }
        }

        It '<Command> sends -deviceIdentifier as its own body property' -ForEach @(
            @{ Command = 'New-CWMTicketConfiguration' }
            @{ Command = 'New-CWMProjectTicketConfiguration' }
        ) {
            & $Command -parentId 9 -deviceIdentifier 'ABC' -Confirm:$false | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            $B.deviceIdentifier | Should -BeExactly 'ABC'
            $B.PSObject.Properties['id'] | Should -BeNullOrEmpty
        }

        It 'ConvertTo-CWMTime uses the invariant culture' {
            $Saved = [System.Threading.Thread]::CurrentThread.CurrentCulture
            try {
                [System.Threading.Thread]::CurrentThread.CurrentCulture = [cultureinfo]'fi-FI'
                ConvertTo-CWMTime ([datetime]::new(2026, 11, 7, 15, 4, 5, [DateTimeKind]::Utc)) -Raw | Should -BeExactly '2026-11-07T15:04:05Z'
                [System.Threading.Thread]::CurrentThread.CurrentCulture = [cultureinfo]'th-TH'
                ConvertTo-CWMTime ([datetime]::new(2026, 11, 7, 15, 4, 5, [DateTimeKind]::Utc)) -Raw | Should -BeExactly '2026-11-07T15:04:05Z'
            }
            finally { [System.Threading.Thread]::CurrentThread.CurrentCulture = $Saved }
        }

        It 'New-CWMExpenseEntry sends a single custom field as a JSON array' {
            InModuleScope ConnectWiseManageAPI {
                Mock Invoke-CWMNewMaster { $script:CapturedArguments = $Arguments }
                $Mandatory = @{}
                foreach ($P in (Get-Command New-CWMExpenseEntry).Parameters.Values) {
                    if ($P.Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] -and $_.Mandatory })) {
                        $Mandatory[$P.Name] = if ($P.ParameterType -eq [hashtable]) { @{ id = 1 } } elseif ($P.ParameterType -eq [string]) { 'x' } else { 1 }
                    }
                }
                New-CWMExpenseEntry @Mandatory -customFields @{ id = 4; value = 'Gold' } -Confirm:$false | Out-Null
                , $script:CapturedArguments.customFields | Should -BeOfType [hashtable[]]
            }
        }

        It '<Command> -<Parameter> is mandatory' -ForEach @(
            @{ Command = 'Get-CWMCompanyTeam'; Parameter = 'parentId' }
            @{ Command = 'New-CWMProductPickingShippingDetail'; Parameter = 'parentId' }
            @{ Command = 'New-CWMMarketingGroupCompany'; Parameter = 'parentId' }
            @{ Command = 'Get-CWMProductAdjustmentDetail'; Parameter = 'parentId' }
            @{ Command = 'New-CWMMemberToken'; Parameter = 'memberIdentifier' }
            @{ Command = 'New-CWMKnowledgeBaseArticle'; Parameter = 'title' }
            @{ Command = 'New-CWMKnowledgeBaseArticle'; Parameter = 'issue' }
            @{ Command = 'New-CWMKnowledgeBaseArticle'; Parameter = 'resolution' }
            @{ Command = 'New-CWMProjectTicket'; Parameter = 'project' }
            @{ Command = 'New-CWMOpportunityForecastItem'; Parameter = 'id' }
        ) {
            (Get-Command $Command).Parameters[$Parameter].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
        }

        It '<Command> -<Parameter> has the alias <Alias>' -ForEach @(
            @{ Command = 'Get-CWMContactType'; Parameter = 'condition'; Alias = 'conditions' }
            @{ Command = 'Remove-CWMDocument'; Parameter = 'id'; Alias = 'documentId' }
            @{ Command = 'Update-CWMPurchaseOrder'; Parameter = 'id'; Alias = 'purchaseOrderId' }
            @{ Command = 'Update-CWMProductAdjustment'; Parameter = 'id'; Alias = 'adjustmentId' }
            @{ Command = 'Update-CWMAgreementType'; Parameter = 'id'; Alias = 'agreementTypeId' }
            @{ Command = 'New-CWMMarketingGroupCompany'; Parameter = 'parentId'; Alias = 'groupId' }
            @{ Command = 'Get-CWMProductAdjustmentDetail'; Parameter = 'parentId'; Alias = 'adjustmentId' }
            @{ Command = 'Get-CWMCompanyNote'; Parameter = 'parentId'; Alias = 'companyId' }
            @{ Command = 'Get-CWMCompanyCustomNote'; Parameter = 'parentId'; Alias = 'companyId' }
            @{ Command = 'Remove-CWMCompanyNote'; Parameter = 'id'; Alias = 'noteId' }
            @{ Command = 'Remove-CWMAgreementAddition'; Parameter = 'parentId'; Alias = 'agreementId' }
            @{ Command = 'Get-CWMInventory'; Parameter = 'parentId'; Alias = 'warehouseBinId' }
            @{ Command = 'Get-CWMPurchaseOrderLineItem'; Parameter = 'parentId'; Alias = 'purchaseOrderId' }
            @{ Command = 'Get-CWMOpportunityForecast'; Parameter = 'parentId'; Alias = 'opportunityId' }
            @{ Command = 'New-CWMOpportunityForecastItem'; Parameter = 'parentId'; Alias = 'opportunityId' }
        ) {
            (Get-Command $Command).Parameters[$Parameter].Aliases | Should -Contain $Alias
        }

        It 'wrong aliases are gone' {
            (Get-Command Remove-CWMDocument).Parameters['id'].Aliases | Should -Not -Contain 'somethingId'
            (Get-Command Get-CWMCompanyState).Parameters['id'].Aliases | Should -Not -Contain 'companyId'
            (Get-Command Get-CWMCompanyCountry).Parameters['id'].Aliases | Should -Not -Contain 'companyId'
            (Get-Command Update-CWMPurchaseOrder).Parameters['id'].Aliases | Should -Not -Contain 'catalogId'
            (Get-Command Update-CWMProductAdjustment).Parameters['id'].Aliases | Should -Not -Contain 'catalogId'
            (Get-Command Update-CWMAgreementType).Parameters['id'].Aliases | Should -Not -Contain 'agreementId'
        }

        It 'New-CWMMarketingGroupCompany keeps the group id out of the body' {
            New-CWMMarketingGroupCompany -groupId 3 -id 250 -Confirm:$false | Out-Null
            $B = $global:CWMTestRequests[0].Body | ConvertFrom-Json
            $B.id | Should -Be 250
            $B.PSObject.Properties['groupId'] | Should -BeNullOrEmpty
            $B.PSObject.Properties['parentId'] | Should -BeNullOrEmpty
        }

        It 'New-CWMCompanyContact sends -portalPassword as plain text and checks its length' {
            $Password = ConvertTo-SecureString 'Pa55word!' -AsPlainText -Force
            New-CWMCompanyContact -firstName 'A' -portalPassword $Password -Confirm:$false | Out-Null
            ($global:CWMTestRequests[0].Body | ConvertFrom-Json).portalPassword | Should -BeExactly 'Pa55word!'
            $TooLong = ConvertTo-SecureString ('x' * 16) -AsPlainText -Force
            { New-CWMCompanyContact -firstName 'A' -portalPassword $TooLong -Confirm:$false } | Should -Throw
        }

        It '<Command> passes a copy, not $PSBoundParameters, to Invoke-CWMNewMaster' -ForEach @(
            @{ Command = 'New-CWMCompanyServiceTemplate'; Splat = @{ parentId = 250; name = 'N'; summary = 'S'; board = @{ id = 1 }; status = @{ id = 2 } }; Key = 'company' }
            @{ Command = 'New-CWMCompanyTeam'; Splat = @{ parentId = 250; teamRole = @{ id = 1 }; locationId = 2 }; Key = 'location' }
            @{ Command = 'New-CWMCompanyContact'; Splat = @{ firstName = 'A'; managerContactId = 5 }; Key = 'managerContact' }
        ) {
            InModuleScope ConnectWiseManageAPI -Parameters @{ Command = $Command; Splat = $Splat; Key = $Key } {
                param($Command, $Splat, $Key)
                Mock Invoke-CWMNewMaster { $script:CapturedArguments = $Arguments }
                & $Command @Splat | Out-Null
                $script:CapturedArguments | Should -BeOfType [hashtable]
                $script:CapturedArguments[$Key].id | Should -BeGreaterThan 0
            }
        }

        It 'Test-CWMApiCoverage.ps1 does not OR Tls12 into a SystemDefault SecurityProtocol' {
            $Text = Get-Content "$PSScriptRoot/../Tools/Test-CWMApiCoverage.ps1" -Raw
            $Text | Should -Not -Match '::SecurityProtocol\s*=\s*\[Net\.ServicePointManager\]::SecurityProtocol\s*-bor'
            $Text | Should -Match '\[int\]\$Protocol -ne 0'
        }
    }

    Context 'New-CWMProjectTicket (#43)' {
        It 'POSTs to /project/tickets with project.id in the JSON body' {
            Set-CWMTestResponse -StatusCode 201 -Content '{"id":1}'
            $Result = New-CWMProjectTicket -summary 'Migrate file shares' -project @{ id = 386 } -phase @{ id = 12 } -Confirm:$false
            $Result.id | Should -Be 1
            $Request = $global:CWMTestRequests[0]
            $Request.Method | Should -Be 'Post'
            $Request.Uri | Should -Match '/project/tickets$'
            $B = $Request.Body | ConvertFrom-Json
            $B.project.id | Should -Be 386
            $B.phase.id | Should -Be 12
            $B.summary | Should -Be 'Migrate file shares'
        }
    }

    Context 'Ticket children use the endpoints the API documentation recommends' {
        It '<Name> sends GET <Expected>' -ForEach @(
            @{ Name = 'Get-CWMTicketTimeEntry'; Call = { Get-CWMTicketTimeEntry -ticketId 1234 -condition "member/identifier='jdoe'" }; Expected = "/time/entries?conditions=(chargeToType='ServiceTicket' or chargeToType='ProjectTicket') and chargeToId=1234 and (member/identifier='jdoe')" }
            @{ Name = 'Get-CWMTicketScheduleEntry'; Call = { Get-CWMTicketScheduleEntry -parentId 1234 }; Expected = '/schedule/entries?conditions=type/id=4 and objectId=1234' }
            @{ Name = 'Get-CWMTicketScheduleEntry -count'; Call = { Get-CWMTicketScheduleEntry -parentId 1234 -count }; Expected = '/schedule/entries/count?conditions=type/id=4 and objectId=1234' }
            @{ Name = 'Get-CWMTicketProduct'; Call = { Get-CWMTicketProduct -parentId 1234 }; Expected = '/procurement/products?conditions=ticket/id=1234' }
            @{ Name = 'Get-CWMTicketDocument'; Call = { Get-CWMTicketDocument -parentId 1234 }; Expected = '/system/documents?recordId=1234&recordType=Ticket' }
        ) {
            $null = & $Call
            $ExpectedUri = "$CWMTestBaseUri$Expected"
            Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 1 -Exactly -ParameterFilter {
                $Method -eq 'GET' -and [System.Web.HttpUtility]::UrlDecode($Uri) -ceq $ExpectedUri
            }
        }
    }

    Context 'Download switches without the id they need' {
        It '<Name> writes an error and sends nothing' -ForEach @(
            @{ Name = 'Get-CWMDocument -download'; Call = { Get-CWMDocument -download -ErrorAction SilentlyContinue -ErrorVariable Err; $Err } }
            @{ Name = 'Get-CWMDocument -OutFile'; Call = { Get-CWMDocument -id 9 -OutFile 'x.bin' -ErrorAction SilentlyContinue -ErrorVariable Err; $Err } }
            @{ Name = 'Get-CWMInvoice -pdf'; Call = { Get-CWMInvoice -pdf -ErrorAction SilentlyContinue -ErrorVariable Err; $Err } }
            @{ Name = 'Get-CWMInvoice -OutFile'; Call = { Get-CWMInvoice -id 1 -OutFile 'x.pdf' -ErrorAction SilentlyContinue -ErrorVariable Err; $Err } }
        ) {
            $Errors = @(& $Call)
            $Errors.Count | Should -BeGreaterThan 0
            Should -Invoke Invoke-WebRequest -ModuleName ConnectWiseManageAPI -Times 0
        }
    }

    Context 'New-CWMDocument multipart body' {
        BeforeAll {
            $TestFile = Join-Path ([System.IO.Path]::GetTempPath()) ('CWMDocument-{0}.bin' -f [guid]::NewGuid())
            [System.IO.File]::WriteAllBytes($TestFile, [byte[]](0x41, 0x89, 0xFF, 0x00))
        }

        AfterAll {
            Remove-Item $TestFile -Force -ErrorAction SilentlyContinue
        }

        BeforeEach {
            Set-CWMTestResponse -StatusCode 201 -Content '{"id":7}'
        }

        It 'resolves a relative -FilePath against the current PowerShell location' {
            Push-Location (Split-Path $TestFile)
            try {
                New-CWMDocument -recordType Ticket -recordId 123 -title 'T' -FilePath (Split-Path $TestFile -Leaf) -Confirm:$false | Out-Null
            }
            finally { Pop-Location }
            $global:CWMTestRequests | Should -HaveCount 1
        }

        It 'reads a file object from Get-ChildItem by its full path, from any location' {
            $Item = Get-ChildItem (Split-Path $TestFile) -Filter (Split-Path $TestFile -Leaf)
            Push-Location $HOME
            try {
                New-CWMDocument -recordType Ticket -recordId 123 -title 'T' -FilePath $Item -Confirm:$false | Out-Null
            }
            finally { Pop-Location }
            $global:CWMTestRequests | Should -HaveCount 1
            $Text = [System.Text.Encoding]::UTF8.GetString($global:CWMTestRequests[0].Body)
            $Text | Should -Match ([regex]::Escape("filename=`"$($Item.Name)`""))
        }

        It 'sends the exact file bytes between the part headers and the closing boundary' {
            $Result = New-CWMDocument -recordType Ticket -recordId 123 -title 'T' -FilePath $TestFile -FileName 'a.bin' -Confirm:$false
            $Result.id | Should -Be 7

            $global:CWMTestRequests | Should -HaveCount 1
            $Body = $global:CWMTestRequests[0].Body
            $ContentType = $global:CWMTestRequests[0].ContentType
            , $Body | Should -BeOfType [byte[]]

            $ContentType | Should -Match '^multipart/form-data; boundary=[0-9a-f-]{36}$'
            $Boundary = ($ContentType -split 'boundary=')[1]

            # Latin-1 maps every byte to one char, so indexes in the string equal indexes in the byte array
            $Text = [System.Text.Encoding]::GetEncoding(28591).GetString($Body)
            $Header = "Content-Type: application/octet-stream`r`n`r`n"
            $Start = $Text.IndexOf($Header) + $Header.Length
            $Start | Should -BeGreaterThan $Header.Length

            [byte[]]$Body[$Start..($Start + 3)] | Should -Be ([byte[]](0x41, 0x89, 0xFF, 0x00))
            $Text.Substring($Start + 4) | Should -BeExactly "`r`n--$Boundary--`r`n"
            $Text | Should -Match 'filename="a\.bin"'
            $Text | Should -Match "name=`"recordId`"`r`n`r`n123`r`n"
            $Text | Should -Match "name=`"PrivateFlag`"`r`n`r`nTrue`r`n"
        }

        It 'keeps quotes and line breaks out of the multipart headers' {
            New-CWMDocument -recordType Ticket -recordId 123 -title "Line1`r`nLine2" -FilePath $TestFile -FileName "a`"b`r`nc.bin" -Confirm:$false | Out-Null
            $Text = [System.Text.Encoding]::UTF8.GetString($global:CWMTestRequests[0].Body)
            $Text | Should -Match 'filename="a_b__c\.bin"'
            $Text | Should -Match "name=`"Title`"`r`n`r`nLine1 Line2`r`n"
        }

        It 'still sends URL documents as a multipart byte body' {
            New-CWMDocument -recordType Company -recordId 250 -title 'Runbook' -URL 'https://wiki.example.com/x' -Confirm:$false | Out-Null
            $Text = [System.Text.Encoding]::UTF8.GetString($global:CWMTestRequests[0].Body)
            $Boundary = ($global:CWMTestRequests[0].ContentType -split 'boundary=')[1]
            $Text | Should -Match "name=`"url`"`r`n`r`nhttps://wiki\.example\.com/x`r`n--$Boundary--`r`n$"
        }
    }
}
