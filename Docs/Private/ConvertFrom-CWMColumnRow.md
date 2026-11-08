---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# ConvertFrom-CWMColumnRow

## SYNOPSIS
Converts column/row report data from ConnectWise Manage to a table.

## SYNTAX

```
ConvertFrom-CWMColumnRow [[-Data] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Converts a report response with column_definitions and row_values (as returned by
GET /system/reports/{reportName}) to a System.Data.DataTable, so each row becomes an object with one
property per column.
Internal helper used by Get-CWMReport; no API call is made.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-CWMColumnRow -Data $ReportResponse
```

Returns the rows of the report response as objects.

## PARAMETERS

### -Data
The report response object, with column_definitions and row_values properties.

```yaml
Type: System.Object
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
