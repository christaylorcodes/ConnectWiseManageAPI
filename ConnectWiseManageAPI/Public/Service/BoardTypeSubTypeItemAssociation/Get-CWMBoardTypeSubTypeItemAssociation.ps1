<#
.SYNOPSIS
    Gets the type/subtype/item associations of a service board.

.DESCRIPTION
    Retrieves the type/subtype/item associations of a service board from ConnectWise Manage, or a single
    type/subtype/item association by id. Calls GET /service/boards/{parentId}/typeSubTypeItemAssociations;
    -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service board.
    Alias: boardId

.PARAMETER id
    The id of a single type/subtype/item association to retrieve.
    Alias: typeSubTypeItemAssociationId

.PARAMETER count
    Return only the number of matching type/subtype/item associations instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "type/id=1".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childconditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customfieldconditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'type').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMBoardTypeSubTypeItemAssociation -parentId 12 -condition "type/id=1" -all

    Retrieves the type/subtype/item associations of service board 12 that match the condition.

.EXAMPLE
    Get-CWMBoardTypeSubTypeItemAssociation -parentId 12 -id 5

    Retrieves type/subtype/item association 5 of service board 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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