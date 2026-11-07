---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMInvoice

## SYNOPSIS
Creates an invoice.

## SYNTAX

```
New-CWMInvoice [[-id] <Int32>] [[-invoiceNumber] <String>] [-type] <String> [[-status] <Object>]
 [-company] <Object> [[-billToCompany] <Object>] [[-shipToCompany] <Object>] [[-accountNumber] <String>]
 [[-applyToType] <String>] [[-applyToId] <Int32>] [[-attention] <String>] [[-shipToAttention] <String>]
 [[-billingSite] <Object>] [[-billingSiteAddressLine1] <String>] [[-billingSiteAddressLine2] <String>]
 [[-billingSiteCity] <String>] [[-billingSiteState] <String>] [[-billingSiteZip] <String>]
 [[-billingSiteCountry] <String>] [[-shippingSite] <Object>] [[-shippingSiteAddressLine1] <String>]
 [[-shippingSiteAddressLine2] <String>] [[-shippingSiteCity] <String>] [[-shippingSiteState] <String>]
 [[-shippingSiteZip] <String>] [[-shippingSiteCountry] <String>] [[-billingTerms] <Object>]
 [[-reference] <String>] [[-customerPO] <String>] [[-templateSetupId] <Int32>] [[-invoiceTemplate] <Object>]
 [[-emailTemplateId] <Int32>] [[-addToBatchEmailList] <Boolean>] [[-date] <String>]
 [[-restrictDownpaymentFlag] <Boolean>] [[-locationId] <Int32>] [[-location] <Object>]
 [[-departmentId] <Int32>] [[-department] <Object>] [[-territoryId] <Int32>] [[-territory] <Object>]
 [[-topComment] <String>] [[-bottomComment] <String>] [[-taxableFlag] <Boolean>] [[-taxCode] <Object>]
 [[-internalNotes] <String>] [[-downpaymentPreviouslyTaxedFlag] <Boolean>] [[-serviceTotal] <Single>]
 [[-overrideDownPaymentAmountFlag] <Boolean>] [[-currency] <Object>] [[-dueDate] <String>]
 [[-expenseTotal] <Single>] [[-productTotal] <Single>] [[-previousProgressApplied] <Single>]
 [[-serviceAdjustmentAmount] <Single>] [[-agreementAmount] <Single>] [[-downpaymentApplied] <Single>]
 [[-subtotal] <Single>] [[-total] <Single>] [[-remainingDownpayment] <Single>] [[-salesTax] <Single>]
 [[-adjustmentReason] <String>] [[-adjustedBy] <String>] [[-closedBy] <String>] [[-payments] <Single>]
 [[-credits] <Single>] [[-balance] <Single>] [[-specialInvoiceFlag] <Boolean>]
 [[-billingSetupReference] <Object>] [[-ticket] <Object>] [[-project] <Object>] [[-phase] <Object>]
 [[-salesOrder] <Object>] [[-agreement] <Object>] [[-glBatch] <Object>] [[-unbatchedBatch] <Object>]
 [[-_info] <Hashtable>] [[-customFields] <Array>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates an invoice in ConnectWise Manage.
Calls POST /finance/invoices; only the
parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMInvoice -type Miscellaneous -company @{ id = 250 } -reference 'Project kickoff'
```

Creates a miscellaneous invoice for company 250.

## PARAMETERS

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new record.

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

### -invoiceNumber
Invoice number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Type.
One of: Agreement, CreditMemo, DownPayment, Miscellaneous, Progress, Standard, Consolidated.
Required by the API.

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

### -status
Status reference, for example @{ id = 1 }.

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

### -company
Company reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
Bill to company reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shipToCompany
Ship to company reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -accountNumber
Account number.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applyToType
Apply to type.
One of: All, Agreement, Project, ProjectPhase, SalesOrder, Ticket.

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

### -applyToId
Apply to id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -attention
Attention.

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

### -shipToAttention
Ship to attention.

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

### -billingSite
Billing site reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingSiteAddressLine1
Billing site address line1.

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

### -billingSiteAddressLine2
Billing site address line2.

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

### -billingSiteCity
Billing site city.

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

### -billingSiteState
Billing site state.

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

### -billingSiteZip
Billing site zip.

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

### -billingSiteCountry
Billing site country.

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

### -shippingSite
Shipping site reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shippingSiteAddressLine1
Shipping site address line1.

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

### -shippingSiteAddressLine2
Shipping site address line2.

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

### -shippingSiteCity
Shipping site city.

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

### -shippingSiteState
Shipping site state.

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

### -shippingSiteZip
Shipping site zip.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -shippingSiteCountry
Shipping site country.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingTerms
Billing terms reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reference
Reference.

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

### -customerPO
Customer po.

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

### -templateSetupId
Template setup id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTemplate
Invoice template reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailTemplateId
Email template id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -addToBatchEmailList
Add to batch email list.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -date
Date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownpaymentFlag
Restrict downpayment flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: False
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
Position: 36
Default value: 0
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
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -departmentId
Department id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
Department reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -territoryId
Territory id.
A whole number.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -territory
Territory reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -topComment
Top comment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bottomComment
Bottom comment.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
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
Position: 44
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxCode
Tax code reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalNotes
Internal notes.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -downpaymentPreviouslyTaxedFlag
Downpayment previously taxed flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceTotal
Service total.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -overrideDownPaymentAmountFlag
Override down payment amount flag.
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

### -currency
Currency reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dueDate
Due date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expenseTotal
Expense total.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -productTotal
Product total.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -previousProgressApplied
Previous progress applied.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceAdjustmentAmount
Service adjustment amount.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementAmount
Agreement amount.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -downpaymentApplied
Downpayment applied.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -subtotal
Subtotal.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -total
Total.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -remainingDownpayment
Remaining downpayment.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesTax
Sales tax.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -adjustmentReason
Adjustment reason.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -adjustedBy
Adjusted by.

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

### -closedBy
Closed by.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -payments
Payments.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -credits
Credits.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -balance
Balance.
A number.

```yaml
Type: System.Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -specialInvoiceFlag
Special invoice flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingSetupReference
Billing setup reference reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ticket
Ticket reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -project
Project reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -phase
Phase reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -salesOrder
Sales order reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
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
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -glBatch
Gl batch reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -unbatchedBatch
Unbatched batch reference, for example @{ id = 1 }.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
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
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
Custom field values, for example @(@{ id = 4; value = 'x' }).

```yaml
Type: System.Array
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

