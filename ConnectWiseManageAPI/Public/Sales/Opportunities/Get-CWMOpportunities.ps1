function Get-CWMOpportunities {
    [CmdletBinding()]
    param(
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields
    )

    $Endpoint = '/sales/opportunities'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
