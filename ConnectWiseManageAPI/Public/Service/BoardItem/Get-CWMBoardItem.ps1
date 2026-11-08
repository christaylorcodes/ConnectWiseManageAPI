<#
.SYNOPSIS
    Gets the items of a service board.

.DESCRIPTION
    Retrieves the items of a service board from ConnectWise Manage, or a single item by id. Calls GET
    /service/boards/{parentId}/items; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service board.

.PARAMETER id
    The id of a single item to retrieve.

.PARAMETER count
    Return only the number of matching items instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name contains 'Support'".

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
    Only return these fields, for example @('id', 'name').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMBoardItem -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the items of service board 12 that match the condition.

.EXAMPLE
    Get-CWMBoardItem -parentId 12 -id 5

    Retrieves item 5 of service board 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [int]$parentId,
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

    $Endpoint = "/service/boards/$parentId/items"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}