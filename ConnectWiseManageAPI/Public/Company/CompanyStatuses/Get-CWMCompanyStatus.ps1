function Get-CWMCompanyStatus {
    [CmdletBinding()]
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

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/companies/statuses"
    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}
