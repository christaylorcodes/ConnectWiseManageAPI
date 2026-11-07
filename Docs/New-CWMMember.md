---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMMember

## SYNOPSIS
Creates a member.

## SYNTAX

```
New-CWMMember [[-id] <Int32>] [-identifier] <String> [[-password] <String>] [-firstName] <String>
 [[-middleInitial] <String>] [-lastName] <String> [[-title] <String>] [[-reportCard] <Hashtable>]
 [-licenseClass] <String> [[-disableOnlineFlag] <Boolean>] [[-enableMobileFlag] <Boolean>]
 [[-type] <Hashtable>] [[-employeeIdentifer] <String>] [[-vendorNumber] <String>] [[-notes] <String>]
 [[-timeZone] <Hashtable>] [[-country] <Hashtable>] [[-serviceBoardTeamIds] <Int32[]>]
 [[-enableMobileGpsFlag] <Boolean>] [[-inactiveDate] <String>] [[-inactiveFlag] <Boolean>]
 [[-lastLogin] <String>] [[-photo] <Hashtable>] [[-partnerPortalFlag] <Boolean>] [[-clientId] <String>]
 [[-stsUserAdminUrl] <String>] [[-token] <String>] [[-toastNotificationFlag] <Boolean>]
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
 [-agreementInvoicingDisplayOptions] <String> [[-authenticationServiceType] <String>]
 [[-timebasedOneTimePasswordActivated] <Boolean>] [[-ssoSettings] <Hashtable>]
 [[-autoStartStopwatch] <Boolean>] [[-autoPopupQuickNotesWithStopwatch] <Boolean>] [[-signature] <String>]
 [[-globalSearchDefaultTicketFilter] <String>] [[-globalSearchDefaultSort] <String>] [[-phoneSource] <String>]
 [[-phoneIntegrationType] <String>] [[-_info] <Hashtable>] [[-copyPodLayouts] <Boolean>]
 [[-copySharedDefaultViews] <Boolean>] [[-copyColumnLayoutsAndFilters] <Boolean>] [[-fromMemberRecId] <Int32>]
 [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a member in ConnectWise Manage.
Calls POST /system/members; only the parameters you pass are
sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
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
```

Creates a full member with the properties the API requires.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -identifier
Identifier.
Max length 15.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -password
Password.
Conditionally required.
API Member will get random password generated Max length 60.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -firstName
First name.
Max length 30.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -middleInitial
Middle initial.
Max length 1.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastName
Last name.
Max length 30.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
Title.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reportCard
Report card reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -licenseClass
License class.
One of: A, C, F, X.
F = Full Member, A = API Member, C = StreamlineIT Member, X =
Subcontractor Member.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableOnlineFlag
Disable online flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableMobileFlag
Enable mobile flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeIdentifer
Employee identifer.
Max length 10.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendorNumber
Vendor number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Notes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeZone
Time zone reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -country
Country reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceBoardTeamIds
Service board team ids.
An array of integers.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableMobileGpsFlag
Enable mobile gps flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveDate
Inactive date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
Inactive flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -lastLogin
Last login.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -photo
Photo reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -partnerPortalFlag
Partner portal flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -clientId
Client id.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -stsUserAdminUrl
Sts user admin URL.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -token
Token.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -toastNotificationFlag
Toast notification flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -memberPersonas
Member personas.
An array of integers.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -office365
Office 365 reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officeEmail
Office email.
Max length 250.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officePhone
Office phone.
Max length 15.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -officeExtension
Office extension.
Max length 10.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileEmail
Mobile email.
Max length 250.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobilePhone
Mobile phone.
Max length 15.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileExtension
Mobile extension.
Max length 10.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homeEmail
Home email.
Max length 250.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homePhone
Home phone.
Max length 15.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -homeExtension
Home extension.
Max length 10.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultEmail
Default email.
One of: Office, Mobile, Home.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -primaryEmail
Primary email.
Max length 250.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultPhone
Default phone.
One of: Office, Mobile, Home.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -securityRole
Security role reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adminFlag
Admin flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -structureLevel
Structure level reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -securityLocation
Security location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultLocation
Default location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultDepartment
Default department reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reportsTo
Reports to reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictLocationFlag
Restrict location flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDepartmentFlag
Restrict department flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
Work role reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
Work type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeApprover
Time approver reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expenseApprover
Expense approver reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableForecast
Billable forecast.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -dailyCapacity
Daily capacity.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyCost
Hourly cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
Hourly rate.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -includeInUtilizationReportingFlag
Include in utilization reporting flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireExpenseEntryFlag
Require expense entry flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireTimeSheetEntryFlag
Require time sheet entry flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -requireStartAndEndTimeOnTimeEntryFlag
Require start and end time on time entry flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowInCellEntryOnTimeSheet
Allow in cell entry on time sheet.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -enterTimeAgainstCompanyFlag
Enter time against company flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowExpensesEnteredAgainstCompaniesFlag
Allow expenses entered against companies flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeReminderEmailFlag
Time reminder email flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -daysTolerance
Days tolerance.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -minimumHours
Minimum hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeSheetStartDate
Time sheet start date.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hireDate
Hire date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.
Required by
the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultLocation
Service default location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultDepartment
Service default department reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDefaultBoard
Service default board reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictServiceDefaultLocationFlag
Restrict service default location flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictServiceDefaultDepartmentFlag
Restrict service default department flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -excludedServiceBoardIds
Excluded service board ids.
An array of integers.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultLocation
Project default location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 78
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultDepartment
Project default department reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 79
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectDefaultBoard
Project default board reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 80
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictProjectDefaultLocationFlag
Restrict project default location flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 81
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictProjectDefaultDepartmentFlag
Restrict project default department flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 82
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -excludedProjectBoardIds
Excluded project board ids.
An array of integers.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 83
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleDefaultLocation
Schedule default location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 84
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleDefaultDepartment
Schedule default department reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 85
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleCapacity
Schedule capacity.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 86
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceLocation
Service location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 87
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictScheduleFlag
Restrict schedule flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 88
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -hideMemberInDispatchPortalFlag
Hide member in dispatch portal flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 89
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendar
Calendar reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 90
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesDefaultLocation
Sales default location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 91
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultSalesTerritoryFlag
Restrict default sales territory flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 92
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
Warehouse reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 93
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseBin
Warehouse bin reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 94
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultWarehouseFlag
Restrict default warehouse flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 95
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDefaultWarehouseBinFlag
Restrict default warehouse bin flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 96
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -mapiName
MAPI name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 97
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -calendarSyncIntegrationFlag
Calendar sync integration flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 98
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -enableLdapAuthenticationFlag
Enable LDAP authentication flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 99
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ldapConfiguration
LDAP configuration reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 100
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ldapUserName
LDAP user name.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 101
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyActivityTabFormat
Company activity tab format.
One of: SummaryList, DetailList.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 102
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTimeTabFormat
Invoice time tab format.
One of: SummaryList, DetailList.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 103
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceScreenDefaultTabFormat
Invoice screen default tab format.
One of: ShowInvoicingTab, ShowAgreementInvoicingTab.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 104
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicingDisplayOptions
Invoicing display options.
One of: RemainOnInvoicingScreen, ShowRecentInvoices.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 105
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementInvoicingDisplayOptions
Agreement invoicing display options.
One of: RemainOnInvoicingScreen, ShowRecentInvoices.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 106
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -authenticationServiceType
Authentication service type.
One of: AuthAnvil, GoogleAuthenticator, Email.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 107
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timebasedOneTimePasswordActivated
Timebased one time password activated.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 108
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ssoSettings
SSO settings reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 109
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoStartStopwatch
Auto start stopwatch.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 110
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoPopupQuickNotesWithStopwatch
Auto popup quick notes with stopwatch.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 111
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -signature
Signature.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 112
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -globalSearchDefaultTicketFilter
Global search default ticket filter.
One of: OpenRecords, ClosedRecords, AllRecords.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 113
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -globalSearchDefaultSort
Global search default sort.
One of: None, LastUpdatedDesc, LastUpdatedAsc, CreatedDesc, CreatedAsc.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 114
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneSource
Phone source.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 115
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phoneIntegrationType
Phone integration type.
One of: TAPI, SKYPE, TEL, CALLTO, NONE.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 116
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 117
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyPodLayouts
Copy pod layouts.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 118
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -copySharedDefaultViews
Copy shared default views.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 119
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyColumnLayoutsAndFilters
Copy column layouts and filters.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 120
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -fromMemberRecId
From member rec id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 121
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 122
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

