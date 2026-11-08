<#
.SYNOPSIS
    Gets the statuses of a service board.

.DESCRIPTION
    Retrieves the statuses of a service board from ConnectWise Manage, or a single status by id. Calls GET
    /service/boards/{parentId}/statuses; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the service board.
    Alias: serviceBoardId

.PARAMETER id
    The id of a single status to retrieve.

.PARAMETER count
    Return only the number of matching statuses instead of the records.

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
    Get-CWMBoardStatus -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the statuses of service board 12 that match the condition.

.EXAMPLE
    Get-CWMBoardStatus -parentId 12 -id 5

    Retrieves status 5 of service board 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMBoardStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('serviceBoardId')]
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

    $Endpoint = "/service/boards/$($parentId)/statuses"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}