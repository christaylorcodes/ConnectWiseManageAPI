<#
.SYNOPSIS
    Gets expense types.

.DESCRIPTION
    Retrieves expense types from ConnectWise Manage, or a single expense type by id. Calls GET
    /expense/types; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single expense type to retrieve.

.PARAMETER count
    Return only the number of matching expense types instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "inactiveFlag=false".

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
    Get-CWMExpenseType -all

    Retrieves every expense type.

.EXAMPLE
    Get-CWMExpenseType -id 5

    Retrieves expense type 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMExpenseType {
    [CmdletBinding()]
    param(
        [Alias('expenseTypeId')]
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

    $Endpoint = '/expense/types'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
