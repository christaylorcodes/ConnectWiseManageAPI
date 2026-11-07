---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# ConvertTo-CWMTime

## SYNOPSIS
Converts a DateTime to the date format ConnectWise Manage uses.

## SYNTAX

```
ConvertTo-CWMTime [[-Date] <DateTime[]>] [-Raw] [<CommonParameters>]
```

## DESCRIPTION
Converts one or more \[datetime\] values to UTC and formats them as yyyy-MM-ddTHH:mm:ssZ in square
brackets, the format used in condition strings.
With -Raw the brackets are left out, the format used in
request bodies.
No API call is made.

## EXAMPLES

### EXAMPLE 1
```
$(ConvertTo-CWMTime (Get-Date).AddDays(-7))" -all
```

Retrieves the tickets entered in the last seven days.

### EXAMPLE 2
```
New-CWMTimeEntry -chargeToType 'ServiceTicket' -chargeToId 1234 -timeStart (ConvertTo-CWMTime (Get-Date).AddHours(-1) -Raw)
```

Uses -Raw to send a date in a request body.

## PARAMETERS

### -Date
One or more dates to convert.
Accepts pipeline input.

```yaml
Type: System.DateTime[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Raw
Return the date without the surrounding square brackets.

```yaml
Type: System.Management.Automation.SwitchParameter
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

### System.String
## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

