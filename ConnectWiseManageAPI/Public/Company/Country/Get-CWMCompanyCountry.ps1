function Get-CWMCompanyCountry {
    [CmdletBinding()]
    param(
        [Alias('companyId')]
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

    $Endpoint = '/company/countries'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
