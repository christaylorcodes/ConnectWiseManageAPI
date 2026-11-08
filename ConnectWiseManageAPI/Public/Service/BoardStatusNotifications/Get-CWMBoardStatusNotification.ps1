<#
.SYNOPSIS
    Gets the status notifications of a board status.

.DESCRIPTION
    Retrieves the status notifications of a board status from ConnectWise Manage, or a single status
    notification by id. Calls GET /service/boards/{grandparentId}/statuses/{parentId}/notifications; -id
    adds /{id} and -count adds /count.

.PARAMETER grandparentId
    The id of the service board.
    Alias: boardId

.PARAMETER parentId
    The id of the board status.
    Alias: statusId

.PARAMETER id
    The id of a single status notification to retrieve.

.PARAMETER count
    Return only the number of matching status notifications instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'".

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
    Only return these fields, for example @('id', 'notifyWho').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMBoardStatusNotification -grandparentId 3 -parentId 12 -condition "member/identifier='jdoe'" -all

    Retrieves the status notifications of board status 12 that match the condition.

.EXAMPLE
    Get-CWMBoardStatusNotification -grandparentId 3 -parentId 12 -id 5

    Retrieves status notification 5 of board status 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardStatusNotification {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$grandparentId,
        [Alias('statusId')]
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

    $Endpoint = "/service/boards/$($grandparentId)/statuses/$($parentId)/notifications"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}