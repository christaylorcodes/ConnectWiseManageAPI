---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMProductCatalog

## SYNOPSIS
This function will create a new catalog.

## SYNTAX

```
New-CWMProductCatalog [-identifier] <String> [-description] <String> [[-inactiveFlag] <Boolean>]
 [-subcategory] <Object> [-type] <Object> [[-productClass] <String>] [[-serializedFlag] <Boolean>]
 [[-serializedCostFlag] <Boolean>] [[-phaseProductFlag] <Boolean>] [[-unitOfMeasure] <Object>]
 [[-minStockLevel] <Int32>] [[-price] <Single>] [[-cost] <Single>] [[-priceAttribute] <Int32>]
 [[-taxableFlag] <Boolean>] [-customerDescription] <String> [[-manufacturer] <Object>]
 [[-manufacturerPartNumber] <String>] [[-vendor] <Object>] [[-vendorSku] <String>] [[-notes] <String>]
 [[-integrationXRef] <String>] [[-dateEntered] <String>] [[-category] <Object>] [[-_info] <Object>]
 [[-customFields] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$Catalog = @{
```

'identifier' = $Product.offerName     'description' = $Product.offerName     'subcategory' = @{id = 152}     'type' = @{id = 47}     'customerDescription' = $Product.offerName     'cost' = $Product.unitPrice     'price' = $Price     'manufacturerPartNumber' = $Product.offerName     'manufacturer' = $Manufacturer     'productClass' = 'Agreement'     'taxableFlag' = $true } New-CWMCatalog @Catalog

## PARAMETERS

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
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category
{{ Fill category Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cost
{{ Fill cost Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerDescription
{{ Fill customerDescription Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 15
Default value: None
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
Position: 22
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

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -identifier
{{ Fill identifier Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
{{ Fill inactiveFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -integrationXRef
{{ Fill integrationXRef Description }}

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

### -manufacturer
{{ Fill manufacturer Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturerPartNumber
{{ Fill manufacturerPartNumber Description }}

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

### -minStockLevel
{{ Fill minStockLevel Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
{{ Fill notes Description }}

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

### -phaseProductFlag
{{ Fill phaseProductFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -price
{{ Fill price Description }}

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -priceAttribute
{{ Fill priceAttribute Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -productClass
{{ Fill productClass Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Agreement, Bundle, Inventory, NonInventory, Service

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serializedCostFlag
{{ Fill serializedCostFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -serializedFlag
{{ Fill serializedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -subcategory
{{ Fill subcategory Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
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
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{ Fill type Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -unitOfMeasure
{{ Fill unitOfMeasure Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendor
{{ Fill vendor Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendorSku
{{ Fill vendorSku Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 10/10/2018

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=Procurement&e=CatalogsItem&o=CREATE](https://developer.connectwise.com/manage/rest?a=Procurement&e=CatalogsItem&o=CREATE)

