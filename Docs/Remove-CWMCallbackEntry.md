---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMCallbackEntry

## SYNOPSIS
This function will remove a Callback entry from Manage.

## SYNTAX

```
Remove-CWMCallbackEntry [-ID] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-CWMCallbackEntry -ID 123
```

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
The ID of the Callback you want to delete.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 6/27/2019

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks~1{id}/delete](https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks~1{id}/delete)

