function Get-CWMMarketingGroupContact {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('contactId')]
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

    $Endpoint = "/marketing/groups/$($parentId)/contacts"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
