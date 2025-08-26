function Get-CWMCompanyCustomNote {
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

    $Endpoint = "/company/companies/$($CompanyID)/customStatusNotes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
