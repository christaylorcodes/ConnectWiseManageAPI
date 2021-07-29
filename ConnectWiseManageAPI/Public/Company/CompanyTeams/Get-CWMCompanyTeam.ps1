function Get-CWMCompanyTeam {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [Alias('companyId')]
        [int]$parentId,
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

    $Endpoint = "/company/companies/$($parentId)/teams"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
