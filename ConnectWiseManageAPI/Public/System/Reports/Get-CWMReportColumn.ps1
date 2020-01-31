function Get-CWMReportColumn {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Report
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/reports/$($Report)/columns"

    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
    $Result | Foreach-Object { $_ } |  ForEach-Object {
        $HashTable.Add($_.PSObject.Properties.Name, $_.PSObject.Properties.Value)
    }
    return $HashTable
}
