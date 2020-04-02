function Get-CWMCallbackEntry {
    [CmdletBinding()]
    param(
        [string]$Condition,
        $orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )
    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/callbacks"
    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}
