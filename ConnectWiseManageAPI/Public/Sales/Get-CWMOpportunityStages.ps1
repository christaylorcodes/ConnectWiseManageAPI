function Get-CWMOpportunityStage {
    param (
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

    $endpoint = "/sales/stages"

    Invoke-CWMGetMaster -Endpoint $endpoint -Arguments $PSBoundParameters
}