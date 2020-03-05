---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMCallbackEntry

## SYNOPSIS
This will update a Callback entry.

## SYNTAX

```
Update-CWMCallbackEntry [-ID] <Int32> [-Operation] <String> [-Path] <String> [-Value] <Object> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
$UpdateParam = @{
```

ID = 1     Operation = 'replace'     Path = 'url'     Value = $NewURL } Update-CWMCallbackEntry @UpdateParam Will replace the url on callback 1

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
The ID of the Callback that you are updating.

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

### -Operation
What you are doing with the value.
replace, add, remove

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: add, replace, remove

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The value that you want to perform the operation on.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The value of path.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks~1{id}/patch](https://marketplace.connectwise.com/docs/redoc/manage/system.html#tag/CallbackEntries/paths/~1system~1callbacks~1{id}/patch)

