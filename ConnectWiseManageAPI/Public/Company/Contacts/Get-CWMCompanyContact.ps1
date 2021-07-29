function Get-CWMCompanyContact {
    [CmdletBinding()]
    [Alias('Get-CWMContact')]
    param(
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

    $Endpoint = '/company/contacts'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}