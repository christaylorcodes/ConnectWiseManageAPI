---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMAgreementAddition

## SYNOPSIS
This function will create a new agreement addition.

## SYNTAX

```
New-CWMAgreementAddition [-AgreementID] <Int32> [[-id] <Int32>] [-product] <Object> [[-quantity] <Single>]
 [[-lessIncluded] <Single>] [[-unitPrice] <Single>] [[-unitCost] <Single>] [-billCustomer] <String>
 [[-effectiveDate] <String>] [[-cancelledDate] <String>] [[-taxableFlag] <Boolean>] [[-serialNumber] <String>]
 [[-invoiceDescription] <String>] [[-purchaseItemFlag] <Boolean>] [[-specialOrderFlag] <Boolean>]
 [[-description] <String>] [[-billedQuantity] <Single>] [[-uom] <String>] [[-extPrice] <Single>]
 [[-extCost] <Single>] [[-sequenceNumber] <Single>] [[-margin] <Single>] [[-prorateCost] <Single>]
 [[-proratePrice] <Single>] [[-extendedProrateCost] <Single>] [[-extendedProratePrice] <Single>]
 [[-prorateCurrentPeriodFlag] <Boolean>] [[-_info] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$CreateParam = @{
```

AgreementID = $Agreement.id     product = @{id = $Product.id}     billCustomer = 'DoNotBill'     quantity = $Quantity     taxableFlag = $true     effectiveDate = $(Get-Date (Get-Date -Day 1).AddMonths(1) -format yyyy-MM-ddTHH:mm:ssZ) } New-CWMAgreementAddition @CreateParam

## PARAMETERS

### -AgreementID
{{ Fill AgreementID Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
{{ Fill _info Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billCustomer
{{ Fill billCustomer Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billedQuantity
{{ Fill billedQuantity Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledDate
{{ Fill cancelledDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -description
{{ Fill description Description }}

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

### -effectiveDate
{{ Fill effectiveDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -extCost
{{ Fill extCost Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extPrice
{{ Fill extPrice Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extendedProrateCost
{{ Fill extendedProrateCost Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extendedProratePrice
{{ Fill extendedProratePrice Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: 0
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
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceDescription
{{ Fill invoiceDescription Description }}

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

### -lessIncluded
{{ Fill lessIncluded Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -margin
{{ Fill margin Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -product
{{ Fill product Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateCost
{{ Fill prorateCost Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateCurrentPeriodFlag
{{ Fill prorateCurrentPeriodFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -proratePrice
{{ Fill proratePrice Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchaseItemFlag
{{ Fill purchaseItemFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -quantity
{{ Fill quantity Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -sequenceNumber
{{ Fill sequenceNumber Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serialNumber
{{ Fill serialNumber Description }}

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

### -specialOrderFlag
{{ Fill specialOrderFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxableFlag
{{ Fill taxableFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -unitCost
{{ Fill unitCost Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -unitPrice
{{ Fill unitPrice Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -uom
{{ Fill uom Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 4/2/2018

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=Finance&e=AgreementAdditions&o=CREATE](https://developer.connectwise.com/manage/rest?a=Finance&e=AgreementAdditions&o=CREATE)

