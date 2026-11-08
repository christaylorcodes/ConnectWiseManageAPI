<#
.SYNOPSIS
    Gets the subtype associations of a service board item.

.DESCRIPTION
    Retrieves the subtype associations of a board item from ConnectWise Manage. Calls GET
    /service/boards/{grandparentId}/items/{parentId}/associations; -count adds /count.

.PARAMETER grandparentId
    The id of the service board.
    Alias: boardId

.PARAMETER parentId
    The id of the board item.
    Alias: itemId

.PARAMETER count
    Return only the number of matching subtype associations instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'subTypeAssociationIds').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMBoardItemAssociation -grandparentId 3 -parentId 12 -condition "id>100" -all

    Retrieves the subtype associations of board item 12 that match the condition.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardItemAssociation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$grandparentId,
        [Parameter(Mandatory = $true)]
        [Alias('itemId')]
        [int]$parentId,
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

    $Endpoint = "/service/boards/$grandparentId/items/$parentId/associations"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}