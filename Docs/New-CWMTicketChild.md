---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTicketChild

## SYNOPSIS
Bundles or merges child tickets into a parent service ticket.

## SYNTAX

### Bundle (Default)
```
New-CWMTicketChild -ParentTicketID <Int32> -ChildTicketIDs <Int32[]> -OperationType <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Merge
```
New-CWMTicketChild -ParentTicketID <Int32> -ChildTicketIDs <Int32[]> -StatusID <Int32> [-StatusName <String>]
 [-Sort <Int32>] [-_info <Hashtable>] -OperationType <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Combines one or more service tickets with a parent ticket, using one of the two
ConnectWise Manage ticket-combining operations:

- Bundle: attaches the child tickets to the parent.
The children stay as separate
  tickets, linked to the parent (their parentTicketId is set), and are closed when the
  parent is closed.
  Calls: POST /service/tickets/{parentId}/attachChildren
  Body:  { "childTicketIds": \[ ...
\] }

- Merge: absorbs the child tickets into the parent.
The merged tickets are set to the
  status you supply (usually a closed status on their board).
  Calls: POST /service/tickets/{parentId}/merge
  Body:  { "mergeTicketIds": \[ ...
\], "status": { "id": ..., "name": ..., "sort": ..., "_info": { ...
} } }

The request is sent through Invoke-CWMNewMaster, which serializes the body with enough
depth that the nested status object (including _info) stays a JSON object.

The API rejects invalid combinations with a descriptive error, for example when the
supplied parent is itself a child of another ticket.

Unbundling: to detach bundled child tickets from the parent again, use
Remove-CWMTicketChild (POST /service/tickets/{parentId}/detachChildren).

## EXAMPLES

### EXAMPLE 1
```
New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061 -OperationType Bundle
```

Bundles ticket 143061 under ticket 141378.

### EXAMPLE 2
```
New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062, 143063 -OperationType Bundle -WhatIf
```

Shows the attachChildren request that would bundle three tickets under 141378, without sending it.

### EXAMPLE 3
```
$Closed = Get-CWMBoardStatus -parentId 1 -condition "name='Closed'"
New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062 -OperationType Merge -StatusID $Closed.id -StatusName $Closed.name
```

Merges tickets 143061 and 143062 into ticket 141378 and sets the merged tickets to the
'Closed' status of service board 1.

### EXAMPLE 4
```
Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061
```

Unbundles ticket 143061 from ticket 141378 again (see Remove-CWMTicketChild).

## PARAMETERS

### -ParentTicketID
The ID of the parent ticket that the child tickets are bundled into or merged into.
Required.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChildTicketIDs
One or more IDs of the tickets to bundle or merge into the parent ticket.
Required.

```yaml
Type: System.Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusID
Merge only.
The ID of the status that the merged child tickets are set to.
Required for a merge.
The status must be valid on the child tickets' board.
Find status IDs with Get-CWMBoardStatus.

```yaml
Type: System.Int32
Parameter Sets: Merge
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusName
Merge only.
Optional name of the status given in -StatusID.
Sent as status.name.

```yaml
Type: System.String
Parameter Sets: Merge
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sort
Merge only.
Optional sort order of the status.
Sent as status.sort.

```yaml
Type: System.Int32
Parameter Sets: Merge
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -_info
Merge only.
Optional _info hashtable for the status reference.
Sent as status._info,
as a nested JSON object.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: Merge
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OperationType
The operation to perform.
Required.
- 'Bundle' attaches the children to the parent (attachChildren).
- 'Merge' merges the children into the parent (merge); also requires -StatusID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
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
Date: 2023-10-11

API Endpoints:
- POST /service/tickets/{parentId}/attachChildren (body model TicketBundle: childTicketIds)
- POST /service/tickets/{parentId}/merge (body model TicketMerge: mergeTicketIds, status)

Both endpoints return a success response object.

-OperationType must match the other parameters: -StatusID, -StatusName, -Sort and -_info
are only valid with 'Merge', and 'Merge' requires -StatusID.

Supports -WhatIf and -Confirm (handled by Invoke-CWMNewMaster).

## RELATED LINKS

[Remove-CWMTicketChild]()

[Get-CWMTicket]()

[Get-CWMBoardStatus]()

[https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdAttachChildren](https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdAttachChildren)

[https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdMerge](https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdMerge)

