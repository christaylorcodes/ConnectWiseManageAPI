function Get-CWMOpportunityNote {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('OpportunityId')]
        [int]$parentId,
        [switch]$count,
        [string]$conditions,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields
    )

    $Endpoint = "/sales/opportunities/$($parentId)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}