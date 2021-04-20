function Get-CWMCompanyConfigurationTypes {
<#    [CmdletBinding()]
    param(
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

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/configurations/types"

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
#>
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
