function Get-CWMBoardItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$parentId,
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = "/service/boards/$parentId/items"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}