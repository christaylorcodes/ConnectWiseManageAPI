---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Tickets
schema: 2.0.0
---

# Remove-CWMTicket

## SYNOPSIS
Deletes a service ticket from ConnectWise Manage.

## SYNTAX

```
Remove-CWMTicket [-id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Permanently removes a service ticket by ID.
This action cannot be undone.

ConnectWise Manage decides what happens to related records (notes, time entries,
configurations) and may refuse the delete, for example when time has been entered.
Consider closing tickets instead of deleting them to preserve history.

ConfirmImpact is Medium, so with the default $ConfirmPreference (High) there is no
confirmation prompt: the ticket is deleted immediately.
Use -Confirm to be prompted
or -WhatIf to preview.

This function calls the ConnectWise Manage API endpoint: DELETE /service/tickets/{id}

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMTicket -id 12345
```

Deletes ticket with ID 12345.

### EXAMPLE 2
```
Remove-CWMTicket -id 12345 -Confirm
```

Prompts for confirmation before deleting the ticket.

### EXAMPLE 3
```
Remove-CWMTicket -id 12345 -WhatIf
```

Shows what would happen without actually deleting the ticket.

### EXAMPLE 4
```
# Delete multiple tickets
$oldTicketIds = 100, 101, 102
$oldTicketIds | ForEach-Object { Remove-CWMTicket -id $_ }
```

Deletes multiple tickets.
No prompt is shown by default; add -Confirm to be prompted for each one.

## PARAMETERS

### -id
The ticket ID to delete (required).
Alias: ticketId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ticketId

Required: True
Position: 1
Default value: 0
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

Important:
- This action is permanent and cannot be undone
- ConnectWise Manage may reject the delete (for example when time entries exist)
- Consider closing tickets instead to preserve history
- Supports -WhatIf and -Confirm (no prompt by default)

Alternative to Deletion:
Instead of deleting, move the ticket to a closed status on its board:
$Closed = Get-CWMBoardStatus -serviceBoardId 1 -condition "closedStatus=true" | Select-Object -First 1
Update-CWMTicket -id 123 -Operation 'replace' -Path 'status' -Value @{ id = $Closed.id }

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Tickets](https://developer.connectwise.com/manage/rest#/Tickets)

[Get-CWMTicket]()

[New-CWMTicket]()

[Update-CWMTicket]()

