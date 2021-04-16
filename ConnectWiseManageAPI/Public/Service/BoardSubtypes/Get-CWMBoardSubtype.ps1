function Get-CWMBoardSubtype {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('boardId')]
        [int]$parentId,
        [int]$id,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        $orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = "/service/boards/$($parentId)/subtypes"
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}