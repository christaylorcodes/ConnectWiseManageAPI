---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/products/manage/rest?a=System&e=AuditTrail&o=GET
schema: 2.0.0
---

# Get-CWMAuditTrail

## SYNOPSIS
This function will get the audit trail of an item in ConnectWise.

## SYNTAX

```
Get-CWMAuditTrail [-type] <Object> [-id] <String> [-count] [[-deviceIdentifier] <String>] [-condition <String>]
 [-orderBy <String>] [[-childConditions] <String>] [-customFieldConditions <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [-fields <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
This function will get the audit trail of an item in ConnectWise.

## EXAMPLES

### EXAMPLE 1
```
Get-CWMAuditTrail -Type Ticket -id 1
```

Will return the audit trail for ticket 1

## PARAMETERS

### -childConditions
Allows searching arrays on endpoints that list childConditions under parameters

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

### -deviceIdentifier
?

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

### -page
Used in pagination to cycle through results

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
Number of results returned per page (Defaults to 25)

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Return all results

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -condition
This is your search condition to return the results you desire.
Example: \`(contact/name like "Fred%" and closedFlag = false) and dateEntered \> \[2015-12-23T05:53:27Z\] or summary contains "test" AND  summary != "Some Summary"\`

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFieldConditions
Allows searching custom fields when customFieldConditions is listed in the parameters

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Allows you to return a partial response with just the fields listed.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -orderBy
Choose which field to sort the results by, 'field/sub desc' or 'field/sub asc'

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id the the item you want the audit trail of.

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

### -type
Ticket, ProductCatalog, Configuration, PurchaseOrder, Expense

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:
Accepted values: Ticket, ProductCatalog, Configuration, PurchaseOrder, Expense

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Will return the number of objects.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 10/29/2018

No support for forward only pagination at this time.

## RELATED LINKS
