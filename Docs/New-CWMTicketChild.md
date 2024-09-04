---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://christaylor.codes
schema: 2.0.0
---

# New-CWMTicketChild

## SYNOPSIS
This function will create a new ticket.

## SYNTAX

### Bundle (Default)
```
New-CWMTicketChild [-ParentTicketID <Int32>] [-ChildTicketIDs <Int32[]>] -OperationType <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Merge
```
New-CWMTicketChild [-ParentTicketID <Int32>] [-ChildTicketIDs <Int32[]>] -StatusID <Int32> [-Sort <Int32>]
 [-_info <Hashtable>] -OperationType <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The `New-CWMTicketChild` function allows users to either bundle or merge tickets in ConnectWise Manage.
Bundling creates a relationship between tickets without changing their properties, while merging combines tickets 
and requires specifying additional parameters for the merged tickets, such as the status ID - which must be a closed status.

## EXAMPLES

### EXAMPLE 1

```powershell
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678 -OperationType Bundle
```

This example demonstrates how to bundle a single child ticket (ID: 5678) to a parent ticket (ID: 1234).

### EXAMPLE 2
```powershell
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678, 91011 -OperationType Bundle
```

This example demonstrates how to bundle multiple child tickets (IDs: 5678, 91011) to a parent ticket (ID: 1234).

### EXAMPLE 3
```powershell
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678 -OperationType Merge -StatusID 1 -StatusName "Closed" -Sort 0 -_info @{ additionalProp1 = "value1"; additionalProp2 = "value2" }
```

This example demonstrates how to merge a single child ticket (ID: 5678) into a parent ticket (ID: 1234) with specified status details.

### EXAMPLE 4
```powershell
New-CWMTicketChild -ParentTicketID 1234 -ChildTicketIDs 5678, 91011 -OperationType Merge -StatusID 1 -StatusName "Closed" -Sort 0 -_info @{ additionalProp1 = "value1"; additionalProp2 = "value2" }
```

This example demonstrates how to merge multiple child tickets (IDs: 5678, 91011) into a parent ticket (ID: 1234) with specified status details.

## PARAMETERS

### -ChildTicketIDs
An array of IDs for the child tickets that will be either bundled or merged with the parent ticket.


```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -OperationType
Specifies the type of operation to perform: "Bundle" or "Merge".


```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Bundle, Merge

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ParentTicketID
The ID of the parent ticket.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sort
{{ Fill Sort Description }}

```yaml
Type: Int32
Parameter Sets: Merge
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusID
The status ID for the merged ticket. Only used when the OperationType is set to "Merge".

```yaml
Type: Int32
Parameter Sets: Merge
Aliases:

Required: True
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
Parameter Sets: Merge
Aliases:

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
Author: Chris Taylor Date: 8/22/2018

## RELATED LINKS
