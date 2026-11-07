<#
.SYNOPSIS
    Gets time sheets.

.DESCRIPTION
    Retrieves the time sheets from ConnectWise Manage, or a single time sheet by id. Calls GET /time/sheets;
    -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single time sheet to retrieve.

.PARAMETER count
    Return only the number of matching time sheets instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe' and status='Open'".

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
    Only return these fields, for example @('id', 'member').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTimeSheet -condition "member/identifier='jdoe' and status='Open'" -all

    Retrieves the time sheets that match the condition.

.EXAMPLE
    Get-CWMTimeSheet -id 5

    Retrieves time sheet 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTimeSheet {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/time/sheets'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}