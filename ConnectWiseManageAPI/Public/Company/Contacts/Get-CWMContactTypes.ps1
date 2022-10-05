function Get-CWMContactTypes {
    [CmdletBinding()]
    param(
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
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
