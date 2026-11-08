---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMReportColumn

## SYNOPSIS
Gets the column definitions of a ConnectWise Manage report.

## SYNTAX

```
Get-CWMReportColumn [-Report] <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves the columns available on a ConnectWise Manage report and returns them as a
single ordered dictionary of column name -\> column definition.

The API returns the column definitions as one or more objects whose properties are the
column names.
Every property of every returned object is added to the dictionary, in the
order the API returned them.
If the API returns nothing, the function returns nothing.

This function calls the ConnectWise Manage API endpoint: GET /system/reports/{reportName}/columns

## EXAMPLES

### EXAMPLE 1
```
Get-CWMReportColumn -Report 'Service'
```

Returns an ordered dictionary of the columns of the 'Service' report, keyed by column name.

### EXAMPLE 2
```
$Columns = Get-CWMReportColumn -Report 'Service'
$Columns.Keys
```

Lists only the column names of the 'Service' report.

## PARAMETERS

### -Report
The name of the report to get the columns of (as listed by Get-CWMReport).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Specialized.OrderedDictionary
## NOTES
The output is a System.Collections.Specialized.OrderedDictionary, so columns keep the
order the API returned them in.
Use it like a hashtable ($Columns\['id'\], $Columns.Keys).

## RELATED LINKS

[Get-CWMReport]()

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST](https://developer.connectwise.com/Products/ConnectWise_PSA/REST)

