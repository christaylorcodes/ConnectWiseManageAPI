---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMTicketChild

## SYNOPSIS
Detaches (unbundles) child tickets from a parent service ticket.

## SYNTAX

```
Remove-CWMTicketChild [-ParentTicketID] <Int32> [-ChildTicketIDs] <Int32[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reverses a bundle made with New-CWMTicketChild -OperationType Bundle: the child tickets
are detached from the parent and become independent tickets again.

Calls: POST /service/tickets/{parentId}/detachChildren
Body:  { "childTicketIds": \[ ...
\] }

The endpoint is a POST (not a DELETE), so the request is sent through Invoke-CWMNewMaster.
It takes the same TicketBundle body as attachChildren.
The API has no endpoint that reverses
a merge (New-CWMTicketChild -OperationType Merge).

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061
```

Detaches ticket 143061 from its parent ticket 141378.

### EXAMPLE 2
```
Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062 -WhatIf
```

Shows the detachChildren request that would detach two tickets from 141378, without sending it.

## PARAMETERS

### -ParentTicketID
The ID of the parent ticket that the child tickets are bundled under.
Required.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChildTicketIDs
One or more IDs of the child tickets to detach from the parent ticket.
Required.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Author: Chris Taylor

API Endpoint:
- POST /service/tickets/{parentId}/detachChildren (body model TicketBundle: childTicketIds)

Returns a success response object.

Supports -WhatIf and -Confirm (handled by Invoke-CWMNewMaster).

## RELATED LINKS

[New-CWMTicketChild]()

[Get-CWMTicket]()

[https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdDetachChildren](https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdDetachChildren)

