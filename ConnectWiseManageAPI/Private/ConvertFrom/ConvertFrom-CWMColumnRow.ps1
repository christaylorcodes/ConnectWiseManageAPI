function ConvertFrom-CWMColumnRow {
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