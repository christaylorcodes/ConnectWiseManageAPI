<#
.SYNOPSIS
    Gets the subtypes of a service board.

.DESCRIPTION
    Retrieves the subtypes of a service board from ConnectWise Manage, or a single subtype by id. Calls GET
    /service/boards/{parentId}/subtypes; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service board.
    Alias: boardId

.PARAMETER id
    The id of a single subtype to retrieve.

.PARAMETER count
    Return only the number of matching subtypes instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name contains 'Support'".

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
    Only return these fields, for example @('id', 'name').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMBoardSubtype -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the subtypes of service board 12 that match the condition.

.EXAMPLE
    Get-CWMBoardSubtype -parentId 12 -id 5

    Retrieves subtype 5 of service board 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardSubtype {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$parentId,
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

    $Endpoint = "/service/boards/$($parentId)/subtypes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}