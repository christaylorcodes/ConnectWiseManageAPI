---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# ConvertTo-CWMTime

## SYNOPSIS
Converts \[datetime\] to the time format used in condition queries.

## SYNTAX

```
ConvertTo-CWMTime [[-Date] <DateTime[]>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
This will convert an input to a universal date time object then output in a format used by the ConnectWise Manage API conditions parameters.

## EXAMPLES

### EXAMPLE 1
```powershell
ConvertTo-CWMTime $(Get-Date).AddDays(1)
```

Will output tomorrows date.

## PARAMETERS

### -Date
Date used in conversion.

```yaml
Type: DateTime[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Raw
{{ Fill Raw Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

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
Author: Chris Taylor Date: 10/16/2018

## RELATED LINKS
