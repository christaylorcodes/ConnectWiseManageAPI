#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Read-only live tests against a real ConnectWise Manage server. Nothing is created, changed or deleted, so
# these are safe to run against production. Tagged 'Integration': they run only with
#     ./Tests/Invoke-Tests.ps1 -Test -Live
# which loads the connection settings from Tests/live.local.ps1 (gitignored; copy Tests/live.example.ps1).
#
# Required: CWMServer, CWMCompany, CWMClientID, CWMAPIMemberPub, CWMAPIMemberPriv
# Optional (each sign-in test skips itself when its own variables are missing):
#   CWMPub/CWMPriv (a member's own keys), CWMUserName (impersonation; with CWMUserPassword, cookie sign-in)
#
# A 403 means the API member's security role cannot read that area: the test is marked inconclusive, not
# failed. Endpoints whose parent record does not exist on this server (no warehouse bins, no agreements, ...)
# are skipped.

BeforeDiscovery {
    $script:NoServer = [string]::IsNullOrEmpty($env:CWMServer)
    $script:NoImpersonation = $NoServer -or [string]::IsNullOrEmpty($env:CWMUserName)
    $script:NoMemberKeys = $NoServer -or [string]::IsNullOrEmpty($env:CWMPub) -or [string]::IsNullOrEmpty($env:CWMPriv)
    $script:NoCookie = $NoImpersonation -or [string]::IsNullOrEmpty($env:CWMUserPassword)

    Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
    # Every exported Get-* function (aliases excluded: they point at the same functions)
    $script:GetCases = Get-Command -Module ConnectWiseManageAPI -Name 'Get-*' -CommandType Function |
        Sort-Object Name |
        ForEach-Object { @{ Name = $_.Name; HasPageSize = $_.Parameters.ContainsKey('pageSize') } }
}

BeforeAll {
    Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force

    $script:KeyConnection = @{
        Server     = $env:CWMServer
        Company    = $env:CWMCompany
        PubKey     = $env:CWMAPIMemberPub
        PrivateKey = $env:CWMAPIMemberPriv
        ClientID   = $env:CWMClientID
    }

    function Invoke-LiveCall {
        # Runs a call; a 403 marks the test inconclusive (security role), any other error fails it
        param([scriptblock]$ScriptBlock)
        try { & $ScriptBlock }
        catch {
            if ("$_" -match 'HTTP status: 403') {
                Set-ItResult -Inconclusive -Because 'the API member''s security role cannot read this (403)'
            }
            throw
        }
    }

    $script:LiveIdCache = @{}
    function Get-LiveFirst {
        # The first record a list call returns (cached), or $null when there is none
        param([string]$Command, [hashtable]$Splat = @{})
        $Key = "$Command $(($Splat.GetEnumerator() | Sort-Object Key | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join ';')"
        if (!$script:LiveIdCache.ContainsKey($Key)) {
            $Result = @(& $Command @Splat -pageSize 1 -ErrorAction Stop)
            $script:LiveIdCache[$Key] = if ($Result.Count) { $Result[0] } else { $null }
        }
        $script:LiveIdCache[$Key]
    }

    function Get-LiveFirstId {
        param([string]$Command, [hashtable]$Splat = @{})
        $First = Get-LiveFirst -Command $Command -Splat $Splat
        if ($First) { $First.id }
    }

    # Arguments for Get-* functions that need a route id: each returns a splat, or $null when the server has
    # no parent record to use
    $script:Resolvers = @{}
    $Parents = @{
        'Get-CWMAgreement'          = 'Get-CWMAgreementAddition', 'Get-CWMAgreementSite'
        'Get-CWMCompany'            = 'Get-CWMCompanyServiceTemplate', 'Get-CWMCompanySite', 'Get-CWMCompanyTeam', 'Get-CWMCompanyTypeAssociation'
        'Get-CWMCompanyContact'     = 'Get-CWMCompanyContactNote'
        'Get-CWMDepartment'         = 'Get-CWMDepartmentLocation'
        'Get-CWMMarketingGroup'     = 'Get-CWMMarketingGroupCompany', 'Get-CWMMarketingGroupContact'
        'Get-CWMOpportunity'        = 'Get-CWMOpportunityForecast', 'Get-CWMOpportunityNote'
        'Get-CWMProduct'            = 'Get-CWMProductComponent', 'Get-CWMProductPickingShippingDetail'
        'Get-CWMProductAdjustment'  = 'Get-CWMProductAdjustmentDetail'
        'Get-CWMProject'            = 'Get-CWMProjectPhase', 'Get-CWMProjectTeamMember'
        'Get-CWMProjectTicket'      = 'Get-CWMProjectTicketAllNote', 'Get-CWMProjectTicketConfiguration'
        'Get-CWMPurchaseOrder'      = 'Get-CWMPurchaseOrderLineItem'
        'Get-CWMScheduleHolidayList' = 'Get-CWMScheduleHoliday'
        'Get-CWMServiceBoard'       = 'Get-CWMBoardItem', 'Get-CWMBoardStatus', 'Get-CWMBoardSubtype', 'Get-CWMBoardTeam', 'Get-CWMBoardType', 'Get-CWMBoardTypeSubTypeItemAssociation'
        'Get-CWMServiceTemplate'    = 'Get-CWMServiceTemplateResource'
        'Get-CWMTicket'             = 'Get-CWMTicketAllNote', 'Get-CWMTicketConfiguration', 'Get-CWMTicketNote', 'Get-CWMTicketTask'
        'Get-CWMWarehouseBin'       = 'Get-CWMInventory'
    }
    # Child -> parent list function. (No GetNewClosure: a closure cannot see the helper functions above.)
    $script:ParentOf = @{}
    foreach ($Parent in $Parents.Keys) {
        foreach ($Child in $Parents[$Parent]) {
            $script:ParentOf[$Child] = $Parent
            $script:Resolvers[$Child] = { $Id = Get-LiveFirstId $ParentOf[$Name]; if ($Id) { @{ parentId = $Id } } }
        }
    }
    $script:Resolvers['Get-CWMCompanyNote'] = { $Id = Get-LiveFirstId 'Get-CWMCompany'; if ($Id) { @{ CompanyID = $Id } } }
    $script:Resolvers['Get-CWMCompanyCustomNote'] = $script:Resolvers['Get-CWMCompanyNote']
    $script:Resolvers['Get-CWMBoardItemAssociation'] = {
        $Board = Get-LiveFirstId 'Get-CWMServiceBoard'
        if ($Board) { $Item = Get-LiveFirstId 'Get-CWMBoardItem' @{ parentId = $Board } }
        if ($Item) { @{ grandParentId = $Board; parentId = $Item } }
    }
    $script:Resolvers['Get-CWMBoardStatusNotification'] = {
        $Board = Get-LiveFirstId 'Get-CWMServiceBoard'
        if ($Board) { $Status = Get-LiveFirstId 'Get-CWMBoardStatus' @{ parentId = $Board } }
        if ($Status) { @{ grandparentId = $Board; parentId = $Status } }
    }
    $script:Resolvers['Get-CWMOpportunityForecastItem'] = {
        $Opportunity = Get-LiveFirstId 'Get-CWMOpportunity'
        if ($Opportunity) { $Item = @((Get-CWMOpportunityForecast -parentId $Opportunity -ErrorAction Stop).forecastItems)[0] }
        if ($Item) { @{ parentId = $Opportunity; id = $Item.id } }
    }
    $script:Resolvers['Get-CWMAuditTrail'] = { $Id = Get-LiveFirstId 'Get-CWMTicket'; if ($Id) { @{ type = 'Ticket'; id = "$Id" } } }
    $script:Resolvers['Get-CWMDocument'] = { $Id = Get-LiveFirstId 'Get-CWMTicket'; if ($Id) { @{ recordType = 'Ticket'; recordId = $Id } } }
    $script:Resolvers['Get-CWMReportColumn'] = { $Report = Get-LiveFirst 'Get-CWMReport'; if ($Report) { @{ Report = $Report.name } } }

    Connect-CWM @KeyConnection -Force -ErrorAction Stop
}

AfterAll {
    Disconnect-CWM -ErrorAction SilentlyContinue
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Live: sign-in' -Tag 'Integration' -Skip:$NoServer {

    AfterAll { Connect-CWM @KeyConnection -Force -ErrorAction Stop }

    It 'API member keys' {
        { Connect-CWM @KeyConnection -Force -ErrorAction Stop } | Should -Not -Throw
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection.ConnectionMethod | Should -Be 'Key' }
        Get-CWMSystemInfo -ErrorAction Stop | Should -Not -BeNullOrEmpty
    }

    It 'stores the server''s current API version' {
        Connect-CWM @KeyConnection -Force -ErrorAction Stop
        $null = Get-CWMSystemInfo -ErrorAction Stop
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection.'api-current-version' | Should -Match '^\d{4}\.\d+'
        }
    }

    It 'member impersonation' -Skip:$NoImpersonation {
        { Connect-CWM @KeyConnection -MemberID $env:CWMUserName -Force -ErrorAction Stop } | Should -Not -Throw
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection.ConnectionMethod | Should -Be 'Impersonation' }
        (Get-CWMMyMember -ErrorAction Stop).identifier | Should -Be $env:CWMUserName
    }

    It 'a member''s own keys' -Skip:$NoMemberKeys {
        $Connection = $KeyConnection.Clone()
        $Connection.PubKey = $env:CWMPub
        $Connection.PrivateKey = $env:CWMPriv
        { Connect-CWM @Connection -Force -ErrorAction Stop } | Should -Not -Throw
        Get-CWMSystemInfo -ErrorAction Stop | Should -Not -BeNullOrEmpty
    }

    It 'cookie sign-in with a username and password' -Skip:$NoCookie {
        $Password = ConvertTo-SecureString -AsPlainText -Force $env:CWMUserPassword
        $Connection = @{
            Server      = $env:CWMServer
            Company     = $env:CWMCompany
            ClientID    = $env:CWMClientID
            Credentials = New-Object PSCredential $env:CWMUserName, $Password
        }
        { Connect-CWM @Connection -Force -ErrorAction Stop } | Should -Not -Throw
        InModuleScope ConnectWiseManageAPI { $script:CWMServerConnection.ConnectionMethod | Should -Be 'Cookie' }
        Get-CWMSystemInfo -ErrorAction Stop | Should -Not -BeNullOrEmpty
    }
}

Describe 'Live: every Get-* function reaches its endpoint' -Tag 'Integration' -Skip:$NoServer {

    It '<Name>' -ForEach $GetCases {
        $Splat = @{}
        if ($Resolvers.ContainsKey($Name)) {
            $Route = Invoke-LiveCall { & $Resolvers[$Name] }
            if (!$Route) {
                Set-ItResult -Skipped -Because 'this server has no parent record to read it from'
                return
            }
            $Splat += $Route
        }
        if ($HasPageSize -and !$Splat.ContainsKey('id')) { $Splat.pageSize = 1 }

        # A wrong path (404) or rejected parameter (400) throws here
        Invoke-LiveCall { $null = & $Name @Splat -ErrorAction Stop }
    }
}

Describe 'Live: query parameters' -Tag 'Integration' -Skip:$NoServer {

    BeforeAll {
        $script:Company = Get-LiveFirst 'Get-CWMCompany'
    }

    It '-count returns a number' {
        $Count = Get-CWMCompany -count -ErrorAction Stop
        $Count | Should -BeOfType [ValueType]
        $Count | Should -BeGreaterThan 0
    }

    It '-id returns that record' {
        (Get-CWMCompany -id $Company.id -ErrorAction Stop).id | Should -Be $Company.id
    }

    It '-condition filters' {
        $Result = @(Get-CWMCompany -condition "id = $($Company.id)" -ErrorAction Stop)
        $Result.Count | Should -Be 1
        $Result[0].id | Should -Be $Company.id
    }

    It '-condition with a quoted string value' {
        $Name = $Company.name -replace "'", "\'"
        $Result = @(Get-CWMCompany -condition "name = '$Name'" -ErrorAction Stop)
        $Result.id | Should -Contain $Company.id
    }

    It '-orderBy sorts' {
        $Ids = @(Get-CWMCompany -orderBy 'id desc' -pageSize 3 -ErrorAction Stop).id
        $Ids.Count | Should -BeGreaterThan 0
        $Ids | Should -Be @($Ids | Sort-Object -Descending)
    }

    It '-fields limits the properties returned' {
        $Result = Get-CWMCompany -id $Company.id -fields 'id', 'name' -ErrorAction Stop
        $Result.id | Should -Be $Company.id
        $Result.PSObject.Properties.Name | Should -Not -Contain 'addressLine1'
    }

    It '-childConditions filters on a list field' {
        $TypeId = @($Company.types)[0].id
        if (!$TypeId) { Set-ItResult -Skipped -Because 'the first company has no type'; return }
        $Result = @(Get-CWMCompany -childConditions "types/id = $TypeId" -pageSize 5 -ErrorAction Stop)
        $Result.id | Should -Not -BeNullOrEmpty
    }

    It '-page and -pageSize return different pages' {
        if ((Get-CWMCompany -count -ErrorAction Stop) -lt 2) { Set-ItResult -Skipped -Because 'fewer than 2 companies'; return }
        $First = Get-CWMCompany -orderBy 'id asc' -pageSize 1 -page 1 -ErrorAction Stop
        $Second = Get-CWMCompany -orderBy 'id asc' -pageSize 1 -page 2 -ErrorAction Stop
        $Second.id | Should -BeGreaterThan $First.id
    }

    It '-all follows the paging links and returns every record' {
        # A small list, read with a small page size so -all has to walk several pages
        foreach ($Command in 'Get-CWMPriority', 'Get-CWMCompanyStatus', 'Get-CWMCompanyType', 'Get-CWMServiceBoard') {
            $Count = & $Command -count -ErrorAction Stop
            if ($Count -ge 3 -and $Count -le 300) { break }
            $Command = $null
        }
        if (!$Command) { Set-ItResult -Skipped -Because 'no small list with 3-300 records'; return }

        $All = @(& $Command -all -pageSize 2 -ErrorAction Stop)
        $All.Count | Should -Be $Count -Because "$Command -count said $Count"
        @($All.id | Select-Object -Unique).Count | Should -Be $Count -Because 'no page is read twice'
    }
}

Describe 'Live: Get-CWMTicket (search)' -Tag 'Integration' -Skip:$NoServer {

    BeforeAll {
        $script:Ticket = Get-LiveFirst 'Get-CWMTicket'
    }

    It 'returns at most -pageSize tickets' {
        if (!$Ticket) { Set-ItResult -Skipped -Because 'no tickets'; return }
        @(Get-CWMTicket -pageSize 2 -ErrorAction Stop).Count | Should -BeLessOrEqual 2
    }

    It '-condition finds a ticket' {
        if (!$Ticket) { Set-ItResult -Skipped -Because 'no tickets'; return }
        (Get-CWMTicket -condition "id = $($Ticket.id)" -ErrorAction Stop).id | Should -Be $Ticket.id
    }

    It '-count with -condition matches -all with the same condition' {
        if (!$Ticket) { Set-ItResult -Skipped -Because 'no tickets'; return }
        $Condition = "company/id = $($Ticket.company.id)"
        $Count = Get-CWMTicket -count -condition $Condition -ErrorAction Stop
        if ($Count -gt 300) { Set-ItResult -Skipped -Because "$Count tickets is too many to read for a test"; return }
        @(Get-CWMTicket -condition $Condition -all -pageSize 25 -ErrorAction Stop).Count | Should -Be $Count
    }
}
