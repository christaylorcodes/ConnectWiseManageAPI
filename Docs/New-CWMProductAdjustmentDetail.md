---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMProductAdjustmentDetail

## SYNOPSIS
Creates a product adjustment detail for a product adjustment.

## SYNTAX

```
New-CWMProductAdjustmentDetail [-parentId] <Int32> [-catalogItem] <Hashtable> [[-description] <String>]
 [[-quantityOnHand] <Double>] [[-unitCost] <Double>] [-warehouse] <Hashtable> [-warehouseBin] <Hashtable>
 [-quantityAdjusted] <Int32> [[-serialNumber] <String>] [[-adjustment] <Hashtable>] [[-_info] <Hashtable>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a product adjustment detail for a product adjustment in ConnectWise Manage.
Calls POST
/procurement/adjustments/{parentId}/details; only the parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMProductAdjustmentDetail -parentId 12 -catalogItem @{ id = 15 } -warehouse @{ id = 1 } -warehouseBin @{ id = 2 } -quantityAdjusted 5
```

Adds a detail line for catalog item 15 in warehouse 1, bin 2 to product adjustment 12.

## PARAMETERS

### -parentId
The id of the product adjustment to add the product adjustment detail to.
Alias: adjustmentID

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: adjustmentID

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -catalogItem
Catalog item reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Description.
Max length 50.

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

### -quantityOnHand
Quantity on hand.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -unitCost
Unit cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
Warehouse reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseBin
Warehouse bin reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -quantityAdjusted
Quantity adjusted.
An integer.
Required by the API.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serialNumber
Serial number.
Max length 1000.

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

### -adjustment
Adjustment reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
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
Position: 11
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

