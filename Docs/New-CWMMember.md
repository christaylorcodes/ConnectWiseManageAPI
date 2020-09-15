---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMMember

## SYNOPSIS
This will create a new Manage user.

## SYNTAX

```
New-CWMMember [[-id] <Int32>] [-identifier] <String> [[-password] <String>] [-firstName] <String>
 [[-middleInitial] <String>] [-lastName] <String> [[-title] <String>] [[-reportCard] <Hashtable>]
 [-licenseClass] <String> [[-disableOnlineFlag] <Boolean>] [[-enableMobileFlag] <Boolean>]
 [[-type] <Hashtable>] [[-employeeIdentifer] <String>] [[-vendorNumber] <String>] [[-notes] <String>]
 [[-timeZone] <Hashtable>] [[-TimeZoneSetupReference] <Hashtable>] [[-country] <Hashtable>]
 [[-serviceBoardTeamIds] <Int32[]>] [[-enableMobileGpsFlag] <Boolean>] [[-inactiveDate] <String>]
 [[-inactiveFlag] <Boolean>] [[-lastLogin] <String>] [[-photo] <Hashtable>] [[-partnerPortalFlag] <Boolean>]
 [[-clientId] <String>] [[-stsUserAdminUrl] <String>] [[-token] <String>] [[-toastNotificationFlag] <Boolean>]
 [[-memberPersonas] <Int32[]>] [[-office365] <Hashtable>] [[-officeEmail] <String>] [[-officePhone] <String>]
 [[-officeExtension] <String>] [[-mobileEmail] <String>] [[-mobilePhone] <String>]
 [[-mobileExtension] <String>] [[-homeEmail] <String>] [[-homePhone] <String>] [[-homeExtension] <String>]
 [-defaultEmail] <String> [[-primaryEmail] <String>] [-defaultPhone] <String> [[-securityRole] <Hashtable>]
 [[-adminFlag] <Boolean>] [[-structureLevel] <Hashtable>] [[-securityLocation] <Hashtable>]
 [[-defaultLocation] <Hashtable>] [[-defaultDepartment] <Hashtable>] [[-reportsTo] <Hashtable>]
 [[-restrictLocationFlag] <Boolean>] [[-restrictDepartmentFlag] <Boolean>] [[-workRole] <Hashtable>]
 [[-workType] <Hashtable>] [[-timeApprover] <Hashtable>] [[-expenseApprover] <Hashtable>]
 [[-billableForecast] <Double>] [[-dailyCapacity] <Double>] [[-hourlyCost] <Double>] [[-hourlyRate] <Double>]
 [[-includeInUtilizationReportingFlag] <Boolean>] [[-requireExpenseEntryFlag] <Boolean>]
 [[-requireTimeSheetEntryFlag] <Boolean>] [[-requireStartAndEndTimeOnTimeEntryFlag] <Boolean>]
 [[-allowInCellEntryOnTimeSheet] <Boolean>] [[-enterTimeAgainstCompanyFlag] <Boolean>]
 [[-allowExpensesEnteredAgainstCompaniesFlag] <Boolean>] [[-timeReminderEmailFlag] <Boolean>]
 [[-daysTolerance] <Int32>] [[-minimumHours] <Double>] [[-timeSheetStartDate] <String>] [-hireDate] <String>
 [[-serviceDefaultLocation] <Hashtable>] [[-serviceDefaultDepartment] <Hashtable>]
 [[-serviceDefaultBoard] <Hashtable>] [[-restrictServiceDefaultLocationFlag] <Boolean>]
 [[-restrictServiceDefaultDepartmentFlag] <Boolean>] [[-excludedServiceBoardIds] <Int32[]>]
 [[-projectDefaultLocation] <Hashtable>] [[-projectDefaultDepartment] <Hashtable>]
 [[-projectDefaultBoard] <Hashtable>] [[-restrictProjectDefaultLocationFlag] <Boolean>]
 [[-restrictProjectDefaultDepartmentFlag] <Boolean>] [[-excludedProjectBoardIds] <Int32[]>]
 [[-scheduleDefaultLocation] <Hashtable>] [[-scheduleDefaultDepartment] <Hashtable>]
 [[-scheduleCapacity] <Double>] [[-serviceLocation] <Hashtable>] [[-restrictScheduleFlag] <Boolean>]
 [[-hideMemberInDispatchPortalFlag] <Boolean>] [[-calendar] <Hashtable>] [[-salesDefaultLocation] <Hashtable>]
 [[-restrictDefaultSalesTerritoryFlag] <Boolean>] [[-warehouse] <Hashtable>] [[-warehouseBin] <Hashtable>]
 [[-restrictDefaultWarehouseFlag] <Boolean>] [[-restrictDefaultWarehouseBinFlag] <Boolean>]
 [[-mapiName] <String>] [[-calendarSyncIntegrationFlag] <Boolean>] [[-enableLdapAuthenticationFlag] <Boolean>]
 [[-ldapConfiguration] <Hashtable>] [[-ldapUserName] <String>] [-companyActivityTabFormat] <String>
 [-invoiceTimeTabFormat] <String> [-invoiceScreenDefaultTabFormat] <String> [-invoicingDisplayOptions] <String>
 [-agreementInvoicingDisplayOptions] <String> [[-remotePackage] <String>] [[-remotePackagePlatform] <String>]
 [[-remotePackageUserName] <String>] [[-remotePackagePassword] <SecureString>]
 [[-remotePackageAccount] <String>] [[-authenticationServiceType] <String>]
 [[-timebasedOneTimePasswordActivated] <Boolean>] [[-ssoSettings] <Hashtable>]
 [[-autoStartStopwatch] <Boolean>] [[-autoPopupQuickNotesWithStopwatch] <Boolean>] [[-signature] <String>]
 [[-globalSearchDefaultTicketFilter] <String>] [[-globalSearchDefaultSort] <String>] [[-phoneSource] <String>]
 [[-phoneIntegrationType] <String>] [[-_info] <Hashtable>] [[-copyPodLayouts] <Boolean>]
 [[-copySharedDefaultViews] <Boolean>] [[-copyColumnLayoutsAndFilters] <Boolean>] [[-fromMemberRecId] <Int32>]
 [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This will create a new Manage user with the given properties.

## EXAMPLES

### Example 1
```powershell
$NewMember = @{
    identifier = 'ctaylor'
    firstName = 'Chris'
    lastName = 'Taylor'
    password = 'ChangeMe1!'
    licenseClass = 'F'
    agreementInvoicingDisplayOptions = 'RemainOnInvoicingScreen'
    companyActivityTabFormat = 'SummaryList'
    defaultEmail = 'Office'
    defaultPhone = 'Office'
    invoiceScreenDefaultTabFormat = 'ShowInvoicingTab'
    invoiceTimeTabFormat = 'SummaryList'
    invoicingDisplayOptions = 'RemainOnInvoicingScreen'
    hireDate = $(ConvertTo-CWMTime (Get-Date).AddDays(-1) -Raw)
    # additional required fields
    timeZone = @{id=1}
    securityRole = @{id=63}
    structureLevel = @{id=1}
    securityLocation = @{id=38}
    defaultLocation = @{id=2}
    defaultDepartment = @{id=10}
    workRole = @{id=21}
    timeApprover = @{id=186}
    expenseApprover = @{id=186}
    salesDefaultLocation = @{id=38}
    officeEmail = 'dont@bug.me'
    officePhone = '19001234567'
}
New-CWMMember @NewMember -Verbose
```

Will create a new fully license user 'ctaylor'

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeZoneSetupReference
{{ Fill TimeZoneSetupReference Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 122
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adminFlag
{{ Fill adminFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementInvoicingDisplayOptions
{{ Fill agreementInvoicingDisplayOptions Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: RemainOnInvoicingScreen, ShowRecentInvoices

Required: True
Position: 106
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowExpensesEnteredAgainstCompaniesFlag
{{ Fill allowExpensesEnteredAgainstCompaniesFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowInCellEntryOnTimeSheet
{{ Fill allowInCellEntryOnTimeSheet Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -authenticationServiceType
{{ Fill authenticationServiceType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: AuthAnvil, GoogleAuthenticator

Required: False
Position: 112
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoPopupQuickNotesWithStopwatch
{{ Fill autoPopupQuickNotesWithStopwatch Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 116
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoStartStopwatch
{{ Fill autoStartStopwatch Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 115
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableForecast
{{ Fill billableForecast Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendar
{{ Fill calendar Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 90
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendarSyncIntegrationFlag
{{ Fill calendarSyncIntegrationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 98
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientId
{{ Fill clientId Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyActivityTabFormat
{{ Fill companyActivityTabFormat Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: SummaryList, DetailList

Required: True
Position: 102
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyColumnLayoutsAndFilters
{{ Fill copyColumnLayoutsAndFilters Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 125
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyPodLayouts
{{ Fill copyPodLayouts Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 123
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copySharedDefaultViews
{{ Fill copySharedDefaultViews Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 124
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
{{ Fill country Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 127
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dailyCapacity
{{ Fill dailyCapacity Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -daysTolerance
{{ Fill daysTolerance Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultDepartment
{{ Fill defaultDepartment Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultEmail
{{ Fill defaultEmail Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Office, Mobile, Home

Required: True
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultLocation
{{ Fill defaultLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultPhone
{{ Fill defaultPhone Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Office, Mobile, Home

Required: True
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableOnlineFlag
{{ Fill disableOnlineFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeIdentifer
{{ Fill employeeIdentifer Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableLdapAuthenticationFlag
{{ Fill enableLdapAuthenticationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 99
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableMobileFlag
{{ Fill enableMobileFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableMobileGpsFlag
{{ Fill enableMobileGpsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enterTimeAgainstCompanyFlag
{{ Fill enterTimeAgainstCompanyFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -excludedProjectBoardIds
{{ Fill excludedProjectBoardIds Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 83
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -excludedServiceBoardIds
{{ Fill excludedServiceBoardIds Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expenseApprover
{{ Fill expenseApprover Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -firstName
{{ Fill firstName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fromMemberRecId
{{ Fill fromMemberRecId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 126
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -globalSearchDefaultSort
{{ Fill globalSearchDefaultSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: None, LastUpdatedDesc, LastUpdatedAsc, CreatedDesc, CreatedAsc

Required: False
Position: 119
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -globalSearchDefaultTicketFilter
{{ Fill globalSearchDefaultTicketFilter Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: OpenRecords, ClosedRecords, AllRecords

Required: False
Position: 118
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hideMemberInDispatchPortalFlag
{{ Fill hideMemberInDispatchPortalFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 89
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hireDate
{{ Fill hireDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homeEmail
{{ Fill homeEmail Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homeExtension
{{ Fill homeExtension Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homePhone
{{ Fill homePhone Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyCost
{{ Fill hourlyCost Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -identifier
{{ Fill identifier Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveDate
{{ Fill inactiveDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
{{ Fill inactiveFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeInUtilizationReportingFlag
{{ Fill includeInUtilizationReportingFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceScreenDefaultTabFormat
{{ Fill invoiceScreenDefaultTabFormat Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ShowInvoicingTab, ShowAgreementInvoicingTab

Required: True
Position: 104
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTimeTabFormat
{{ Fill invoiceTimeTabFormat Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: SummaryList, DetailList

Required: True
Position: 103
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicingDisplayOptions
{{ Fill invoicingDisplayOptions Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: RemainOnInvoicingScreen, ShowRecentInvoices

Required: True
Position: 105
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastLogin
{{ Fill lastLogin Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastName
{{ Fill lastName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ldapConfiguration
{{ Fill ldapConfiguration Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 100
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ldapUserName
{{ Fill ldapUserName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 101
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -licenseClass
F = Full Member, A = API Member, C = StreamlineIT Member, X = Subcontractor Member

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: F, A, C, X

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mapiName
{{ Fill mapiName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 97
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -memberPersonas
{{ Fill memberPersonas Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -middleInitial
{{ Fill middleInitial Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -minimumHours
{{ Fill minimumHours Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileEmail
{{ Fill mobileEmail Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileExtension
{{ Fill mobileExtension Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobilePhone
{{ Fill mobilePhone Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
{{ Fill notes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -office365
{{ Fill office365 Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officeEmail
{{ Fill officeEmail Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officeExtension
{{ Fill officeExtension Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officePhone
{{ Fill officePhone Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -partnerPortalFlag
{{ Fill partnerPortalFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
{{ Fill password Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneIntegrationType
{{ Fill phoneIntegrationType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: TAPI, SKYPE, NONE

Required: False
Position: 121
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneSource
{{ Fill phoneSource Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 120
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -photo
{{ Fill photo Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -primaryEmail
{{ Fill primaryEmail Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultBoard
{{ Fill projectDefaultBoard Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 80
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultDepartment
{{ Fill projectDefaultDepartment Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 79
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultLocation
{{ Fill projectDefaultLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 78
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remotePackage
{{ Fill remotePackage Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: LogMeIn, NTR

Required: False
Position: 107
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remotePackageAccount
{{ Fill remotePackageAccount Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 111
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remotePackagePassword
{{ Fill remotePackagePassword Description }}

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 110
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remotePackagePlatform
{{ Fill remotePackagePlatform Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 108
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -remotePackageUserName
{{ Fill remotePackageUserName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 109
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reportCard
{{ Fill reportCard Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reportsTo
{{ Fill reportsTo Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireExpenseEntryFlag
{{ Fill requireExpenseEntryFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireStartAndEndTimeOnTimeEntryFlag
{{ Fill requireStartAndEndTimeOnTimeEntryFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireTimeSheetEntryFlag
{{ Fill requireTimeSheetEntryFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultSalesTerritoryFlag
{{ Fill restrictDefaultSalesTerritoryFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 92
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultWarehouseBinFlag
{{ Fill restrictDefaultWarehouseBinFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 96
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultWarehouseFlag
{{ Fill restrictDefaultWarehouseFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 95
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDepartmentFlag
{{ Fill restrictDepartmentFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictLocationFlag
{{ Fill restrictLocationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictProjectDefaultDepartmentFlag
{{ Fill restrictProjectDefaultDepartmentFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 82
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictProjectDefaultLocationFlag
{{ Fill restrictProjectDefaultLocationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 81
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictScheduleFlag
{{ Fill restrictScheduleFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 88
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictServiceDefaultDepartmentFlag
{{ Fill restrictServiceDefaultDepartmentFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictServiceDefaultLocationFlag
{{ Fill restrictServiceDefaultLocationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesDefaultLocation
{{ Fill salesDefaultLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 91
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleCapacity
{{ Fill scheduleCapacity Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 86
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleDefaultDepartment
{{ Fill scheduleDefaultDepartment Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 85
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleDefaultLocation
{{ Fill scheduleDefaultLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 84
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -securityLocation
{{ Fill securityLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -securityRole
{{ Fill securityRole Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceBoardTeamIds
{{ Fill serviceBoardTeamIds Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultBoard
{{ Fill serviceDefaultBoard Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultDepartment
{{ Fill serviceDefaultDepartment Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultLocation
{{ Fill serviceDefaultLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceLocation
{{ Fill serviceLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 87
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -signature
{{ Fill signature Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 117
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ssoSettings
{{ Fill ssoSettings Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 114
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -structureLevel
{{ Fill structureLevel Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -stsUserAdminUrl
{{ Fill stsUserAdminUrl Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeApprover
{{ Fill timeApprover Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeReminderEmailFlag
{{ Fill timeReminderEmailFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeSheetStartDate
{{ Fill timeSheetStartDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeZone
{{ Fill timeZone Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timebasedOneTimePasswordActivated
{{ Fill timebasedOneTimePasswordActivated Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 113
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
{{ Fill title Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -toastNotificationFlag
{{ Fill toastNotificationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -token
{{ Fill token Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{ Fill type Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendorNumber
{{ Fill vendorNumber Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
{{ Fill warehouse Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 93
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseBin
{{ Fill warehouseBin Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 94
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
{{ Fill workRole Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
{{ Fill workType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE#/Members/postSystemMembers](https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=UPDATE#/Members/postSystemMembers)