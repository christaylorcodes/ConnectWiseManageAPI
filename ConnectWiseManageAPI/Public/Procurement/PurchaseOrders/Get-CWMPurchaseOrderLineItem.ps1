<#
.SYNOPSIS
    Gets the purchase order line items of a purchase order.

.DESCRIPTION
    Retrieves the purchase order line items of a purchase order from ConnectWise Manage, or a single
    purchase order line item by id. Calls GET /procurement/purchaseorders/{parentId}/lineitems; -id adds
    /{id} and -count adds /count.

.PARAMETER parentId
    The id of the purchase order.
    Aliases: purchaseOrderId, ProductID

.PARAMETER id
    The id of a single purchase order line item to retrieve.

.PARAMETER count
    Return only the number of matching purchase order line items instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "description contains 'laptop'".

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
    Only return these fields, for example @('id', 'description').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMPurchaseOrderLineItem -parentId 12 -condition "description contains 'laptop'" -all

    Retrieves the purchase order line items of purchase order 12 that match the condition.

.EXAMPLE
    Get-CWMPurchaseOrderLineItem -parentId 12 -id 5

    Retrieves purchase order line item 5 of purchase order 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMPurchaseOrderLineItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('purchaseOrderId', 'ProductID')]
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

    $Endpoint = "/procurement/purchaseorders/$($parentId)/lineitems"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
