<#
.SYNOPSIS
    Gets warehouse bins.

.DESCRIPTION
    Retrieves the warehouse bins from ConnectWise Manage, or a single warehouse bin by id. Calls GET
    /procurement/warehouseBins; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single warehouse bin to retrieve.

.PARAMETER count
    Return only the number of matching warehouse bins instead of the records.

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
    Get-CWMWarehouseBin -condition "name contains 'Support'" -all

    Retrieves the warehouse bins that match the condition.

.EXAMPLE
    Get-CWMWarehouseBin -id 5

    Retrieves warehouse bin 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMWarehouseBin {
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

    $Endpoint = '/procurement/warehouseBins'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}