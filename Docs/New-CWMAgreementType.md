---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMAgreementType

## SYNOPSIS
Creates an agreement type.

## SYNTAX

```
New-CWMAgreementType [[-id] <Int32>] [-name] <String> [[-prefixSuffixOption] <String>]
 [[-defaultFlag] <Boolean>] [[-inactiveFlag] <Boolean>] [[-prePaymentFlag] <Boolean>]
 [[-invoicePreSuffix] <String>] [[-location] <Hashtable>] [[-department] <Hashtable>]
 [[-restrictLocationFlag] <Boolean>] [[-restrictDepartmentFlag] <Boolean>] [[-sla] <Hashtable>]
 [[-applicationUnits] <String>] [[-applicationLimit] <Double>] [[-applicationCycle] <String>]
 [[-applicationUnlimitedFlag] <Boolean>] [[-oneTimeFlag] <Boolean>] [[-coverAgreementTimeFlag] <Boolean>]
 [[-coverAgreementProductFlag] <Boolean>] [[-coverAgreementExpenseFlag] <Boolean>]
 [[-coverSalesTaxFlag] <Boolean>] [[-carryOverUnusedFlag] <Boolean>] [[-allowOverrunsFlag] <Boolean>]
 [[-expiredDays] <Int32>] [[-limit] <Int32>] [[-expireWhenZero] <Boolean>] [[-chargeToFirmFlag] <Boolean>]
 [[-employeeCompRate] <String>] [[-employeeCompNotExceed] <String>] [[-compHourlyRate] <Double>]
 [[-compLimitAmount] <Double>] [[-billingCycle] <Hashtable>] [[-billOneTimeFlag] <Boolean>]
 [[-billingTerms] <Hashtable>] [[-invoicingCycle] <String>] [[-billAmount] <Double>] [[-taxableFlag] <Boolean>]
 [[-restrictDownPaymentFlag] <Boolean>] [[-invoiceDescription] <String>] [[-topCommentFlag] <Boolean>]
 [[-bottomCommentFlag] <Boolean>] [[-workRole] <Hashtable>] [[-workType] <Hashtable>]
 [[-projectType] <Hashtable>] [[-invoiceTemplate] <Hashtable>] [[-billTime] <String>]
 [[-billExpenses] <String>] [[-billProducts] <String>] [[-billableTimeInvoiceFlag] <Boolean>]
 [[-billableExpenseInvoiceFlag] <Boolean>] [[-billableProductInvoiceFlag] <Boolean>]
 [[-copyWorkRolesFlag] <Boolean>] [[-copyWorkTypesFlag] <Boolean>] [[-exclusionWorkRoleIds] <Array>]
 [[-addAllWorkRoleExclusions] <Boolean>] [[-removeAllWorkRoleExclusions] <Boolean>]
 [[-exclusionWorkTypeIds] <Array>] [[-addAllWorkTypeExclusions] <Boolean>]
 [[-removeAllWorkTypeExclusions] <Boolean>] [[-integrationXRef] <String>] [[-prorateFlag] <Boolean>]
 [[-emailTemplate] <Hashtable>] [[-autoInvoiceFlag] <Boolean>] [[-invoiceProratedAdditionsFlag] <Boolean>]
 [[-_info] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates an agreement type in ConnectWise Manage.
Calls POST /finance/agreements/types; only the
parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
$AgreementType = @{
    name                  = 'Block Hours'
    employeeCompRate      = 'Actual'
    employeeCompNotExceed = 'Billing'
    invoicingCycle        = 'ContractYear'
    billTime              = 'Billable'
    billExpenses          = 'Billable'
    billProducts          = 'Billable'
}
New-CWMAgreementType @AgreementType
```

Creates an agreement type with the properties the API requires.

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
Max length 50.
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

### -prefixSuffixOption
Prefix suffix option.
One of: Prefix, Suffix.

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

### -defaultFlag
Default flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
Inactive flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -prePaymentFlag
Pre payment flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicePreSuffix
Invoice pre suffix.
Max length 5.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
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
Position: 8
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
Position: 9
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
Position: 10
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
Position: 11
Default value: False
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
Position: 12
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
Position: 13
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
Position: 14
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
Position: 15
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
Position: 16
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
Position: 17
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementTimeFlag
Cover agreement time flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementProductFlag
Cover agreement product flag.
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

### -coverAgreementExpenseFlag
Cover agreement expense flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverSalesTaxFlag
Cover sales tax flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -carryOverUnusedFlag
Carry over unused flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowOverrunsFlag
Allow overruns flag.
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

### -expiredDays
Expired days.
An integer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
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
Position: 25
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
Position: 26
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToFirmFlag
Charge to firm flag.
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

### -employeeCompRate
Employee comp rate.
One of: Actual, Hourly.
Required by the API.

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

### -employeeCompNotExceed
Employee comp not exceed.
One of: Billing, Amount, Percent.
Required by the API.

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

### -compHourlyRate
Comp hourly rate.
A number.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
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
Position: 31
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
Position: 32
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
Position: 33
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
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicingCycle
Invoicing cycle.
One of: ContractYear, CalendarYear.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
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
Position: 36
Default value: 0
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
Position: 37
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownPaymentFlag
Restrict down payment flag.
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

### -invoiceDescription
Invoice description.
Max length 4000.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -topCommentFlag
Top comment flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -bottomCommentFlag
Bottom comment flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
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
Position: 42
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
Position: 43
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
Position: 44
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
Position: 45
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

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
Bill expenses.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required by the API.

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

### -billProducts
Bill products.
One of: Billable, DoNotBill, NoCharge, NoDefault.
Required by the API.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableTimeInvoiceFlag
Billable time invoice flag.
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

### -billableExpenseInvoiceFlag
Billable expense invoice flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableProductInvoiceFlag
Billable product invoice flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyWorkRolesFlag
Copy work roles flag.
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

### -copyWorkTypesFlag
Copy work types flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -exclusionWorkRoleIds
Exclusion work role ids.
An array of integers.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addAllWorkRoleExclusions
Add all work role exclusions.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllWorkRoleExclusions
Remove all work role exclusions.
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

### -exclusionWorkTypeIds
Exclusion work type ids.
An array of integers.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addAllWorkTypeExclusions
Add all work type exclusions.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllWorkTypeExclusions
Remove all work type exclusions.
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

### -integrationXRef
Integration XRef.
Max length 50.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
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
Position: 61
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -emailTemplate
Email template reference, for example @{ id = 1 }.

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

### -autoInvoiceFlag
Auto invoice flag.
$true or $false.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceProratedAdditionsFlag
Invoice prorated additions flag.
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

### -_info
The _info metadata of the record, as returned by the API.
Usually left unset.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 65
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

