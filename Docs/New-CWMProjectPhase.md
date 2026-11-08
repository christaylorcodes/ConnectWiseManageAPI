---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMProjectPhase

## SYNOPSIS
Creates a phase for a project.

## SYNTAX

```
New-CWMProjectPhase [-parentId] <Int32> [[-id] <Int32>] [[-projectId] <Int32>] [-description] <String>
 [[-board] <Hashtable>] [[-status] <Hashtable>] [[-agreement] <Hashtable>] [[-opportunity] <Hashtable>]
 [[-parentPhase] <Hashtable>] [[-wbsCode] <String>] [[-billTime] <String>] [[-billExpenses] <String>]
 [[-billProducts] <String>] [[-markAsMilestoneFlag] <Boolean>] [[-notes] <String>] [[-deadlineDate] <String>]
 [[-billSeparatelyFlag] <Boolean>] [[-billingMethod] <String>] [[-scheduledHours] <Double>]
 [[-scheduledStart] <String>] [[-scheduledEnd] <String>] [[-actualHours] <Double>] [[-actualStart] <String>]
 [[-actualEnd] <String>] [[-budgetHours] <Double>] [[-locationId] <Int32>] [[-businessUnitId] <Int32>]
 [[-hourlyRate] <Double>] [[-billingStartDate] <String>] [[-billPhaseClosedFlag] <Boolean>]
 [[-billProjectClosedFlag] <Boolean>] [[-downpayment] <Double>] [[-poNumber] <String>] [[-poAmount] <Double>]
 [[-estimatedTimeCost] <Double>] [[-estimatedExpenseCost] <Double>] [[-estimatedProductCost] <Double>]
 [[-estimatedTimeRevenue] <Double>] [[-estimatedExpenseRevenue] <Double>] [[-estimatedProductRevenue] <Double>]
 [[-currency] <Hashtable>] [[-billToCompany] <Hashtable>] [[-billToContact] <Hashtable>]
 [[-billToSite] <Hashtable>] [[-shipToCompany] <Hashtable>] [[-shipToContact] <Hashtable>]
 [[-shipToSite] <Hashtable>] [[-_info] <Hashtable>] [[-customFields] <Hashtable[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a phase for a project in ConnectWise Manage.
Calls POST /project/projects/{parentId}/phases;
only the parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMProjectPhase -parentId 40 -description 'Discovery'
```

Adds a phase named Discovery to project 40.

## PARAMETERS

### -parentId
The id of the project to add the phase to.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectId
Project id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Description.
Max length 100.
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

### -board
Board reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Status reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
Agreement reference, for example @{ id = 30 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -opportunity
Opportunity reference, for example @{ id = 75 }.

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

### -parentPhase
Parent phase reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wbsCode
WBS code.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
Bill time.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
Bill expenses.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
Bill products.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

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

### -markAsMilestoneFlag
Mark as milestone flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
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

### -deadlineDate
Deadline date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billSeparatelyFlag
Bill separately flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingMethod
Billing method.
One of: ActualRates, FixedFee, NotToExceed, OverrideRate.
BillingMethod is required if
the phase billSeparatelyFlag is true.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledHours
Scheduled hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledStart
Scheduled start.

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

### -scheduledEnd
Scheduled end.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
Actual hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualStart
Actual start.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualEnd
Actual end.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
Budget hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
Location id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
Business unit id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
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
Position: 28
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingStartDate
Billing start date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billPhaseClosedFlag
Bill phase closed flag.
$true or $false.
This phase can only be billed after it has been closed.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProjectClosedFlag
Bill project closed flag.
$true or $false.
This phase can only be billed after the project has been
closed.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -downpayment
Downpayment.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -poNumber
PO number.
Max length 25.

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

### -poAmount
PO amount.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
Estimated time cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseCost
Estimated expense cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductCost
Estimated product cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
Estimated time revenue.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseRevenue
Estimated expense revenue.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
Estimated product revenue.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
Currency reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
Bill to company reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToContact
Bill to contact reference, for example @{ id = 1 }.

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

### -billToSite
Bill to site reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToCompany
Ship to company reference, for example @{ id = 1 }.

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

### -shipToContact
Ship to contact reference, for example @{ id = 1 }.

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

### -shipToSite
Ship to site reference, for example @{ id = 1 }.

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

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

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

### -customFields
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
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

