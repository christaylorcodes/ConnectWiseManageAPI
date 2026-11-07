<#
.SYNOPSIS
    Gets products.

.DESCRIPTION
    Retrieves the products from ConnectWise Manage, or a single product by id. Calls GET
    /procurement/products; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single product to retrieve.

.PARAMETER count
    Return only the number of matching products instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "ticket/id=1234".

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
    Only return these fields, for example @('id', 'description').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProduct -condition "ticket/id=1234" -all

    Retrieves the products that match the condition.

.EXAMPLE
    Get-CWMProduct -id 5

    Retrieves product 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProduct {
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

    $Endpoint = '/procurement/products'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}