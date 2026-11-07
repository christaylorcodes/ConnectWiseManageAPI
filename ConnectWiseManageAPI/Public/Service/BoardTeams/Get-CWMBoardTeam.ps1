<#
.SYNOPSIS
    Gets the teams of a service board.

.DESCRIPTION
    Retrieves the teams of a service board from ConnectWise Manage, or a single team by id. Calls GET
    /service/boards/{parentId}/teams; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service board.
    Alias: boardId

.PARAMETER id
    The id of a single team to retrieve.

.PARAMETER count
    Return only the number of matching teams instead of the records.

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
    Get-CWMBoardTeam -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the teams of service board 12 that match the condition.

.EXAMPLE
    Get-CWMBoardTeam -parentId 12 -id 5

    Retrieves team 5 of service board 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardTeam {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
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

    $Endpoint = "/service/boards/$($parentId)/teams"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}