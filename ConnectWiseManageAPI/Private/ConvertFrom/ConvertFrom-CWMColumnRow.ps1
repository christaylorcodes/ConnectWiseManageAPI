<#
.SYNOPSIS
    Converts column/row report data from ConnectWise Manage to a table.

.DESCRIPTION
    Converts a report response with column_definitions and row_values (as returned by
    GET /system/reports/{reportName}) to a System.Data.DataTable, so each row becomes an object with one
    property per column. Internal helper used by Get-CWMReport; no API call is made.

.PARAMETER Data
    The report response object, with column_definitions and row_values properties.

.EXAMPLE
    ConvertFrom-CWMColumnRow -Data $ReportResponse

    Returns the rows of the report response as objects.
#>function ConvertFrom-CWMColumnRow {
    [CmdletBinding()]
    param(
        $Data
    )
    $dataTable = New-Object System.Data.DataTable

    $null = $Data.column_definitions | ForEach-Object {
        if (!$dataTable.Columns.Contains($($_ | Get-Member | Where-Object { $_.memberType -eq 'noteproperty' }).Name)) {
            $dataTable.Columns.Add(($_ | Get-Member | Where-Object { $_.memberType -eq 'noteproperty' }).Name)
        }
    }
    $null = $Data.row_values | ForEach-Object {
        $dataTable.rows.Add($_)
    }
    $dataTable
}