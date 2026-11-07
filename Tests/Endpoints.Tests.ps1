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
        # Unbundle (POST, not DELETE)
        @{ Name = 'Remove-CWMTicketChild'; HttpMethod = 'Post'; Path = '/service/tickets/100/detachChildren'; Call = { Remove-CWMTicketChild -ParentTicketID 100 -ChildTicketIDs 201 -Confirm:$false } }
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

        It 'New-CWMKnowledgeBaseArticle requires title, issue and resolution' {
            $Params = (Get-Command New-CWMKnowledgeBaseArticle).Parameters
            foreach ($Name in 'title', 'issue', 'resolution') {
                $Params[$Name].Attributes.Where({ $_ -is [System.Management.Automation.ParameterAttribute] }).Mandatory | Should -Contain $true
            }
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
        It 'sends childConditions in the search body (issue #38 example)' {
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

        It 'requires -project' {
            (Get-Command New-CWMProjectTicket).Parameters['project'].Attributes |
                Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] } |
                ForEach-Object { $_.Mandatory } | Should -Contain $true
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
        }

        It 'still sends URL documents as a multipart byte body' {
            New-CWMDocument -recordType Company -recordId 250 -title 'Runbook' -URL 'https://wiki.example.com/x' -Confirm:$false | Out-Null
            $Text = [System.Text.Encoding]::UTF8.GetString($global:CWMTestRequests[0].Body)
            $Boundary = ($global:CWMTestRequests[0].ContentType -split 'boundary=')[1]
            $Text | Should -Match "name=`"url`"`r`n`r`nhttps://wiki\.example\.com/x`r`n--$Boundary--`r`n$"
        }
    }
}
