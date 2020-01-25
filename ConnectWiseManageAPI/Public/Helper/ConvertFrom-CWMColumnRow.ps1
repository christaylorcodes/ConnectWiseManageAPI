function ConvertFrom-CWMColumnRow {
    [CmdletBinding()]
    param(
        $Data
    )
    $dataTable = New-Object System.Data.DataTable

    $Data.column_definitions | ForEach-Object {
        if (!$dataTable.Columns.Contains($($_ | Get-Member | Where-Object {$_.memberType -eq 'noteproperty'}).Name)){
            $dataTable.Columns.Add(($_ | Get-Member | Where-Object {$_.memberType -eq 'noteproperty'}).Name)
        }
    } | Out-Null
    $Data.row_values | ForEach-Object {
        $dataTable.rows.Add($_)
    } | Out-Null

    if($dataTable){Return $dataTable}
    Return $False
}