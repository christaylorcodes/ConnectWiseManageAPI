function Get-CWMBoardTypeSubTypeItemAssociation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$parentId,
        [Alias('typeSubTypeItemAssociationId')]
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

    $Endpoint = "/service/boards/$($parentId)/typeSubTypeItemAssociations"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}