function Get-CWMMyMember {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/system/myMembers'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
