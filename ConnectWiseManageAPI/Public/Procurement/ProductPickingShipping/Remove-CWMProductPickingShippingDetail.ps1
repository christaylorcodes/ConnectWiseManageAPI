<#
.SYNOPSIS
    Deletes a picking and shipping detail of a product.

.DESCRIPTION
    Deletes a picking and shipping detail of a product from ConnectWise Manage. Calls DELETE
    /procurement/products/{parentId}/pickingShippingDetails/{id}.

.PARAMETER parentId
    The id of the product.
    Alias: productId

.PARAMETER id
    The id of the picking and shipping detail to delete.

.EXAMPLE
    Remove-CWMProductPickingShippingDetail -parentId 12 -id 5

    Deletes picking and shipping detail 5 of product 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMProductPickingShippingDetail {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('productId')]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $Endpoint = "/procurement/products/$($parentId)/pickingShippingDetails/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
