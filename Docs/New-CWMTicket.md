---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTicket

## SYNOPSIS
This function will create a new ticket.

## SYNTAX

### 2020.1 (Default)
```
New-CWMTicket [-Version <String>] [-VersionAutomatic] [[-id] <Int32>] [-summary] <String>
 [[-recordType] <String>] [[-board] <Hashtable>] [[-status] <Hashtable>] [-company] <Hashtable>
 [[-site] <Hashtable>] [[-siteName] <String>] [[-addressLine1] <String>] [[-addressLine2] <String>]
 [[-city] <String>] [[-stateIdentifier] <String>] [[-zip] <String>] [[-country] <Hashtable>]
 [[-contact] <Hashtable>] [[-contactName] <String>] [[-contactPhoneNumber] <String>]
 [[-contactPhoneExtension] <String>] [[-contactEmailAddress] <String>] [[-type] <Hashtable>]
 [[-subType] <Hashtable>] [[-item] <Hashtable>] [[-team] <Hashtable>] [[-owner] <Hashtable>]
 [[-priority] <Hashtable>] [[-serviceLocation] <Hashtable>] [[-source] <Hashtable>] [[-requiredDate] <String>]
 [[-budgetHours] <Decimal>] [[-opportunity] <Hashtable>] [[-agreement] <Hashtable>] [[-severity] <String>]
 [[-impact] <String>] [[-externalXRef] <String>] [[-poNumber] <String>] [[-knowledgeBaseCategoryId] <Int32>]
 [[-knowledgeBaseSubCategoryId] <Int32>] [[-allowAllClientsPortalView] <Boolean>]
 [[-customerUpdatedFlag] <Boolean>] [[-automaticEmailContactFlag] <Boolean>]
 [[-automaticEmailResourceFlag] <Boolean>] [[-automaticEmailCcFlag] <Boolean>] [[-automaticEmailCc] <String>]
 [[-initialDescription] <String>] [[-initialInternalAnalysis] <String>] [[-initialResolution] <String>]
 [[-contactEmailLookup] <String>] [[-processNotifications] <Boolean>] [[-skipCallback] <Boolean>]
 [[-closedDate] <String>] [[-closedBy] <String>] [[-closedFlag] <Boolean>] [[-dateEntered] <String>]
 [[-enteredBy] <String>] [[-actualHours] <Decimal>] [[-approved] <Boolean>] [-estimatedExpenseCost <Decimal>]
 [-estimatedExpenseRevenue <Decimal>] [-estimatedProductCost <Decimal>] [-estimatedProductRevenue <Decimal>]
 [-estimatedTimeCost <Decimal>] [-estimatedTimeRevenue <Decimal>] [-billingMethod <String>]
 [-billingAmount <Decimal>] [-hourlyRate <Decimal>] [[-subBillingMethod] <String>]
 [[-subBillingAmount] <Decimal>] [[-subDateAccepted] <String>] [[-dateResolved] <String>]
 [[-dateResplan] <String>] [[-dateResponded] <String>] [[-resolveMinutes] <Int32>] [[-resPlanMinutes] <Int32>]
 [[-respondMinutes] <Int32>] [[-isInSla] <Boolean>] [[-knowledgeBaseLinkId] <Int32>] [[-resources] <String>]
 [[-parentTicketId] <Int32>] [[-hasChildTicket] <Boolean>] [-hasMergedChildTicketFlag <Boolean>]
 [[-knowledgeBaseLinkType] <String>] [[-billTime] <String>] [[-billExpenses] <String>]
 [[-billProducts] <String>] [[-predecessorType] <String>] [[-predecessorId] <Int32>]
 [[-predecessorClosedFlag] <Boolean>] [[-lagDays] <Int32>] [[-lagNonworkingDaysFlag] <Boolean>]
 [[-estimatedStartDate] <String>] [[-duration] <Int32>] [-location <Hashtable>] [-department <Hashtable>]
 [[-mobileGuid] <Guid>] [[-sla] <Hashtable>] [[-currency] <Hashtable>] [-mergedParentTicket <Hashtable>]
 [-integratorTags <String>] [[-_info] <Hashtable>] [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### 2019.1
```
New-CWMTicket [-Version <String>] [-VersionAutomatic] [[-id] <Int32>] [-summary] <String>
 [[-recordType] <String>] [[-board] <Hashtable>] [[-status] <Hashtable>] [[-project] <Hashtable>]
 [[-phase] <Hashtable>] [[-wbsCode] <String>] [-company] <Hashtable> [[-site] <Hashtable>]
 [[-siteName] <String>] [[-addressLine1] <String>] [[-addressLine2] <String>] [[-city] <String>]
 [[-stateIdentifier] <String>] [[-zip] <String>] [[-country] <Hashtable>] [[-contact] <Hashtable>]
 [[-contactName] <String>] [[-contactPhoneNumber] <String>] [[-contactPhoneExtension] <String>]
 [[-contactEmailAddress] <String>] [[-type] <Hashtable>] [[-subType] <Hashtable>] [[-item] <Hashtable>]
 [[-team] <Hashtable>] [[-owner] <Hashtable>] [[-priority] <Hashtable>] [[-serviceLocation] <Hashtable>]
 [[-source] <Hashtable>] [[-requiredDate] <String>] [[-budgetHours] <Decimal>] [[-opportunity] <Hashtable>]
 [[-agreement] <Hashtable>] [[-severity] <String>] [[-impact] <String>] [[-externalXRef] <String>]
 [[-poNumber] <String>] [[-knowledgeBaseCategoryId] <Int32>] [[-knowledgeBaseSubCategoryId] <Int32>]
 [[-allowAllClientsPortalView] <Boolean>] [[-customerUpdatedFlag] <Boolean>]
 [[-automaticEmailContactFlag] <Boolean>] [[-automaticEmailResourceFlag] <Boolean>]
 [[-automaticEmailCcFlag] <Boolean>] [[-automaticEmailCc] <String>] [[-initialDescription] <String>]
 [[-initialInternalAnalysis] <String>] [[-initialResolution] <String>] [[-contactEmailLookup] <String>]
 [[-processNotifications] <Boolean>] [[-skipCallback] <Boolean>] [[-closedDate] <String>]
 [[-closedBy] <String>] [[-closedFlag] <Boolean>] [[-dateEntered] <String>] [[-enteredBy] <String>]
 [[-actualHours] <Decimal>] [[-approved] <Boolean>] [[-subBillingMethod] <String>]
 [[-subBillingAmount] <Decimal>] [[-subDateAccepted] <String>] [[-dateResolved] <String>]
 [[-dateResplan] <String>] [[-dateResponded] <String>] [[-resolveMinutes] <Int32>] [[-resPlanMinutes] <Int32>]
 [[-respondMinutes] <Int32>] [[-isInSla] <Boolean>] [[-knowledgeBaseLinkId] <Int32>] [[-resources] <String>]
 [[-parentTicketId] <Int32>] [[-hasChildTicket] <Boolean>] [[-knowledgeBaseLinkType] <String>]
 [[-billTime] <String>] [[-billExpenses] <String>] [[-billProducts] <String>] [[-predecessorType] <String>]
 [[-predecessorId] <Int32>] [[-predecessorClosedFlag] <Boolean>] [[-lagDays] <Int32>]
 [[-lagNonworkingDaysFlag] <Boolean>] [[-estimatedStartDate] <String>] [[-duration] <Int32>]
 [-location <Hashtable>] [-department <Hashtable>] [[-locationId] <Int32>] [[-businessUnitId] <Int32>]
 [[-mobileGuid] <Guid>] [[-sla] <Hashtable>] [[-currency] <Hashtable>] [[-_info] <Hashtable>]
 [[-customFields] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$NewTicketParameters = @{
    summary = 'Testing out the API'
    # We want to pass Manage objects as hash tables
    company = @{id = $Company.ID}
    contactName = 'Chris Taylor'
    contactPhoneNumber = '123456789'
    contactEmailAddress = 'dont@bug.me'
}
New-CWMTicket @NewTicketParameters
```

This will create a new Manage ticket

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
Position: 89
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
{{ Fill actualHours Description }}

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine1
{{ Fill addressLine1 Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addressLine2
{{ Fill addressLine2 Description }}

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

### -agreement
{{ Fill agreement Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowAllClientsPortalView
{{ Fill allowAllClientsPortalView Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -approved
{{ Fill approved Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailCc
{{ Fill automaticEmailCc Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailCcFlag
{{ Fill automaticEmailCcFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailContactFlag
{{ Fill automaticEmailContactFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -automaticEmailResourceFlag
{{ Fill automaticEmailResourceFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -board
{{ Fill board Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
{{ Fill budgetHours Description }}

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
{{ Fill businessUnitId Description }}

```yaml
Type: Int32
Parameter Sets: 2019.1
Aliases:

Required: False
Position: 85
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -city
{{ Fill city Description }}

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

### -closedBy
{{ Fill closedBy Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedDate
{{ Fill closedDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -closedFlag
{{ Fill closedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
{{ Fill company Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
{{ Fill contact Description }}

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

### -contactEmailAddress
{{ Fill contactEmailAddress Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactEmailLookup
{{ Fill contactEmailLookup Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactName
{{ Fill contactName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contactPhoneExtension
{{ Fill contactPhoneExtension Description }}

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

### -contactPhoneNumber
{{ Fill contactPhoneNumber Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
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
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
{{ Fill currency Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 88
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
Position: 90
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerUpdatedFlag
{{ Fill customerUpdatedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateEntered
{{ Fill dateEntered Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResolved
{{ Fill dateResolved Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResplan
{{ Fill dateResplan Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateResponded
{{ Fill dateResponded Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -duration
{{ Fill duration Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 83
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -enteredBy
{{ Fill enteredBy Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedStartDate
{{ Fill estimatedStartDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 82
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalXRef
{{ Fill externalXRef Description }}

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

### -hasChildTicket
{{ Fill hasChildTicket Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: False
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
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -impact
{{ Fill impact Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialDescription
{{ Fill initialDescription Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialInternalAnalysis
{{ Fill initialInternalAnalysis Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -initialResolution
{{ Fill initialResolution Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isInSla
{{ Fill isInSla Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -item
{{ Fill item Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseCategoryId
{{ Fill knowledgeBaseCategoryId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseLinkId
{{ Fill knowledgeBaseLinkId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseLinkType
{{ Fill knowledgeBaseLinkType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -knowledgeBaseSubCategoryId
{{ Fill knowledgeBaseSubCategoryId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -lagDays
{{ Fill lagDays Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 80
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -lagNonworkingDaysFlag
{{ Fill lagNonworkingDaysFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 81
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
{{ Fill locationId Description }}

```yaml
Type: Int32
Parameter Sets: 2019.1
Aliases:

Required: False
Position: 84
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -mobileGuid
{{ Fill mobileGuid Description }}

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: 86
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -opportunity
{{ Fill opportunity Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -owner
{{ Fill owner Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentTicketId
{{ Fill parentTicketId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -phase
{{ Fill phase Description }}

```yaml
Type: Hashtable
Parameter Sets: 2019.1
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poNumber
{{ Fill poNumber Description }}

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

### -predecessorClosedFlag
{{ Fill predecessorClosedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 79
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -predecessorId
{{ Fill predecessorId Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 78
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -predecessorType
{{ Fill predecessorType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
{{ Fill priority Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -processNotifications
{{ Fill processNotifications Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -project
{{ Fill project Description }}

```yaml
Type: Hashtable
Parameter Sets: 2019.1
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordType
{{ Fill recordType Description }}

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

### -requiredDate
{{ Fill requiredDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resPlanMinutes
{{ Fill resPlanMinutes Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolveMinutes
{{ Fill resolveMinutes Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -resources
{{ Fill resources Description }}

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

### -respondMinutes
{{ Fill respondMinutes Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: 0
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
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -severity
{{ Fill severity Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
{{ Fill site Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteName
{{ Fill siteName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -skipCallback
{{ Fill skipCallback Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla
{{ Fill sla Description }}

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

### -source
{{ Fill source Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -stateIdentifier
{{ Fill stateIdentifier Description }}

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

### -status
{{ Fill status Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subBillingAmount
{{ Fill subBillingAmount Description }}

```yaml
Type: Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -subBillingMethod
{{ Fill subBillingMethod Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subDateAccepted
{{ Fill subDateAccepted Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subType
{{ Fill subType Description }}

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

### -summary
{{ Fill summary Description }}

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

### -team
{{ Fill team Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
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
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wbsCode
{{ Fill wbsCode Description }}

```yaml
Type: String
Parameter Sets: 2019.1
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zip
{{ Fill zip Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingAmount
{{ Fill billingAmount Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingMethod
{{ Fill billingMethod Description }}

```yaml
Type: String
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
{{ Fill department Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseCost
{{ Fill estimatedExpenseCost Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseRevenue
{{ Fill estimatedExpenseRevenue Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductCost
{{ Fill estimatedProductCost Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
{{ Fill estimatedProductRevenue Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
{{ Fill estimatedTimeCost Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
{{ Fill estimatedTimeRevenue Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hasMergedChildTicketFlag
{{ Fill hasMergedChildTicketFlag Description }}

```yaml
Type: Boolean
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: Decimal
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -integratorTags
{{ Fill integratorTags Description }}

```yaml
Type: String
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mergedParentTicket
{{ Fill mergedParentTicket Description }}

```yaml
Type: Hashtable
Parameter Sets: 2020.1
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
{{ Fill Version Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VersionAutomatic
{{ Fill VersionAutomatic Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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
Author: Chris Taylor
Date: 8/22/2018

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?a=Service&e=Tickets&o=CREATE#/Tickets/postServiceTickets](https://developer.connectwise.com/Products/Manage/REST?a=Service&e=Tickets&o=CREATE#/Tickets/postServiceTickets)

