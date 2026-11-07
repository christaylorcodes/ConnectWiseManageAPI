function New-CWMProductPickingShippingDetail {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
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
