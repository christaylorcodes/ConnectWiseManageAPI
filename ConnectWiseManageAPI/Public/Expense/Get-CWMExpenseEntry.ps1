<#
.SYNOPSIS
    Gets expense entries.

.DESCRIPTION
    Retrieves the expense entries from ConnectWise Manage, or a single expense entry by id. Calls GET
    /expense/entries; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single expense entry to retrieve.

.PARAMETER count
    Return only the number of matching expense entries instead of the records.

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
    Only return these fields, for example @('id', 'type').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMExpenseEntry -condition "member/identifier='jdoe'" -all

    Retrieves the expense entries that match the condition.

.EXAMPLE
    Get-CWMExpenseEntry -id 5

    Retrieves expense entry 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMExpenseEntry {
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

    $Endpoint = '/expense/entries'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}