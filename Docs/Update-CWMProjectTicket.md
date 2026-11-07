---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Update-CWMProjectTicket

## SYNOPSIS
Updates a project ticket in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMProjectTicket [-id] <Int32> [-Operation] <String> [-Path] <String> [[-Value] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMProjectTicket [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
You can execute a patch method against a Manage project ticket.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /project/tickets/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMProjectTicket -id 123 -Operation replace -Path 'board/id' -Value 1
```

Moves project ticket 123 to board 1.

### EXAMPLE 2
```
Update-CWMProjectTicket 123 replace board/id 1
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMProjectTicket -id 123 -PatchOperations @(
    @{ op = 'replace'; path = 'summary'; value = 'Configure backups' }
    @{ op = 'replace'; path = 'status'; value = @{ id = 5 } }
)
```

Changes the summary and status of project ticket 123 in one request.

## PARAMETERS

### -id
The ID of the project ticket to update.
Alias: ticketID

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ticketID

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Operation
The patch operation to perform: 'add', 'replace' or 'remove'.

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
The property to change, for example 'board/id'.

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
The new value for the property.
Required for 'add' and 'replace'; not needed for 'remove'.
Use -Value $null to set a property to null.

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

### PSCustomObject
### Returns the updated project ticket.
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

