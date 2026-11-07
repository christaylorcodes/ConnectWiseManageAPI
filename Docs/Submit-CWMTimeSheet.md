---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Submit-CWMTimeSheet

## SYNOPSIS
Submits a time sheet for approval.

## SYNTAX

```
Submit-CWMTimeSheet [-id] <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Submits a time sheet.
Calls POST /time/sheets/{id}/submit with no body, the same request as
Update-CWMTimeSheet -Submit.

## EXAMPLES

### EXAMPLE 1
```
Submit-CWMTimeSheet -id 88
```

Submits time sheet 88.

## PARAMETERS

### -id
The id of the time sheet to submit.
Alias: sheetId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: sheetId

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

## RELATED LINKS

[Update-CWMTimeSheet]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

