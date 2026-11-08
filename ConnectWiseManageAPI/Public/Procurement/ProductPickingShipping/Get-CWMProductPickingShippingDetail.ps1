<#
.SYNOPSIS
    Gets the picking and shipping details of a product.

.DESCRIPTION
    Retrieves the picking and shipping details of a product from ConnectWise Manage, or a single picking and
    shipping detail by id. Calls GET /procurement/products/{parentId}/pickingShippingDetails; -id adds /{id}
    and -count adds /count.

.PARAMETER parentId
    The id of the product.
    Alias: productId

.PARAMETER id
    The id of a single picking and shipping detail to retrieve.

.PARAMETER count
    Return only the number of matching picking and shipping details instead of the records.

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
    Only return these fields, for example @('id', 'pickedQuantity').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProductPickingShippingDetail -parentId 12 -condition "id>100" -all

    Retrieves the picking and shipping details of product 12 that match the condition.

.EXAMPLE
    Get-CWMProductPickingShippingDetail -parentId 12 -id 5

    Retrieves picking and shipping detail 5 of product 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProductPickingShippingDetail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('productId')]
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

    $Endpoint = "/procurement/products/$($parentId)/pickingShippingDetails"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
