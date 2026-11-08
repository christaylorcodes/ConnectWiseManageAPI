---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMAgreementWorkType

## SYNOPSIS
Creates an agreement work type rate for an agreement.

## SYNTAX

```
New-CWMAgreementWorkType [-parentId] <Int32> [[-id] <Int32>] [[-workType] <Object>] [[-location] <Object>]
 [[-locationId] <Int32>] [-rateType] <String> [-billTime] <String> [[-rate] <Double>] [[-hoursMax] <Double>]
 [[-hoursMin] <Double>] [[-roundBillHours] <Double>] [[-overageRate] <Double>] [[-overageRateType] <String>]
 [[-agreementLimit] <Double>] [[-site] <Object>] [[-effectiveDate] <String>] [[-endingDate] <String>]
 [[-agreement] <Object>] [[-company] <Object>] [[-_info] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an agreement work type rate in ConnectWise Manage.
Calls POST /finance/agreements/{parentId}/worktypes; only the
parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMAgreementWorkType -parentId 12 -workType @{ id = 7 } -rateType Multiplier -rate 1.5 -billTime Billable
```

Bills work type 7 at 1.5 times the standard rate on agreement 12.

## PARAMETERS

### -parentId
The id of the agreement to add the agreement work type rate to.
Alias: agreementId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: agreementId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new record.

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

### -workType
Work type reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
Location reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
Location id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -rateType
Rate type.
One of: AdjAmount, Custom, Multiplier.
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

### -billTime
Bill time.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rate
Rate.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursMax
Hours max.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoursMin
Hours min.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -roundBillHours
Round bill hours.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -overageRate
Overage rate.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -overageRateType
Overage rate type.
One of: AdjAmount, Custom, Multiplier.

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

### -agreementLimit
Agreement limit.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
Site reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -effectiveDate
Effective date.
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

### -endingDate
Ending date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
Agreement reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Company reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
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
Position: 20
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

