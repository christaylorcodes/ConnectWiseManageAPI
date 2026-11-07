---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMAgreement

## SYNOPSIS
Creates an agreement.

## SYNTAX

```
New-CWMAgreement [[-id] <Int32>] [-name] <String> [[-type] <Hashtable>] [[-company] <Hashtable>]
 [[-contact] <Hashtable>] [[-site] <Hashtable>] [[-subContractCompany] <Hashtable>]
 [[-subContractContact] <Hashtable>] [[-parentAgreement] <Hashtable>] [[-customerPO] <String>]
 [[-location] <Hashtable>] [[-department] <Hashtable>] [[-restrictLocationFlag] <Boolean>]
 [[-restrictDepartmentFlag] <Boolean>] [[-startDate] <String>] [[-endDate] <String>]
 [[-noEndingDateFlag] <Boolean>] [[-opportunity] <Hashtable>] [[-cancelledFlag] <Boolean>]
 [[-dateCancelled] <String>] [[-reasonCancelled] <String>] [[-sla] <Hashtable>] [[-workOrder] <String>]
 [[-internalNotes] <String>] [[-applicationUnits] <String>] [[-applicationLimit] <Double>]
 [[-applicationCycle] <String>] [[-applicationUnlimitedFlag] <Boolean>] [[-oneTimeFlag] <Boolean>]
 [[-coverAgreementTime] <Boolean>] [[-coverAgreementProduct] <Boolean>] [[-coverAgreementExpense] <Boolean>]
 [[-coverSalesTax] <Boolean>] [[-carryOverUnused] <Boolean>] [[-allowOverruns] <Boolean>]
 [[-expiredDays] <Int32>] [[-limit] <Int32>] [[-expireWhenZero] <Boolean>] [[-chargeToFirm] <Boolean>]
 [[-employeeCompRate] <String>] [[-employeeCompNotExceed] <String>] [[-compHourlyRate] <Double>]
 [[-compLimitAmount] <Double>] [[-billingCycle] <Hashtable>] [[-billOneTimeFlag] <Boolean>]
 [[-billingTerms] <Hashtable>] [[-invoicingCycle] <String>] [[-billToCompany] <Hashtable>]
 [[-billToContact] <Hashtable>] [[-billToSite] <Hashtable>] [[-billAmount] <Double>] [[-taxable] <Boolean>]
 [[-prorateFirstBill] <Double>] [[-billStartDate] <String>] [[-taxCode] <Hashtable>]
 [[-restrictDownPayment] <Boolean>] [[-prorateFlag] <Boolean>] [[-invoiceDescription] <String>]
 [[-topComment] <Boolean>] [[-bottomComment] <Boolean>] [[-workRole] <Hashtable>] [[-workType] <Hashtable>]
 [[-projectType] <Hashtable>] [[-invoiceTemplate] <Hashtable>] [[-billTime] <String>]
 [[-billExpenses] <String>] [[-billProducts] <String>] [[-billableTimeInvoice] <Boolean>]
 [[-billableExpenseInvoice] <Boolean>] [[-billableProductInvoice] <Boolean>] [[-currency] <Hashtable>]
 [[-periodType] <String>] [[-autoInvoiceFlag] <Boolean>] [[-nextInvoiceDate] <String>]
 [[-companyLocation] <Hashtable>] [[-agreementStatus] <String>] [[-_info] <Hashtable>]
 [[-customFields] <Array>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an agreement in ConnectWise Manage.
Calls POST /finance/agreements; only the parameters you pass
are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMAgreement -name 'Managed Services' -type @{ id = 1 } -company @{ id = 250 } -contact @{ id = 500 }
```

Creates an agreement of agreement type 1 for company 250 with contact 500.

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

### -name
Name.
Max length 100.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Type reference, for example @{ id = 1 }.
Required by the API.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
Company reference, for example @{ id = 250 }.
Required by the API.

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

### -contact
Contact reference, for example @{ id = 500 }.
Required by the API.

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

### -site
Site reference, for example @{ id = 5 }.

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

### -subContractCompany
Sub contract company reference, for example @{ id = 1 }.

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

### -subContractContact
Sub contract contact reference, for example @{ id = 1 }.

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

### -parentAgreement
Parent agreement reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerPO
Customer PO.
Max length 50.

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

### -location
Location reference, for example @{ id = 1 }.

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

### -department
Department reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictLocationFlag
Restrict location flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDepartmentFlag
Restrict department flag.
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

### -startDate
Start date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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

### -endDate
End date.
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

### -noEndingDateFlag
No ending date flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: False
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
Position: 18
Default value: None
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
Position: 19
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateCancelled
Date cancelled.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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

### -reasonCancelled
Reason cancelled.
Max length 100.

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

### -sla
SLA reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workOrder
Work order.
Max length 20.

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

### -internalNotes
Internal notes.

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

### -applicationUnits
Application units.
One of: Amount, Hours, Incidents.

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

### -applicationLimit
Application limit.
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

### -applicationCycle
Application cycle.
One of: Contract2Weeks, Contract4Weeks, ContractYear, CalendarMonth, CalendarQuarter,
CalendarWeek, ContractQuarter, CalendarYear.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationUnlimitedFlag
Application unlimited flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -oneTimeFlag
One time flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementTime
Cover agreement time.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementProduct
Cover agreement product.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementExpense
Cover agreement expense.
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

### -coverSalesTax
Cover sales tax.
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

### -carryOverUnused
Carry over unused.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowOverruns
Allow overruns.
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

### -expiredDays
Expired days.
An integer.

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

### -limit
Limit.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -expireWhenZero
Expire when zero.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToFirm
Charge to firm.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeCompRate
Employee comp rate.
One of: Actual, Hourly.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeCompNotExceed
Employee comp not exceed.
One of: Billing, Amount, Percent.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -compHourlyRate
Comp hourly rate.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -compLimitAmount
Comp limit amount.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingCycle
Billing cycle reference, for example @{ id = 1 }.

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

### -billOneTimeFlag
Bill one time flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingTerms
Billing terms reference, for example @{ id = 1 }.

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

### -invoicingCycle
Invoicing cycle.
One of: ContractYear, CalendarYear.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
Bill to company reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToContact
Bill to contact reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToSite
Bill to site reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billAmount
Bill amount.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxable
Taxable.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateFirstBill
Prorate first bill.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billStartDate
Bill start date.
Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

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

### -taxCode
Tax code reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownPayment
Restrict down payment.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateFlag
Prorate flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceDescription
Invoice description.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -topComment
Top comment.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -bottomComment
Bottom comment.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
Work role reference, for example @{ id = 1 }.

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

### -workType
Work type reference, for example @{ id = 1 }.

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

### -projectType
Project type reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTemplate
Invoice template reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
Bill time.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
Bill expenses.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 66
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
Bill products.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required on updates.

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

### -billableTimeInvoice
Billable time invoice.
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

### -billableExpenseInvoice
Billable expense invoice.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableProductInvoice
Billable product invoice.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
Currency reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -periodType
Period type.
One of: Current, Future, Both, Undefined.

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

### -autoInvoiceFlag
Auto invoice flag.
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

### -nextInvoiceDate
Next invoice date.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyLocation
Company location reference, for example @{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementStatus
Agreement status.
One of: Active, Cancelled, Expired, Inactive.

```yaml
Type: System.String
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
Custom fields.
An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

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

