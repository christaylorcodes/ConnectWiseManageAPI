---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/Products/ConnectWise_PSA/REST#/AgreementTypes/postFinanceAgreementsTypes
schema: 2.0.0
---

# New-CWMAgreementTypes

## SYNOPSIS
This function will allow you to search for Manage configurations.

## SYNTAX

```
New-CWMAgreementType [[-id] <Int32>] [[-name] <String>] [[-prefixSuffixOption] <String>] [[-defaultFlag] <Boolean>] 
[[-inactiveFlag] <Boolean>] [[-prePaymentFlag] <Boolean>] [[-invoicePreSuffix] <String>] [[-location] <Hashtable>] 
[[-department] <Hashtable>] [[-restrictLocationFlag] <Boolean>] [[-restrictDepartmentFlag] <Boolean>] [[-sla] <Hashtable>] 
[[-applicationUnits] <String>] [[-applicationLimit] <Double>] [[-applicationCycle] <String>] [[-applicationUnlimitedFlag] <Boolean>] 
[[-oneTimeFlag] <Boolean>] [[-coverAgreementTimeFlag] <Boolean>] [[-coverAgreementProductFlag] <Boolean>] 
[[-coverAgreementExpenseFlag] <Boolean>] [[-coverSalesTaxFlag] <Boolean>] [[-carryOverUnusedFlag] <Boolean>] 
[[-allowOverrunsFlag] <Boolean>] [[-expiredDays] <Int32>] [[-limit] <Int32>] [[-expireWhenZero] <Boolean>] 
[[-chargeToFirmFlag] <Boolean>] [[-employeeCompRate] <String>] [[-employeeCompNotExceed] <String>] [[-compHourlyRate] <Double>] 
[[-compLimitAmount] <Double>] [[-billingCycle] <Hashtable>] [[-billOneTimeFlag] <Boolean>] [[-billingTerms] <Hashtable>] 
[[-invoicingCycle] <String>] [[-billAmount] <Double>] [[-taxableFlag] <Boolean>] [[-restrictDownPaymentFlag] <Boolean>] 
[[-invoiceDescription] <String>] [[-topCommentFlag] <Boolean>] [[-bottomCommentFlag] <Boolean>] [[-workRole] <Hashtable>] 
[[-workType] <Hashtable>] [[-projectType] <Hashtable>] [[-invoiceTemplate] <Hashtable>] [[-billTime] <String>] 
[[-billExpenses] <String>] [[-billProducts] <String>] [[-billableTimeInvoiceFlag] <Boolean>] [[-billableExpenseInvoiceFlag] <Boolean>] 
[[-billableProductInvoiceFlag] <Boolean>] [[-copyWorkRolesFlag] <Boolean>] [[-copyWorkTypesFlag] <Boolean>] 
[[-exclusionWorkRoleIds] <Array>] [[-addAllWorkRoleExclusions] <Boolean>] [[-removeAllWorkRoleExclusions] <Boolean>] 
[[-exclusionWorkTypeIds] <Array>] [[-addAllWorkTypeExclusions] <Boolean>] [[-removeAllWorkTypeExclusions] <Boolean>] 
[[-integrationXRef] <String>] [[-prorateFlag] <Boolean>] [[-emailTemplate] <Hashtable>] [[-autoInvoiceFlag] <Boolean>] 
[[-invoiceProratedAdditionsFlag] <Boolean>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
New-CWMAgreementTypes -Condition 'company/identifier="Company1" and status = "Open"'
```

This will create a New Agreement Type.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES
Author: Chris Taylor Date: 1/7/2019

## RELATED LINKS
[https://developer.connectwise.com/Products/ConnectWise_PSA/REST#/AgreementTypes/postFinanceAgreementsTypes](https://developer.connectwise.com/Products/ConnectWise_PSA/REST#/AgreementTypes/postFinanceAgreementsTypes)