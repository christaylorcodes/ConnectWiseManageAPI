---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Get-CWMAgreementAdjustment

## SYNOPSIS
Gets agreement adjustments.

## SYNTAX

```
Get-CWMAgreementAdjustment [-parentId] <Int32> [[-id] <Int32>] [-count] [[-condition] <String>]
 [[-orderBy] <String>] [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Retrieves agreement adjustments from ConnectWise Manage, or a single agreement adjustment by id.
Calls GET
/finance/agreements/{parentId}/adjustments; -id adds /{id} and -count adds /count.

## EXAMPLES

### EXAMPLE 1
```
Get-CWMAgreementAdjustment -parentId 12 -all
```

Retrieves every agreement adjustment of agreement 12.

### EXAMPLE 2
```
Get-CWMAgreementAdjustment -parentId 12 -id 5
```

Retrieves agreement adjustment 5 of agreement 12.

## PARAMETERS

### -parentId
The id of the agreement.
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
The id of a single agreement adjustment to retrieve.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: adjustmentId

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Return only the number of matching agreement adjustments instead of the records.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -condition
Filter in ConnectWise Manage condition syntax, for example "amount\>0".

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

### -orderBy
Sort order as 'field asc' or 'field desc', for example 'id desc'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childConditions
Filter on child (list) fields, in condition syntax.

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

### -customFieldConditions
Filter on custom field values, in condition syntax.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to return.
Use with -pageSize.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
The number of records per page.
Without it the API's default page size applies.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Only return these fields, for example @('id', 'amount').

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Retrieve every matching record, handling pagination automatically.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

