---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMProduct

## SYNOPSIS
Creates a product.

## SYNTAX

```
New-CWMProduct [[-id] <Int32>] [-catalogItem] <Hashtable> [[-description] <String>]
 [[-sequenceNumber] <Decimal>] [[-quantity] <Decimal>] [[-unitOfMeasure] <Hashtable>] [[-price] <Decimal>]
 [[-cost] <Decimal>] [[-extPrice] <Decimal>] [[-extCost] <Decimal>] [[-discount] <Decimal>]
 [[-margin] <Decimal>] [[-agreementAmount] <Decimal>] [[-priceMethod] <String>] [-billableOption] <String>
 [[-agreement] <Hashtable>] [[-locationId] <Int32>] [[-location] <Hashtable>] [[-businessUnitId] <Int32>]
 [[-businessUnit] <Hashtable>] [[-vendor] <Hashtable>] [[-vendorSku] <String>] [[-taxableFlag] <Boolean>]
 [[-dropshipFlag] <Boolean>] [[-specialOrderFlag] <Boolean>] [[-phaseProductFlag] <Boolean>]
 [[-cancelledFlag] <Boolean>] [[-quantityCancelled] <Decimal>] [[-cancelledReason] <String>]
 [[-customerDescription] <String>] [[-internalNotes] <String>] [[-productSuppliedFlag] <Boolean>]
 [[-subContractorShipToId] <Int32>] [[-subContractorAmountLimit] <Decimal>] [[-recurring] <Hashtable>]
 [[-sla] <Hashtable>] [[-entityType] <Hashtable>] [[-ticket] <Hashtable>] [[-project] <Hashtable>]
 [[-phase] <Hashtable>] [[-salesOrder] <Hashtable>] [[-opportunity] <Hashtable>] [[-invoice] <Hashtable>]
 [[-warehouseId] <Int32>] [[-warehouseIdObject] <Hashtable>] [[-warehouseBinId] <Int32>]
 [[-warehouseBinIdObject] <Hashtable>] [[-calculatedPriceFlag] <Boolean>] [[-calculatedCostFlag] <Boolean>]
 [[-forecastDetailId] <Int32>] [[-cancelledBy] <Int32>] [[-cancelledDate] <String>] [[-warehouse] <String>]
 [[-warehouseBin] <String>] [[-purchaseDate] <String>] [[-taxCode] <Hashtable>] [[-integrationXRef] <String>]
 [[-listPrice] <Decimal>] [[-serialNumberIds] <Int32[]>] [[-serialNumbers] <String[]>] [[-company] <Hashtable>]
 [[-forecastStatus] <Hashtable>] [[-productClass] <String>] [[-needToPurchaseFlag] <Boolean>]
 [[-needToOrderQuantity] <Int32>] [[-minimumStockFlag] <Boolean>] [[-shipSet] <String>]
 [[-calculatedPrice] <Decimal>] [[-calculatedCost] <Decimal>] [[-invoiceGrouping] <Hashtable>]
 [[-poApprovedFlag] <Boolean>] [[-uom] <String>] [[-addComponentsFlag] <Boolean>]
 [[-ignorePricingSchedulesFlag] <Boolean>] [[-asioSubscriptionsID] <String>] [[-_info] <Hashtable>]
 [[-bypassForecastUpdate] <Boolean>] [[-customFields] <Hashtable[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a product in ConnectWise Manage.
Calls POST /procurement/products; only the parameters you pass
are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMProduct -catalogItem @{ id = 15 } -billableOption 'Billable' -quantity 2 -ticket @{ id = 1234 }
```

Adds two of catalog item 15 to ticket 1234 as a billable product.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
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
Max length 2000.

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

### -sequenceNumber
Sequence number.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -quantity
Quantity.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -unitOfMeasure
Unit of measure reference, for example @{ id = 1 }.

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

### -price
Price.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cost
Cost.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extPrice
Ext price.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -extCost
Ext cost.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -discount
Discount.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -margin
Margin.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementAmount
Agreement amount.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -priceMethod
Price method.
One of: FlatRateForRange, PercentMarkupFromCost, PercentMarkdownFromPrice, PricePerUnit.

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

### -billableOption
Billable option.
One of: Billable, DoNotBill, NoCharge.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 15
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
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
Location id.
An integer.
Required on updates.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
Location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
Business unit id.
An integer.
Required on updates.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnit
Business unit reference, for example @{ id = 1 }.

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

### -vendor
Vendor reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vendorSku
Vendor SKU.
Max length 50.

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

### -taxableFlag
Taxable flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dropshipFlag
Dropship flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
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
Position: 25
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -phaseProductFlag
Phase product flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledFlag
Cancelled flag.
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

### -quantityCancelled
Quantity cancelled.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledReason
Cancelled reason.
Max length 100.

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

### -customerDescription
Customer description.
Max length 6000.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalNotes
Internal notes.
Max length 1000.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -productSuppliedFlag
Product supplied flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -subContractorShipToId
Sub contractor ship to id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -subContractorAmountLimit
Sub contractor amount limit.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -recurring
Recurring, as a hashtable with the properties of the API's ProductRecurring object.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla
SLA reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entityType
Entity type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ticket
Ticket reference, for example @{ id = 1234 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -project
Project reference, for example @{ id = 40 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phase
Phase reference, for example @{ id = 1 }.

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

### -salesOrder
Sales order reference, for example @{ id = 1 }.

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

### -opportunity
Opportunity reference, for example @{ id = 75 }.

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

### -invoice
Invoice reference, for example @{ id = 1 }.

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

### -warehouseId
Warehouse id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseIdObject
Warehouse id object reference, for example @{ id = 1 }.

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

### -warehouseBinId
Warehouse bin id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseBinIdObject
Warehouse bin id object reference, for example @{ id = 1 }.

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

### -calculatedPriceFlag
Calculated price flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -calculatedCostFlag
Calculated cost flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -forecastDetailId
Forecast detail id.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledBy
Cancelled by.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: 0
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
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouse
Warehouse.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warehouseBin
Warehouse bin.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchaseDate
Purchase date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxCode
Tax code reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -integrationXRef
Integration XRef.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -listPrice
List price.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serialNumberIds
Serial number ids.
An array of integers.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serialNumbers
Serial numbers.
An array of strings.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Company reference, for example @{ id = 250 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -forecastStatus
Forecast status reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -productClass
Product class.
One of: Agreement, Bundle, Inventory, NonInventory, Service.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -needToPurchaseFlag
Need to purchase flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -needToOrderQuantity
Need to order quantity.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -minimumStockFlag
Minimum stock flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipSet
Ship set.
Max length 10.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -calculatedPrice
Calculated price.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -calculatedCost
Calculated cost.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceGrouping
Invoice grouping reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -poApprovedFlag
PO approved flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: False
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
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addComponentsFlag
Add components flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ignorePricingSchedulesFlag
Ignore pricing schedules flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -asioSubscriptionsID
Asio subscriptions id.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
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
Position: 76
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bypassForecastUpdate
Bypass forecast update.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: False
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
Position: 78
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

