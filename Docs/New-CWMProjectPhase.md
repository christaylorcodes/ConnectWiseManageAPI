---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTicket

## SYNOPSIS
This function will create a new project phase

## SYNTAX

### 2020.1 (Default)
```
New-CWMProjectPhase [-parentId <Int32>] [-description <String>] [[$id <Int32>]] [[projectId <Int32>]]
 [[board <Hashtable>]] [[status <Hashtable>]] [[agreement <Hashtable>]] [[opportunity <Hashtable>]]
 [[parentPhase <Hashtable>]] [[wbsCode <string>]] [[billTime <string>]] [[billExpenses <string>]]
 [[billProducts <string>]] [[markAsMilestoneFlag <Boolean>]] [[notes <string>]]
 [[deadlineDate <string>]] [[billSeparatelyFlag <Boolean>]] [[billingMethod <string>]]
 [[scheduledHours <Double>]] [[scheduledStart <string>]] [[scheduledEnd <string>]]
 [[actualHours <Double>]] [[actualStart <string>]] [[actualEnd <string>]] [[budgetHours <Double>]]
 [[locationId <Int32>]] [[businessUnitId <Int32>]] [[hourlyRate <Double>]]
 [[billingStartDate <string>]] [[billPhaseClosedFlag <Boolean>]] [[billProjectClosedFlag <Boolean>]]
 [[downpayment <Double>]] [[poNumber <string>]] [[poAmount <Double>]] [[estimatedTimeCost <Double>]]
 [[estimatedExpenseCost <Double>]] [[estimatedProductCost <Double>]] [[estimatedTimeRevenue <Double>]]
 [[estimatedExpenseRevenue <Double>]] [[estimatedProductRevenue <Double>]] [[currency <Hashtable>]]
 [[billToCompany <Hashtable>]] [[billToContact <Hashtable>]] [[billToSite <Hashtable>]]
 [[shipToCompany <Hashtable>]] [[shipToContact <Hashtable>]] [[shipToSite <Hashtable>]]
 [[_info <Hashtable>]] [[$customFields <Hashtable[]>]]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$NewProjectPhase = @{
    parentId = $Matches.id
    description = 'Project'
}
New-CWMProjectPhase @NewProjectPhase
```

This will create a new Manage project phase

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

### -parentId
{{ Fill parentId Description }}

```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectId
{{ Fill projectId Description }}

```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
{{ Fill description Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -board
{{ Fill board Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
{{ Fill status Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
{{ Fill agreement Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -opportunity
{{ Fill opportunity Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentPhase
{{ Fill parentPhase Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -wbsCode
{{ Fill wbsCode Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -markAsMilestoneFlag
{{ Fill markAsMilestoneFlag Description }}

```yaml
Type: bool
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
{{ Fill notes Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -deadlineDate
{{ Fill deadlineDate Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billSeparatelyFlag
{{ Fill billSeparatelyFlag Description }}

```yaml
Type: bool
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingMethod
{{ Fill billingMethod Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledHours
{{ Fill scheduledHours Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledStart
{{ Fill scheduledStart Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduledEnd
{{ Fill scheduledEnd Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualHours
{{ Fill actualHours Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualStart
{{ Fill actualStart Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -actualEnd
{{ Fill actualEnd Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -budgetHours
{{ Fill budgetHours Description }}

```yaml
Type: double
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
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
{{ Fill businessUnitId Description }}

```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hourlyRate
{{ Fill hourlyRate Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingStartDate
{{ Fill billingStartDate Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billPhaseClosedFlag
{{ Fill billPhaseClosedFlag Description }}

```yaml
Type: bool
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProjectClosedFlag
{{ Fill billProjectClosedFlag Description }}

```yaml
Type: bool
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -downpayment
{{ Fill downpayment Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poNumber
{{ Fill poNumber Description }}

```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poAmount
{{ Fill poAmount Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
{{ Fill estimatedTimeCost Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseCost
{{ Fill estimatedExpenseCost Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductCost
{{ Fill estimatedProductCost Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
{{ Fill estimatedTimeRevenue Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedExpenseRevenue
{{ Fill estimatedExpenseRevenue Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
{{ Fill estimatedProductRevenue Description }}

```yaml
Type: double
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
{{ Fill currency Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
{{ Fill billToCompany Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToContact
{{ Fill billToContact Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToSite
{{ Fill billToSite Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToCompany
{{ Fill shipToCompany Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToContact
{{ Fill shipToContact Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToSite
{{ Fill shipToSite Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Andrea Mastellone
Date: 1/28/2021

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST#/ProjectPhasess](https://developer.connectwise.com/Products/Manage/REST#/ProjectPhases)
