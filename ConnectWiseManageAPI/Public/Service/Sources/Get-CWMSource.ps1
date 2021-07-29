function Get-CWMSource {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        $orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/service/sources'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}