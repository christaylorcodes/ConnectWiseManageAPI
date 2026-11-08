---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Update-CWMBoardItemAssociation

## SYNOPSIS
Updates the association between a service board item and a type in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMBoardItemAssociation [-parentId] <Int32> [-itemId] <Int32> [-typeId] <Int32> [-Operation] <String>
 [-Path] <String> [[-Value] <Object>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Bulk
```
Update-CWMBoardItemAssociation [-parentId] <Int32> [-itemId] <Int32> [-typeId] <Int32>
 -PatchOperations <Object[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing service board item association.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /service/boards/{parentId}/items/{itemId}/associations/{typeId}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMBoardItemAssociation -parentId 1 -itemId 20 -typeId 30 -Operation replace -Path 'addAllSubTypesFlag' -Value $true
```

Associates all sub types with item 20 and type 30 of board 1.

### EXAMPLE 2
```
Update-CWMBoardItemAssociation 1 20 30 replace addAllSubTypesFlag $true
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMBoardItemAssociation -parentId 1 -itemId 20 -typeId 30 -PatchOperations @(
    @{ op = 'replace'; path = 'addAllSubTypesFlag'; value = $true }
)
```

Sends the same change with -PatchOperations.
Add more operations to the array to change several properties in one request.

## PARAMETERS

### -parentId
The ID of the service board.
Alias: boardId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: boardId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -itemId
The ID of the board item.
Alias: id

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: id

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -typeId
The ID of the service type of the association to update.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The property to change, for example 'addAllSubTypesFlag'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 5
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
Position: 6
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
### Returns the updated service board item association.
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

