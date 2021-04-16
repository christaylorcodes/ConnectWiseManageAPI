function Get-CWMMarketingGroupContact {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('contactId')]
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

    $Endpoint = "/marketing/groups/$($parentId)/contacts"
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
