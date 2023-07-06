---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/products/manage/rest?a=Service&e=Tickets&o=DELETE
schema: 2.0.0
---

# Remove-CWMTicketConfiguration

## SYNOPSIS
Remove a configuration from a ticket

## SYNTAX

```
Remove-CWMTicketConfiguration [-id] <Int32> [-parentId] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove a configuration from a ticket

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-CWMTicketConfiguration -partentId 123 -id 1
```

Removes the config 1 from the ticket 123

## PARAMETERS

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### -id
The id of the configuration to remove

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: configurationId

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
The id of the ticket to remove the configuration from

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ticketId

Required: True
Position: 1
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

## RELATED LINKS
