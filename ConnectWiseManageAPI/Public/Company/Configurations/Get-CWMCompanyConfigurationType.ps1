function Get-CWMCompanyConfigurationType {
    [CmdletBinding()]
    param(
        [int]$id,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = 'company/configurations/types'
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}