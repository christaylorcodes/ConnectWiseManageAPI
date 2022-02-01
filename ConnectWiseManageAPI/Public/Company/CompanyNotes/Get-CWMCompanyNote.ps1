function Get-CWMCompanyNote {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [Parameter(Mandatory = $true)]
        [int]$CompanyID,
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

    $Endpoint = "/company/companies/$($CompanyID)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
