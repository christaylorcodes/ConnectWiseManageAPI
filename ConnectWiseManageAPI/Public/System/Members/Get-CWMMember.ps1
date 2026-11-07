<#
.SYNOPSIS
    Gets members.

.DESCRIPTION
    Retrieves the members from ConnectWise Manage, or a single member by id. Calls GET /system/members; -id
    adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single member to retrieve.

.PARAMETER count
    Return only the number of matching members instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "identifier='ACME'".

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
    Only return these fields, for example @('id', 'identifier').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMMember -condition "identifier='ACME'" -all

    Retrieves the members that match the condition.

.EXAMPLE
    Get-CWMMember -id 5

    Retrieves member 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMMember {
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

    $Endpoint = '/system/members'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
