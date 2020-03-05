---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMAuditTrail

## SYNOPSIS
This function will get the audit trail of an item in ConnectWise.

## SYNTAX

```
Get-CWMAuditTrail [-Type] <Object> [-ID] <String> [[-deviceIdentifier] <Object>] [[-childConditions] <String>]
 [[-page] <Int32>] [[-pageSize] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This function will get the audit trail of an item in ConnectWise.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-CWMAuditTrail
```

Will return the audit trail

## PARAMETERS

### -ID
The id the the item you want the audit trail of.

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

### -Type
Ticket, ProductCatalog, Configuration, PurchaseOrder, Expense

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: Ticket, ProductCatalog, Configuration, PurchaseOrder, Expense

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childConditions
{{ Fill childConditions Description }}

```yaml
Type: String
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
Type: Object
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
Type: Int32
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
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
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

[https://developer.connectwise.com/products/manage/rest?a=System&e=AuditTrail&o=GET](https://developer.connectwise.com/products/manage/rest?a=System&e=AuditTrail&o=GET)

