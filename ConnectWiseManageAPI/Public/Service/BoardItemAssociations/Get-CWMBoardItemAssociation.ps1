function Get-CWMBoardItemAssociation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias ('boardId')]
        [int]$grandParentId,
        [Parameter(Mandatory = $true)]
        [Alias ('itemId')]
        [int]$parentId,
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

    $Endpoint = "/service/boards/$grandParentId/items/$parentId/associations"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}