---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# New-CWMOpportunityForecast

## SYNOPSIS
Creates the forecast of an opportunity.

## SYNTAX

```
New-CWMOpportunityForecast [-parentId] <Int32> [[-id] <Int32>] [[-forecastItems] <Array>]
 [[-productRevenue] <Hashtable>] [[-serviceRevenue] <Hashtable>] [[-agreementRevenue] <Hashtable>]
 [[-timeRevenue] <Hashtable>] [[-expenseRevenue] <Hashtable>] [[-forecastRevenueTotals] <Hashtable>]
 [[-inclusiveRevenueTotals] <Hashtable>] [[-recurringTotal] <Decimal>] [[-wonRevenue] <Hashtable>]
 [[-lostRevenue] <Hashtable>] [[-openRevenue] <Hashtable>] [[-otherRevenue1] <Hashtable>]
 [[-otherRevenue2] <Hashtable>] [[-salesTaxRevenue] <Decimal>] [[-forecastTotalWithTaxes] <Decimal>]
 [[-expectedProbability] <Decimal>] [[-taxCode] <Hashtable>] [[-billingTerms] <Hashtable>]
 [[-currency] <Hashtable>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a forecast on an opportunity in ConnectWise Manage.
Calls POST
/sales/opportunities/{parentId}/forecast; only the parameters you pass are sent in the request body.

## EXAMPLES

### EXAMPLE 1
```
New-CWMOpportunityForecast -parentId 75 -forecastItems @(@{ forecastDescription = 'Firewall'; opportunity = @{ id = 75 }; status = @{ id = 1 }; forecastType = 'Product'; revenue = 2500 })
```

Adds a product forecast item with 2500 revenue to opportunity 75.

## PARAMETERS

### -parentId
The id of the opportunity to add the forecast to.
Alias: opportunityId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: opportunityId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id property of the request body.
Usually left unset; ConnectWise Manage assigns the id of a new
record.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -forecastItems
Forecast items.
An array of hashtables with the properties of the API's ForecastItem object.

```yaml
Type: System.Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -productRevenue
Product revenue reference, for example @{ id = 1 }.

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

### -serviceRevenue
Service revenue reference, for example @{ id = 1 }.

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

### -agreementRevenue
Agreement revenue reference, for example @{ id = 1 }.

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

### -timeRevenue
Time revenue reference, for example @{ id = 1 }.

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

### -expenseRevenue
Expense revenue reference, for example @{ id = 1 }.

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

### -forecastRevenueTotals
Forecast revenue totals reference, for example @{ id = 1 }.

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

### -inclusiveRevenueTotals
Inclusive revenue totals reference, for example @{ id = 1 }.

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

### -recurringTotal
Recurring total.
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

### -wonRevenue
Won revenue reference, for example @{ id = 1 }.

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

### -lostRevenue
Lost revenue reference, for example @{ id = 1 }.

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

### -openRevenue
Open revenue reference, for example @{ id = 1 }.

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

### -otherRevenue1
Other revenue 1 reference, for example @{ id = 1 }.

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

### -otherRevenue2
Other revenue 2 reference, for example @{ id = 1 }.

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

### -salesTaxRevenue
Sales tax revenue.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -forecastTotalWithTaxes
Forecast total with taxes.
A number.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -expectedProbability
Expected probability.
An integer.

```yaml
Type: System.Decimal
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: 0
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
Position: 20
Default value: None
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
Position: 21
Default value: None
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
Position: 22
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
Position: 23
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

