function Get-CWMReportColumn {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Report
    )

    $Endpoint = "/system/reports/$($Report)/columns"

    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    $Result | Foreach-Object { $_ } |  ForEach-Object {
        $HashTable.Add($_.PSObject.Properties.Name, $_.PSObject.Properties.Value)
    }

    $HashTable
}
