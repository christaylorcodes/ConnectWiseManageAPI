<#
.SYNOPSIS
    Gets warehouses.

.DESCRIPTION
    Retrieves the warehouses from ConnectWise Manage, or a single warehouse by id. Calls GET
    /procurement/warehouses; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single warehouse to retrieve.

.PARAMETER count
    Return only the number of matching warehouses instead of the records.

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
    Get-CWMWarehouse -condition "name contains 'Support'" -all

    Retrieves the warehouses that match the condition.

.EXAMPLE
    Get-CWMWarehouse -id 5

    Retrieves warehouse 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMWarehouse {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/procurement/warehouses'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}