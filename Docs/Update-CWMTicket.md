---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Tickets
schema: 2.0.0
---

# Update-CWMTicket

## SYNOPSIS
Updates an existing service ticket in ConnectWise Manage using patch operations.

## SYNTAX

### Single (Default)
```
Update-CWMTicket [-id] <Int32> [-Operation] <String> [-Path] <String> [[-Value] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMTicket [-id] <Int32> -PatchOperations <Object[]> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Modifies ticket properties using JSON Patch operations (add, replace, remove).
This follows the RFC 6902 JSON Patch standard used by ConnectWise Manage API.

Use -Operation, -Path and -Value for one change, or -PatchOperations for
several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /service/tickets/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMTicket -id 12345 -Operation 'replace' -Path 'summary' -Value 'Updated ticket title'
```

Updates the ticket summary.

### EXAMPLE 2
```
Update-CWMTicket -id 12345 -Operation 'replace' -Path 'status' -Value @{ id = 10 }
```

Changes the ticket status using a status ID reference.

### EXAMPLE 3
```
Update-CWMTicket -id 12345 -Operation 'replace' -Path 'priority' -Value @{ id = 5 }
```

Updates the ticket priority.

### EXAMPLE 4
```
Update-CWMTicket -id 12345 -PatchOperations @(
    @{ op = 'replace'; path = 'status'; value = @{ id = 10 } }
    @{ op = 'replace'; path = 'priority'; value = @{ id = 3 } }
    @{ op = 'replace'; path = 'owner'; value = @{ id = 50 } }
    @{ op = 'remove'; path = 'contact' }
)
```

Changes the status, priority and owner and clears the contact of ticket 12345 in one request.

## PARAMETERS

### -id
The ticket ID to update (required).
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

### -Operation
The patch operation to perform (required).
Valid values: 'add', 'replace', 'remove'
- replace: Modifies an existing field value
- add: Adds a value to an array or creates a field
- remove: Removes a field value

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The field path to modify (required).
Examples: 'status', 'summary', 'priority', 'owner'
For nested fields use slash notation: 'customFields/0/value'

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The new value for the field (required for 'add' and 'replace'; not needed for 'remove').
Use -Value $null to set a field to null.
Type depends on the field being updated:
- References (status, priority, etc.): @{ id = 123 }
- Strings: "text value"
- Numbers: 42
- Booleans: $true or $false

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PatchOperations
Several patch operations to apply in one request.
Each is a hashtable or PSCustomObject with
op, path and (except for 'remove') value.
'value' is left out of 'remove' operations.

```yaml
Type: System.Object[]
Parameter Sets: Bulk
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

Common Update Paths:
- 'summary' - Ticket title
- 'status' - Ticket status (hashtable: @{ id = X })
- 'priority' - Ticket priority (hashtable: @{ id = X })
- 'owner' - Assigned owner (hashtable: @{ id = X })
- 'company' - Company (hashtable: @{ id = X })
- 'board' - Service board (hashtable: @{ id = X })
- 'type' - Ticket type (hashtable: @{ id = X })

Hashtable Reference Format:
Most reference fields require: @{ id = \<number\> }
Some also accept: @{ id = \<number\>; name = "Name" }

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Tickets](https://developer.connectwise.com/manage/rest#/Tickets)

[Get-CWMTicket]()

[New-CWMTicket]()

[Remove-CWMTicket]()

