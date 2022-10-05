function Get-CWMContactTypes {
    [CmdletBinding()]
    param(
        [int]$parentId,
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

    $Endpoint = "/company/contacts/types"
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}