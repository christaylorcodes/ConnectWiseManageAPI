---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest?a=Time&e=TimeSheets&o=GET
schema: 2.0.0
---

# New-CWMAgreement

## SYNOPSIS
This function will allow you to search for Manage configurations.

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
 [[-customFields] <Array>] [-ProgressAction <ActionPreference>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-CWTimeSheet -Condition 'member/identifier="ctaylor" and status = "Open"'
```

This will return all the open time sheets for ctaylor

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
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### -_info
{{ Fill _info Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 76
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreementStatus
{{ Fill agreementStatus Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Active, Cancelled, Expired, Inactive

Required: False
Position: 75
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowOverruns
{{ Fill allowOverruns Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationCycle
{{ Fill applicationCycle Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Contract2Weeks, Contract4Weeks, ContractYear, CalendarMonth, CalendarQuarter, CalendarWeek, ContractQuarter, CalendarYear

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationLimit
{{ Fill applicationLimit Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationUnits
{{ Fill applicationUnits Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Amount, Hours, Incidents

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationUnlimitedFlag
{{ Fill applicationUnlimitedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoInvoiceFlag
{{ Fill autoInvoiceFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 72
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billAmount
{{ Fill billAmount Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 65
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billOneTimeFlag
{{ Fill billOneTimeFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 66
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billStartDate
{{ Fill billStartDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 64
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToCompany
{{ Fill billToCompany Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToContact
{{ Fill billToContact Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billToSite
{{ Fill billToSite Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableExpenseInvoice
{{ Fill billableExpenseInvoice Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 68
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableProductInvoice
{{ Fill billableProductInvoice Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 69
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableTimeInvoice
{{ Fill billableTimeInvoice Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 67
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingCycle
{{ Fill billingCycle Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingTerms
{{ Fill billingTerms Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bottomComment
{{ Fill bottomComment Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -cancelledFlag
{{ Fill cancelledFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -carryOverUnused
{{ Fill carryOverUnused Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToFirm
{{ Fill chargeToFirm Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -compHourlyRate
{{ Fill compHourlyRate Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -compLimitAmount
{{ Fill compLimitAmount Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -company
{{ Fill company Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -companyLocation
{{ Fill companyLocation Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 74
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
{{ Fill contact Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementExpense
{{ Fill coverAgreementExpense Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementProduct
{{ Fill coverAgreementProduct Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementTime
{{ Fill coverAgreementTime Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverSalesTax
{{ Fill coverSalesTax Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -currency
{{ Fill currency Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 70
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFields
{{ Fill customFields Description }}

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 77
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerPO
{{ Fill customerPO Description }}

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

### -dateCancelled
{{ Fill dateCancelled Description }}

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

### -department
{{ Fill department Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeCompNotExceed
{{ Fill employeeCompNotExceed Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Billing, Amount, Percent

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeCompRate
{{ Fill employeeCompRate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Actual, Hourly

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
{{ Fill endDate Description }}

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

### -expireWhenZero
{{ Fill expireWhenZero Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expiredDays
{{ Fill expiredDays Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
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
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalNotes
{{ Fill internalNotes Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
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
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTemplate
{{ Fill invoiceTemplate Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicingCycle
{{ Fill invoicingCycle Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: ContractYear, CalendarYear

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
{{ Fill limit Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
{{ Fill name Description }}

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

### -nextInvoiceDate
{{ Fill nextInvoiceDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 73
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -noEndingDateFlag
{{ Fill noEndingDateFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -oneTimeFlag
{{ Fill oneTimeFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -opportunity
{{ Fill opportunity Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentAgreement
{{ Fill parentAgreement Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -periodType
{{ Fill periodType Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Current, Future, Both, Undefined

Required: False
Position: 71
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectType
{{ Fill projectType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateFirstBill
{{ Fill prorateFirstBill Description }}

```yaml
Type: Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -prorateFlag
{{ Fill prorateFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reasonCancelled
{{ Fill reasonCancelled Description }}

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

### -restrictDepartmentFlag
{{ Fill restrictDepartmentFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownPayment
{{ Fill restrictDownPayment Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictLocationFlag
{{ Fill restrictLocationFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
{{ Fill site Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla
{{ Fill sla Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startDate
{{ Fill startDate Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subContractCompany
{{ Fill subContractCompany Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subContractContact
{{ Fill subContractContact Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxCode
{{ Fill taxCode Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -taxable
{{ Fill taxable Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -topComment
{{ Fill topComment Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{ Fill type Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workOrder
{{ Fill workOrder Description }}

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

### -workRole
{{ Fill workRole Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workType
{{ Fill workType Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES
Author: Chris Taylor Date: 1/7/2019

## RELATED LINKS
