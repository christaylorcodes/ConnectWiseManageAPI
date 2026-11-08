---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# ConvertFrom-CWMTime

## SYNOPSIS
Converts a ConnectWise Manage date string to a DateTime.

## SYNTAX

```
ConvertFrom-CWMTime [[-Date] <String>] [<CommonParameters>]
```

## DESCRIPTION
Converts a date string as used by ConnectWise Manage, with or without the square brackets used in
conditions, to a \[datetime\].
No API call is made.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-CWMTime -Date (Get-CWMTicket -id 1234).dateEntered
```

Converts the dateEntered value of ticket 1234 to a \[datetime\].

## PARAMETERS

### -Date
The date string to convert, in the format yyyy-MM-ddTHH:mm:ssZ, with or without square brackets.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

