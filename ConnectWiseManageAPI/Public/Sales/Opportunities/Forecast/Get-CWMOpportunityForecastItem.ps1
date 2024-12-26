function Get-CWMOpportunityForecastItem {
    param (
        [Parameter(Mandatory=$true)]
        [int32]$parentId,
        [Parameter(Mandatory=$true)]
        [int32]$id,
        [string]$condition,
        [string]$childConditions,
        [string]$customFieldConditions,
        [string]$orderBy,
        [string]$fields,
        [Int32]$page,
        [Int32]$pageSize,
        [Int32]$pageID
    )

    $endpoint = "/sales/opportunities/$parentId/forecast/"

    Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}