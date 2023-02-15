function Get-CWMContactType {
    [CmdletBinding()]
    param(
        [int]$id,
        [string]$conditions,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [int]$pageId,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = "/company/contacts/types"

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
