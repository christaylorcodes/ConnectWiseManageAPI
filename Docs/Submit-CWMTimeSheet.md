---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Submit-CWMTimeSheet

## SYNOPSIS
This function will submit a time sheet for approval.

## SYNTAX

```
Submit-CWMTimeSheet [[-ID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Submit-CWMTimeSheet -ID 1
```

Will submit time sheet 1

## PARAMETERS

### -ID
The ID of the time sheet you want to submit.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 1/7/2019

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=Time&e=TimeSheets&o=SUBMIT](https://developer.connectwise.com/manage/rest?a=Time&e=TimeSheets&o=SUBMIT)

