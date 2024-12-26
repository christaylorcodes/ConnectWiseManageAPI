function Get-CWMOpportunityForecast {
        param (
            [Parameter(Mandatory=$true)]
            [int32]$parentId,
            [string]$condition,
            [string]$childConditions,
            [string]$customFieldConditions,
            [string]$orderBy,
            [string]$fields,
            [Int32]$page,
            [Int32]$pageSize,
            [Int32]$pageID,
            [switch]$all
        )
    
        $endpoint = "/sales/opportunities/$parentId/forecast"
    
        Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}