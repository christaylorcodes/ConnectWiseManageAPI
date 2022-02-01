function Get-CWMBoardStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('serviceBoardId')]
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

    $Endpoint = "/service/boards/$($parentId)/statuses"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}