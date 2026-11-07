<#
.SYNOPSIS
    Gets the product components of a product.

.DESCRIPTION
    Retrieves the product components of a product from ConnectWise Manage, or a single product component by
    id. Calls GET /procurement/products/{parentId}/components; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the product.
    Alias: ProductID

.PARAMETER id
    The id of a single product component to retrieve.

.PARAMETER count
    Return only the number of matching product components instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

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
    Only return these fields, for example @('id', 'sequenceNumber').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProductComponent -parentId 12 -condition "id>100" -all

    Retrieves the product components of product 12 that match the condition.

.EXAMPLE
    Get-CWMProductComponent -parentId 12 -id 5

    Retrieves product component 5 of product 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProductComponent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ProductID')]
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

    $Endpoint = "/procurement/products/$($parentId)/components"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
