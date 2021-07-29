function Get-CWMMarketingGroupCompany {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('groupId')]
        [int]$parentId,
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

    $Endpoint = "/marketing/groups/$($parentId)/companies"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
