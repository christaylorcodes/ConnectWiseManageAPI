function Get-CWMBoardStatusNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$grandparentId,
        [Alias('statusId')]
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

    $Endpoint = "/service/boards/$($grandparentId )/statuses/$($parentId)/notifications"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}