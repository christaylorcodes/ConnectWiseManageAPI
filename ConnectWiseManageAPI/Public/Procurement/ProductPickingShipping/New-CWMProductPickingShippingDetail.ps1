<#
.SYNOPSIS
    Creates a picking and shipping detail for a product.

.DESCRIPTION
    Creates a picking and shipping detail for a product in ConnectWise Manage. Calls POST
    /procurement/products/{parentId}/pickingShippingDetails; only the parameters you pass are sent in the
    request body.

.PARAMETER parentId
    The id of the product to add the picking and shipping detail to.
    Alias: productId

.PARAMETER pickedQuantity
    Picked quantity. An integer.

.PARAMETER shippedQuantity
    Shipped quantity. An integer.

.PARAMETER warehouse
    Warehouse reference, for example @{ id = 1 }. Required by the API.

.PARAMETER warehouseBin
    Warehouse bin reference, for example @{ id = 1 }. Required by the API.

.PARAMETER shipmentMethod
    Shipment method reference, for example @{ id = 1 }.

.PARAMETER serialNumber
    Serial number.

.PARAMETER serialNumberIds
    Serial number ids. An array of integers.

.PARAMETER trackingNumber
    Tracking number.

.PARAMETER productItem
    Product item reference, for example @{ id = 1 }.

.PARAMETER lineNumber
    Line number. An integer.

.PARAMETER quantity
    Quantity. An integer.

.PARAMETER expectedArrivalDate
    Expected arrival date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER shipmentDate
    Shipment date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMProductPickingShippingDetail -parentId 12 -warehouse @{ id = 1 } -warehouseBin @{ id = 2 } -pickedQuantity 1

    Records one unit of product 12 as picked from warehouse 1, bin 2.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMProductPickingShippingDetail {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('productId')]
        [int]$parentId,
        [int]$pickedQuantity,
        [int]$shippedQuantity,
        [Parameter(Mandatory=$true)]
        [hashtable]$warehouse,
        [Parameter(Mandatory=$true)]
        [hashtable]$warehouseBin,
        [hashtable]$shipmentMethod,
        [string]$serialNumber,
        [int]$serialNumberIds,
        [string]$trackingNumber,
        [hashtable]$productItem,
        [int]$lineNumber,
        [int]$quantity,
        [string]$expectedArrivalDate,
        [string]$shipmentDate,
        [hashtable]$_info
    )

    $Endpoint = "/procurement/products/$($parentId)/pickingShippingDetails"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
