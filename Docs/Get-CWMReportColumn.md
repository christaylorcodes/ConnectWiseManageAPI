---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMReportColumn

## SYNOPSIS
This function will list the columns of the specified report.

## SYNTAX

```
Get-CWMReportColumn [-Report] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Get-CWMReportColumn -Report ServiceNote
```

Will return columns for the ServiceNote report.

## PARAMETERS

### -Report
The name of the report you want the columns for.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 11/12/2018

## RELATED LINKS

[https://developer.connectwise.com/products/manage/rest?a=System&e=Reports&o=COLUMNS](https://developer.connectwise.com/products/manage/rest?a=System&e=Reports&o=COLUMNS)

