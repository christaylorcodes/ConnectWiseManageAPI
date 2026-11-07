---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Set-CWMCompanyServiceTemplate

## SYNOPSIS
Replaces a company service template in ConnectWise Manage.

## SYNTAX

```
Set-CWMCompanyServiceTemplate [-parentId] <Int32> [-id] <Int32> [-name] <String> [-board] <Hashtable>
 [[-type] <Hashtable>] [[-item] <Hashtable>] [[-subtype] <Hashtable>] [[-serviceLocation] <Hashtable>]
 [-status] <Hashtable> [[-source] <Hashtable>] [[-priority] <Hashtable>] [[-team] <Hashtable>]
 [[-company] <Hashtable>] [[-contact] <Hashtable>] [[-site] <Hashtable>] [[-assignedNotifyFlag] <Boolean>]
 [[-location] <Hashtable>] [[-department] <Hashtable>] [-summary] <String> [[-problem] <String>]
 [[-hoursBudget] <Double>] [[-hourlyRate] <Double>] [[-internalAnalysis] <String>] [[-resolution] <String>]
 [[-timeBillableFlag] <Boolean>] [[-expenseBillableFlag] <Boolean>] [[-productBillableFlag] <Boolean>]
 [[-purchaseOrderNumber] <String>] [[-reference] <String>] [[-estimatedExpenseCost] <Double>]
 [[-estimatedExpenseRevenue] <Double>] [[-estimatedProductCost] <Double>] [[-estimatedProductRevenue] <Double>]
 [[-estimatedTimeCost] <Double>] [[-estimatedTimeRevenue] <Double>] [[-billComplete_Flag] <Boolean>]
 [[-billServiceSeparatelyFlag] <Boolean>] [[-billingAmount] <Double>]
 [[-billUnapprovedTimeAndExpensesFlag] <Boolean>] [[-overrideFlag] <Boolean>] [[-timeInvoiceFlag] <Boolean>]
 [[-expenseInvoiceFlag] <Boolean>] [[-productInvoiceFlag] <Boolean>] [[-agreement] <Hashtable>]
 [[-workRole] <Hashtable>] [[-workType] <Hashtable>] [[-billTime] <String>] [[-billExpenses] <String>]
 [[-billProducts] <String>] [[-billingMethod] <String>] [[-severity] <String>] [[-impact] <String>]
 [[-assignedBy] <Hashtable>] [[-scheduleDaysBefore] <Int32>] [[-serviceDaysBefore] <Int32>]
 [[-attachScheduleToNewServiceFlag] <Boolean>] [[-templateFlag] <Boolean>] [[-emailContactFlag] <Boolean>]
 [[-emailResourceFlag] <Boolean>] [[-emailCCFlag] <Boolean>] [[-emailCC] <String>]
 [[-restrictDownpaymentFlag] <Boolean>] [[-_info] <Hashtable>] [[-connectWiseId] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces a whole company service template (PUT).
Properties that are not specified may be
cleared by the API.
To change only some properties, use Update-CWMCompanyServiceTemplate.

This function calls the ConnectWise Manage API endpoint: PUT /company/companies/{parentId}/serviceTemplates/{id}

## EXAMPLES

### EXAMPLE 1
```
$Template = @{
    parentId = 250
    id       = 15
    name     = 'Monthly maintenance'
    summary  = 'Monthly maintenance'
    board    = @{ id = 1 }
    status   = @{ id = 16 }
    company  = @{ id = 250 }
}
Set-CWMCompanyServiceTemplate @Template
```

Replaces service template 15 of company 250.

## PARAMETERS

### -parentId
The ID of the company (required).
Alias: companyId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of the company service template to replace (required).
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
The name of the template (required, 1-100 characters).

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

### -board
The service board reference (required), e.g.
@{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
The board type reference, e.g.
@{ id = 5 }.

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

### -item
The board item reference, e.g.
@{ id = 7 }.

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

### -subtype
The board subtype reference, e.g.
@{ id = 6 }.

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

### -serviceLocation
The service location reference, e.g.
@{ id = 2 }.

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

### -status
The board status reference (required), e.g.
@{ id = 16 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -source
The source reference, e.g.
@{ id = 2 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
The priority reference, e.g.
@{ id = 4 }.

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

### -team
The service team reference, e.g.
@{ id = 3 }.

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

### -company
The company reference, e.g.
@{ id = 250 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
The contact reference, e.g.
@{ id = 12 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -site
The company site reference, e.g.
@{ id = 9 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assignedNotifyFlag
Sets assignedNotifyFlag.

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

### -location
The location reference, e.g.
@{ id = 1 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -department
The department reference, e.g.
@{ id = 1 }.

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

### -summary
The summary of the tickets created from the template (required, 1-100 characters).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -problem
The problem description (initial description) text.

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

### -hoursBudget
The budgeted hours.

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

### -hourlyRate
The hourly rate.

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

### -internalAnalysis
The internal analysis text.

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

### -resolution
The resolution text.

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

### -timeBillableFlag
Sets timeBillableFlag.

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

### -expenseBillableFlag
Sets expenseBillableFlag.

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

### -productBillableFlag
Sets productBillableFlag.

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

### -purchaseOrderNumber
The purchase order number (1-25 characters).

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

### -reference
The reference (1-50 characters).

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

### -estimatedExpenseCost
The estimated expense cost.

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

### -estimatedExpenseRevenue
The estimated expense revenue.

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

### -estimatedProductCost
The estimated product cost.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedProductRevenue
The estimated product revenue.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeCost
The estimated time cost.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -estimatedTimeRevenue
The estimated time revenue.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billComplete_Flag
Sets billComplete_Flag.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -billServiceSeparatelyFlag
Sets billServiceSeparatelyFlag.

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

### -billingAmount
The billing amount.

```yaml
Type: System.Double
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -billUnapprovedTimeAndExpensesFlag
Sets billUnapprovedTimeAndExpensesFlag.

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

### -overrideFlag
Sets overrideFlag.

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

### -timeInvoiceFlag
Sets timeInvoiceFlag.

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

### -expenseInvoiceFlag
Sets expenseInvoiceFlag.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -productInvoiceFlag
Sets productInvoiceFlag.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -agreement
The agreement reference, e.g.
@{ id = 30 }.

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

### -workRole
The work role reference, e.g.
@{ id = 2 }.

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

### -workType
The work type reference, e.g.
@{ id = 1 }.

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

### -billTime
How time is billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

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

### -billExpenses
How expenses are billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

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

### -billProducts
How products are billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -billingMethod
The billing method: 'ActualRates', 'FixedFee', 'NotToExceed' or 'OverrideRate'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -severity
The severity: 'Low', 'Medium' or 'High'.

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

### -impact
The impact: 'Low', 'Medium' or 'High'.

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

### -assignedBy
The member reference for assignedBy, e.g.
@{ id = 140 }.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 53
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scheduleDaysBefore
Sets scheduleDaysBefore.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 54
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceDaysBefore
Sets serviceDaysBefore.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 55
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -attachScheduleToNewServiceFlag
Sets attachScheduleToNewServiceFlag.

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

### -templateFlag
Sets templateFlag.

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

### -emailContactFlag
Sets emailContactFlag.

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

### -emailResourceFlag
Sets emailResourceFlag.

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

### -emailCCFlag
Sets emailCCFlag.

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

### -emailCC
The CC email address(es) (1-1000 characters).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 61
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -restrictDownpaymentFlag
Sets restrictDownpaymentFlag.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 62
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
The _info metadata object, passed through to the request body.

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

### -connectWiseId
Sets connectWiseId.

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

### PSCustomObject
### Returns the replaced company service template.
## NOTES
Endpoint: PUT /company/companies/{parentId}/serviceTemplates/{id}

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMCompanyServiceTemplate]()

[Update-CWMCompanyServiceTemplate]()

[Invoke-CWMSetMaster]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

