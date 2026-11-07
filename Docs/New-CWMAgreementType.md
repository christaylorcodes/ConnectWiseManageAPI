---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMAgreementType

## SYNOPSIS
{{ Fill in the Synopsis }}

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
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

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

### -_info
{{ Fill _info Description }}

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

### -addAllWorkRoleExclusions
{{ Fill addAllWorkRoleExclusions Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -addAllWorkTypeExclusions
{{ Fill addAllWorkTypeExclusions Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 57
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -allowOverrunsFlag
{{ Fill allowOverrunsFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationCycle
{{ Fill applicationCycle Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Contract2Weeks, Contract4Weeks, ContractYear, CalendarMonth, CalendarQuarter, CalendarWeek, ContractQuarter, CalendarYear

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationLimit
{{ Fill applicationLimit Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationUnits
{{ Fill applicationUnits Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Amount, Hours, Incidents

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -applicationUnlimitedFlag
{{ Fill applicationUnlimitedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -autoInvoiceFlag
{{ Fill autoInvoiceFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billAmount
{{ Fill billAmount Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billExpenses
{{ Fill billExpenses Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billOneTimeFlag
{{ Fill billOneTimeFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billProducts
{{ Fill billProducts Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billTime
{{ Fill billTime Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billable, DoNotBill, NoCharge, NoDefault

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableExpenseInvoiceFlag
{{ Fill billableExpenseInvoiceFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableProductInvoiceFlag
{{ Fill billableProductInvoiceFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billableTimeInvoiceFlag
{{ Fill billableTimeInvoiceFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingCycle
{{ Fill billingCycle Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingTerms
{{ Fill billingTerms Description }}

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bottomCommentFlag
{{ Fill bottomCommentFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -carryOverUnusedFlag
{{ Fill carryOverUnusedFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -chargeToFirmFlag
{{ Fill chargeToFirmFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -compHourlyRate
{{ Fill compHourlyRate Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -compLimitAmount
{{ Fill compLimitAmount Description }}

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyWorkRolesFlag
{{ Fill copyWorkRolesFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -copyWorkTypesFlag
{{ Fill copyWorkTypesFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 52
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementExpenseFlag
{{ Fill coverAgreementExpenseFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementProductFlag
{{ Fill coverAgreementProductFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverAgreementTimeFlag
{{ Fill coverAgreementTimeFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -coverSalesTaxFlag
{{ Fill coverSalesTaxFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultFlag
{{ Fill defaultFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
{{ Fill department Description }}

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

### -emailTemplate
{{ Fill emailTemplate Description }}

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

### -employeeCompNotExceed
{{ Fill employeeCompNotExceed Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Billing, Amount, Percent

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -employeeCompRate
{{ Fill employeeCompRate Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Actual, Hourly

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -exclusionWorkRoleIds
{{ Fill exclusionWorkRoleIds Description }}

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -exclusionWorkTypeIds
{{ Fill exclusionWorkTypeIds Description }}

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 56
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expireWhenZero
{{ Fill expireWhenZero Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -expiredDays
{{ Fill expiredDays Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -inactiveFlag
{{ Fill inactiveFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -integrationXRef
{{ Fill integrationXRef Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 59
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceDescription
{{ Fill invoiceDescription Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoicePreSuffix
{{ Fill invoicePreSuffix Description }}

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

### -invoiceProratedAdditionsFlag
{{ Fill invoiceProratedAdditionsFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 63
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -invoiceTemplate
{{ Fill invoiceTemplate Description }}

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

### -invoicingCycle
{{ Fill invoicingCycle Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: ContractYear, CalendarYear

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
{{ Fill limit Description }}

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location
{{ Fill location Description }}

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

### -name
{{ Fill name Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -oneTimeFlag
{{ Fill oneTimeFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -prePaymentFlag
{{ Fill prePaymentFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -prefixSuffixOption
{{ Fill prefixSuffixOption Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Prefix, Suffix

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -projectType
{{ Fill projectType Description }}

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

### -prorateFlag
{{ Fill prorateFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 60
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllWorkRoleExclusions
{{ Fill removeAllWorkRoleExclusions Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -removeAllWorkTypeExclusions
{{ Fill removeAllWorkTypeExclusions Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 58
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDepartmentFlag
{{ Fill restrictDepartmentFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownPaymentFlag
{{ Fill restrictDownPaymentFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictLocationFlag
{{ Fill restrictLocationFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sla
{{ Fill sla Description }}

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

### -taxableFlag
{{ Fill taxableFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -topCommentFlag
{{ Fill topCommentFlag Description }}

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -workRole
{{ Fill workRole Description }}

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

### -workType
{{ Fill workType Description }}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
