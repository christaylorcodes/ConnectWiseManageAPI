---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMTicketConfiguration

## SYNOPSIS
This function will list configs attached to a ticket.

## SYNTAX

```
Get-CWMTicketConfiguration [-TicketID] <Int32> [[-page] <Int32>] [[-pageSize] <Int32>] [-all]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Get-CWMTicketConfiguration -TicketID 1
```

Will return all configurations for ticket 1

## PARAMETERS

### -TicketID
The id of the ticket you want to retrieve configurations for.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Return all results

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
Position: 1
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
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 10/22/2018

## RELATED LINKS

[https://developer.connectwise.com/products/manage/rest?a=Service&e=Tickets&o=CONFIGURATIONS](https://developer.connectwise.com/products/manage/rest?a=Service&e=Tickets&o=CONFIGURATIONS)

