---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMProjectPhase

## SYNOPSIS
{{ Fill in the Synopsis }}

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
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

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

### -_info
{{ Fill _info Description }}

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

### -actualEnd
{{ Fill actualEnd Description }}

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

### -actualHours
{{ Fill actualHours Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualStart
{{ Fill actualStart Description }}

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

### -agreement
{{ Fill agreement Description }}

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

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billPhaseClosedFlag
{{ Fill billPhaseClosedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProjectClosedFlag
{{ Fill billProjectClosedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billSeparatelyFlag
{{ Fill billSeparatelyFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
{{ Fill billToCompany Description }}

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

### -billToContact
{{ Fill billToContact Description }}

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

### -billToSite
{{ Fill billToSite Description }}

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

### -billingMethod
{{ Fill billingMethod Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: ActualRates, FixedFee, NotToExceed, OverrideRate

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingStartDate
{{ Fill billingStartDate Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -board
{{ Fill board Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
{{ Fill budgetHours Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
{{ Fill businessUnitId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
{{ Fill currency Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: System.Collections.Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deadlineDate
{{ Fill deadlineDate Description }}

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

### -description
{{ Fill description Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -downpayment
{{ Fill downpayment Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseCost
{{ Fill estimatedExpenseCost Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseRevenue
{{ Fill estimatedExpenseRevenue Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductCost
{{ Fill estimatedProductCost Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
{{ Fill estimatedProductRevenue Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
{{ Fill estimatedTimeCost Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
{{ Fill estimatedTimeRevenue Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
{{ Fill locationId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -markAsMilestoneFlag
{{ Fill markAsMilestoneFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
{{ Fill notes Description }}

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

### -opportunity
{{ Fill opportunity Description }}

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

### -parentId
{{ Fill parentId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentPhase
{{ Fill parentPhase Description }}

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

### -poAmount
{{ Fill poAmount Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poNumber
{{ Fill poNumber Description }}

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

### -projectId
{{ Fill projectId Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledEnd
{{ Fill scheduledEnd Description }}

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

### -scheduledHours
{{ Fill scheduledHours Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledStart
{{ Fill scheduledStart Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToCompany
{{ Fill shipToCompany Description }}

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

### -shipToContact
{{ Fill shipToContact Description }}

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

### -shipToSite
{{ Fill shipToSite Description }}

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

### -status
{{ Fill status Description }}

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

### -wbsCode
{{ Fill wbsCode Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
