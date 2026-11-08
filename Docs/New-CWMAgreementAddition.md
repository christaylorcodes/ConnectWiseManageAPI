---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMAgreementAddition

## SYNOPSIS
Creates an agreement addition for an agreement.

## SYNTAX

```
New-CWMAgreementAddition [-parentId] <Int32> [[-id] <Int32>] [-product] <Object> [[-quantity] <Double>]
 [[-lessIncluded] <Double>] [[-unitPrice] <Double>] [[-unitCost] <Double>] [-billCustomer] <String>
 [[-effectiveDate] <String>] [[-cancelledDate] <String>] [[-taxableFlag] <Boolean>] [[-serialNumber] <String>]
 [[-invoiceDescription] <String>] [[-purchaseItemFlag] <Boolean>] [[-specialOrderFlag] <Boolean>]
 [[-description] <String>] [[-billedQuantity] <Double>] [[-uom] <String>] [[-extPrice] <Double>]
 [[-extCost] <Double>] [[-sequenceNumber] <Double>] [[-margin] <Double>] [[-prorateCost] <Double>]
 [[-proratePrice] <Double>] [[-extendedProrateCost] <Double>] [[-extendedProratePrice] <Double>]
 [[-prorateCurrentPeriodFlag] <Boolean>] [[-_info] <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an agreement addition for an agreement in ConnectWise Manage.
Calls POST
/finance/agreements/{parentId}/additions; only the parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMAgreementAddition -parentId 30 -product @{ id = 15 } -billCustomer 'Billable' -quantity 5
```

Adds five of catalog product 15 to agreement 30 as a billable addition.

## PARAMETERS

### -parentId
The id of the agreement to add the agreement addition to.
Alias: AgreementId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: AgreementId

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

### -product
Product reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -quantity
Quantity.
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

### -lessIncluded
Less included.
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

### -unitPrice
Unit price.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billCustomer
Bill customer.
One of: Billable, DoNotBill, NoCharge.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledDate
Cancelled date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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

### -taxableFlag
Taxable flag.
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

### -serialNumber
Serial number.
Max length 50.

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

### -invoiceDescription
Invoice description.
Max length 6000.

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

### -purchaseItemFlag
Purchase item flag.
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

### -specialOrderFlag
Special order flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
Description.

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

### -billedQuantity
Billed quantity.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -uom
UOM.

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

### -extPrice
Ext price.
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

### -extCost
Ext cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -sequenceNumber
Sequence number.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -margin
Margin.
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

### -prorateCost
Prorate cost.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -proratePrice
Prorate price.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extendedProrateCost
Extended prorate cost.
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

### -extendedProratePrice
Extended prorate price.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateCurrentPeriodFlag
Prorate current period flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: False
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
Position: 28
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

