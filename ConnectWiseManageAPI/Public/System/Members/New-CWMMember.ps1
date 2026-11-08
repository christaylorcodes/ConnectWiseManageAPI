<#
.SYNOPSIS
    Creates a member.

.DESCRIPTION
    Creates a member in ConnectWise Manage. Calls POST /system/members; only the parameters you pass are
    sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER identifier
    Identifier. Max length 15. Required by the API.

.PARAMETER password
    Password. Conditionally required. API Member will get random password generated Max length 60.

.PARAMETER firstName
    First name. Max length 30. Required by the API.

.PARAMETER middleInitial
    Middle initial. Max length 1.

.PARAMETER lastName
    Last name. Max length 30. Required by the API.

.PARAMETER title
    Title.

.PARAMETER reportCard
    Report card reference, for example @{ id = 1 }.

.PARAMETER licenseClass
    License class. One of: A, C, F, X. F = Full Member, A = API Member, C = StreamlineIT Member, X =
    Subcontractor Member. Required by the API.

.PARAMETER disableOnlineFlag
    Disable online flag. $true or $false.

.PARAMETER enableMobileFlag
    Enable mobile flag. $true or $false.

.PARAMETER type
    Type reference, for example @{ id = 1 }.

.PARAMETER employeeIdentifer
    Employee identifer. Max length 10.

.PARAMETER vendorNumber
    Vendor number.

.PARAMETER notes
    Notes.

.PARAMETER timeZone
    Time zone reference, for example @{ id = 1 }.

.PARAMETER country
    Country reference, for example @{ id = 1 }.

.PARAMETER serviceBoardTeamIds
    Service board team ids. An array of integers.

.PARAMETER enableMobileGpsFlag
    Enable mobile gps flag. $true or $false.

.PARAMETER inactiveDate
    Inactive date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER lastLogin
    Last login.

.PARAMETER photo
    Photo reference, for example @{ id = 1 }.

.PARAMETER partnerPortalFlag
    Partner portal flag. $true or $false.

.PARAMETER clientId
    Client id.

.PARAMETER stsUserAdminUrl
    Sts user admin URL.

.PARAMETER token
    Token.

.PARAMETER toastNotificationFlag
    Toast notification flag. $true or $false.

.PARAMETER memberPersonas
    Member personas. An array of integers.

.PARAMETER office365
    Office 365 reference, for example @{ id = 1 }.

.PARAMETER officeEmail
    Office email. Max length 250.

.PARAMETER officePhone
    Office phone. Max length 15.

.PARAMETER officeExtension
    Office extension. Max length 10.

.PARAMETER mobileEmail
    Mobile email. Max length 250.

.PARAMETER mobilePhone
    Mobile phone. Max length 15.

.PARAMETER mobileExtension
    Mobile extension. Max length 10.

.PARAMETER homeEmail
    Home email. Max length 250.

.PARAMETER homePhone
    Home phone. Max length 15.

.PARAMETER homeExtension
    Home extension. Max length 10.

.PARAMETER defaultEmail
    Default email. One of: Office, Mobile, Home. Required by the API.

.PARAMETER primaryEmail
    Primary email. Max length 250.

.PARAMETER defaultPhone
    Default phone. One of: Office, Mobile, Home. Required by the API.

.PARAMETER securityRole
    Security role reference, for example @{ id = 1 }. Required by the API.

.PARAMETER adminFlag
    Admin flag. $true or $false.

.PARAMETER structureLevel
    Structure level reference, for example @{ id = 1 }.

.PARAMETER securityLocation
    Security location reference, for example @{ id = 1 }.

.PARAMETER defaultLocation
    Default location reference, for example @{ id = 1 }.

.PARAMETER defaultDepartment
    Default department reference, for example @{ id = 1 }.

.PARAMETER reportsTo
    Reports to reference, for example @{ id = 1 }.

.PARAMETER restrictLocationFlag
    Restrict location flag. $true or $false.

.PARAMETER restrictDepartmentFlag
    Restrict department flag. $true or $false.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER timeApprover
    Time approver reference, for example @{ id = 1 }.

.PARAMETER expenseApprover
    Expense approver reference, for example @{ id = 1 }.

.PARAMETER billableForecast
    Billable forecast. A number.

.PARAMETER dailyCapacity
    Daily capacity. A number.

.PARAMETER hourlyCost
    Hourly cost. A number.

.PARAMETER hourlyRate
    Hourly rate. A number.

.PARAMETER includeInUtilizationReportingFlag
    Include in utilization reporting flag. $true or $false.

.PARAMETER requireExpenseEntryFlag
    Require expense entry flag. $true or $false.

.PARAMETER requireTimeSheetEntryFlag
    Require time sheet entry flag. $true or $false.

.PARAMETER requireStartAndEndTimeOnTimeEntryFlag
    Require start and end time on time entry flag. $true or $false.

.PARAMETER allowInCellEntryOnTimeSheet
    Allow in cell entry on time sheet. $true or $false.

.PARAMETER enterTimeAgainstCompanyFlag
    Enter time against company flag. $true or $false.

.PARAMETER allowExpensesEnteredAgainstCompaniesFlag
    Allow expenses entered against companies flag. $true or $false.

.PARAMETER timeReminderEmailFlag
    Time reminder email flag. $true or $false.

.PARAMETER daysTolerance
    Days tolerance. An integer.

.PARAMETER minimumHours
    Minimum hours. A number.

.PARAMETER timeSheetStartDate
    Time sheet start date.

.PARAMETER hireDate
    Hire date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw. Required by
    the API.

.PARAMETER serviceDefaultLocation
    Service default location reference, for example @{ id = 1 }.

.PARAMETER serviceDefaultDepartment
    Service default department reference, for example @{ id = 1 }.

.PARAMETER serviceDefaultBoard
    Service default board reference, for example @{ id = 1 }.

.PARAMETER restrictServiceDefaultLocationFlag
    Restrict service default location flag. $true or $false.

.PARAMETER restrictServiceDefaultDepartmentFlag
    Restrict service default department flag. $true or $false.

.PARAMETER excludedServiceBoardIds
    Excluded service board ids. An array of integers.

.PARAMETER projectDefaultLocation
    Project default location reference, for example @{ id = 1 }.

.PARAMETER projectDefaultDepartment
    Project default department reference, for example @{ id = 1 }.

.PARAMETER projectDefaultBoard
    Project default board reference, for example @{ id = 1 }.

.PARAMETER restrictProjectDefaultLocationFlag
    Restrict project default location flag. $true or $false.

.PARAMETER restrictProjectDefaultDepartmentFlag
    Restrict project default department flag. $true or $false.

.PARAMETER excludedProjectBoardIds
    Excluded project board ids. An array of integers.

.PARAMETER scheduleDefaultLocation
    Schedule default location reference, for example @{ id = 1 }.

.PARAMETER scheduleDefaultDepartment
    Schedule default department reference, for example @{ id = 1 }.

.PARAMETER scheduleCapacity
    Schedule capacity. A number.

.PARAMETER serviceLocation
    Service location reference, for example @{ id = 1 }.

.PARAMETER restrictScheduleFlag
    Restrict schedule flag. $true or $false.

.PARAMETER hideMemberInDispatchPortalFlag
    Hide member in dispatch portal flag. $true or $false.

.PARAMETER calendar
    Calendar reference, for example @{ id = 1 }.

.PARAMETER salesDefaultLocation
    Sales default location reference, for example @{ id = 1 }.

.PARAMETER restrictDefaultSalesTerritoryFlag
    Restrict default sales territory flag. $true or $false.

.PARAMETER warehouse
    Warehouse reference, for example @{ id = 1 }.

.PARAMETER warehouseBin
    Warehouse bin reference, for example @{ id = 1 }.

.PARAMETER restrictDefaultWarehouseFlag
    Restrict default warehouse flag. $true or $false.

.PARAMETER restrictDefaultWarehouseBinFlag
    Restrict default warehouse bin flag. $true or $false.

.PARAMETER mapiName
    MAPI name.

.PARAMETER calendarSyncIntegrationFlag
    Calendar sync integration flag. $true or $false.

.PARAMETER enableLdapAuthenticationFlag
    Enable LDAP authentication flag. $true or $false.

.PARAMETER ldapConfiguration
    LDAP configuration reference, for example @{ id = 1 }.

.PARAMETER ldapUserName
    LDAP user name. Max length 50.

.PARAMETER companyActivityTabFormat
    Company activity tab format. One of: SummaryList, DetailList.

.PARAMETER invoiceTimeTabFormat
    Invoice time tab format. One of: SummaryList, DetailList.

.PARAMETER invoiceScreenDefaultTabFormat
    Invoice screen default tab format. One of: ShowInvoicingTab, ShowAgreementInvoicingTab.

.PARAMETER invoicingDisplayOptions
    Invoicing display options. One of: RemainOnInvoicingScreen, ShowRecentInvoices.

.PARAMETER agreementInvoicingDisplayOptions
    Agreement invoicing display options. One of: RemainOnInvoicingScreen, ShowRecentInvoices.

.PARAMETER authenticationServiceType
    Authentication service type. One of: AuthAnvil, GoogleAuthenticator, Email.

.PARAMETER timebasedOneTimePasswordActivated
    Timebased one time password activated. $true or $false.

.PARAMETER ssoSettings
    SSO settings reference, for example @{ id = 1 }.

.PARAMETER autoStartStopwatch
    Auto start stopwatch. $true or $false.

.PARAMETER autoPopupQuickNotesWithStopwatch
    Auto popup quick notes with stopwatch. $true or $false.

.PARAMETER signature
    Signature.

.PARAMETER globalSearchDefaultTicketFilter
    Global search default ticket filter. One of: OpenRecords, ClosedRecords, AllRecords.

.PARAMETER globalSearchDefaultSort
    Global search default sort. One of: None, LastUpdatedDesc, LastUpdatedAsc, CreatedDesc, CreatedAsc.

.PARAMETER phoneSource
    Phone source.

.PARAMETER phoneIntegrationType
    Phone integration type. One of: TAPI, SKYPE, TEL, CALLTO, NONE.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER copyPodLayouts
    Copy pod layouts. $true or $false.

.PARAMETER copySharedDefaultViews
    Copy shared default views. $true or $false.

.PARAMETER copyColumnLayoutsAndFilters
    Copy column layouts and filters. $true or $false.

.PARAMETER fromMemberRecId
    From member rec id. An integer.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    $Member = @{
        identifier   = 'jdoe'
        firstName    = 'John'
        lastName     = 'Doe'
        licenseClass = 'F'
        hireDate     = ConvertTo-CWMTime (Get-Date) -Raw
        defaultEmail = 'Office'
        defaultPhone = 'Office'
        officeEmail  = 'jdoe@example.com'
        securityRole = @{ id = 63 }
    }
    New-CWMMember @Member

    Creates a full member with the properties the API requires.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMMember {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'Required for API')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'Required for API')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [ValidateLength(1,15)]
        [Parameter(Mandatory=$true)]
        [string]$identifier,
        [ValidateLength(1,60)]
        [string]$password,
        [ValidateLength(1,30)]
        [Parameter(Mandatory=$true)]
        [string]$firstName,
        [ValidateLength(1,1)]
        [string]$middleInitial,
        [ValidateLength(1,30)]
        [Parameter(Mandatory=$true)]
        [string]$lastName,
        [ValidateLength(1,50)]
        [string]$title,
        [hashtable]$reportCard,
        [Parameter(Mandatory=$true)]
        [ValidateSet('F','A','C','X')]
        [string]$licenseClass,
        [boolean]$disableOnlineFlag,
        [boolean]$enableMobileFlag,
        [hashtable]$type,
        [ValidateLength(1,10)]
        [string]$employeeIdentifer,
        [string]$vendorNumber,
        [string]$notes,
        [hashtable]$timeZone,
        [hashtable]$country,
        [int[]]$serviceBoardTeamIds,
        [boolean]$enableMobileGpsFlag,
        [string]$inactiveDate,
        [boolean]$inactiveFlag,
        [string]$lastLogin,
        [hashtable]$photo,
        [boolean]$partnerPortalFlag,
        [string]$clientId,
        [string]$stsUserAdminUrl,
        [string]$token,
        [boolean]$toastNotificationFlag,
        [int[]]$memberPersonas,
        [hashtable]$office365,
        [ValidateLength(1,250)]
        [string]$officeEmail,
        [ValidateLength(1,15)]
        [string]$officePhone,
        [ValidateLength(1,10)]
        [string]$officeExtension,
        [ValidateLength(1,250)]
        [string]$mobileEmail,
        [ValidateLength(1,15)]
        [string]$mobilePhone,
        [ValidateLength(1,10)]
        [string]$mobileExtension,
        [ValidateLength(1,250)]
        [string]$homeEmail,
        [ValidateLength(1,15)]
        [string]$homePhone,
        [ValidateLength(1,10)]
        [string]$homeExtension,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Office','Mobile','Home')]
        [string]$defaultEmail,
        [ValidateLength(1,250)]
        [string]$primaryEmail,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Office','Mobile','Home')]
        [string]$defaultPhone,
        [hashtable]$securityRole,
        [boolean]$adminFlag,
        [hashtable]$structureLevel,
        [hashtable]$securityLocation,
        [hashtable]$defaultLocation,
        [hashtable]$defaultDepartment,
        [hashtable]$reportsTo,
        [boolean]$restrictLocationFlag,
        [boolean]$restrictDepartmentFlag,
        [hashtable]$workRole,
        [hashtable]$workType,
        [hashtable]$timeApprover,
        [hashtable]$expenseApprover,
        [double]$billableForecast,
        [double]$dailyCapacity,
        [double]$hourlyCost,
        [double]$hourlyRate,
        [boolean]$includeInUtilizationReportingFlag,
        [boolean]$requireExpenseEntryFlag,
        [boolean]$requireTimeSheetEntryFlag,
        [boolean]$requireStartAndEndTimeOnTimeEntryFlag,
        [boolean]$allowInCellEntryOnTimeSheet,
        [boolean]$enterTimeAgainstCompanyFlag,
        [boolean]$allowExpensesEnteredAgainstCompaniesFlag,
        [boolean]$timeReminderEmailFlag,
        [int]$daysTolerance,
        [double]$minimumHours,
        [string]$timeSheetStartDate,
        [Parameter(Mandatory=$true)]
        [string]$hireDate,
        [hashtable]$serviceDefaultLocation,
        [hashtable]$serviceDefaultDepartment,
        [hashtable]$serviceDefaultBoard,
        [boolean]$restrictServiceDefaultLocationFlag,
        [boolean]$restrictServiceDefaultDepartmentFlag,
        [int[]]$excludedServiceBoardIds,
        [hashtable]$projectDefaultLocation,
        [hashtable]$projectDefaultDepartment,
        [hashtable]$projectDefaultBoard,
        [boolean]$restrictProjectDefaultLocationFlag,
        [boolean]$restrictProjectDefaultDepartmentFlag,
        [int[]]$excludedProjectBoardIds,
        [hashtable]$scheduleDefaultLocation,
        [hashtable]$scheduleDefaultDepartment,
        [double]$scheduleCapacity,
        [hashtable]$serviceLocation,
        [boolean]$restrictScheduleFlag,
        [boolean]$hideMemberInDispatchPortalFlag,
        [hashtable]$calendar,
        [hashtable]$salesDefaultLocation,
        [boolean]$restrictDefaultSalesTerritoryFlag,
        [hashtable]$warehouse,
        [hashtable]$warehouseBin,
        [boolean]$restrictDefaultWarehouseFlag,
        [boolean]$restrictDefaultWarehouseBinFlag,
        [string]$mapiName,
        [boolean]$calendarSyncIntegrationFlag,
        [boolean]$enableLdapAuthenticationFlag,
        [hashtable]$ldapConfiguration,
        [ValidateLength(1,50)]
        [string]$ldapUserName,
        [Parameter(Mandatory=$true)]
        [ValidateSet('SummaryList','DetailList')]
        [string]$companyActivityTabFormat,
        [Parameter(Mandatory=$true)]
        [ValidateSet('SummaryList','DetailList')]
        [string]$invoiceTimeTabFormat,
        [Parameter(Mandatory=$true)]
        [ValidateSet('ShowInvoicingTab','ShowAgreementInvoicingTab')]
        [string]$invoiceScreenDefaultTabFormat,
        [Parameter(Mandatory=$true)]
        [ValidateSet('RemainOnInvoicingScreen','ShowRecentInvoices')]
        [string]$invoicingDisplayOptions,
        [Parameter(Mandatory=$true)]
        [ValidateSet('RemainOnInvoicingScreen','ShowRecentInvoices')]
        [string]$agreementInvoicingDisplayOptions,
        [ValidateSet('AuthAnvil','GoogleAuthenticator','Email')]
        [string]$authenticationServiceType,
        [boolean]$timebasedOneTimePasswordActivated,
        [hashtable]$ssoSettings,
        [boolean]$autoStartStopwatch,
        [boolean]$autoPopupQuickNotesWithStopwatch,
        [string]$signature,
        [ValidateSet('OpenRecords','ClosedRecords','AllRecords')]
        [string]$globalSearchDefaultTicketFilter,
        [ValidateSet('None','LastUpdatedDesc','LastUpdatedAsc','CreatedDesc','CreatedAsc')]
        [string]$globalSearchDefaultSort,
        [string]$phoneSource,
        [ValidateSet('TAPI','SKYPE','TEL','CALLTO','NONE')]
        [string]$phoneIntegrationType,
        [hashtable]$_info,
        [boolean]$copyPodLayouts,
        [boolean]$copySharedDefaultViews,
        [boolean]$copyColumnLayoutsAndFilters,
        [int]$fromMemberRecId,
        [hashtable[]]$customFields
    )

    $Endpoint = '/system/members'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
