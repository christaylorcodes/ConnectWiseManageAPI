<#
.SYNOPSIS
    Deletes a product.

.DESCRIPTION
    Deletes a product from ConnectWise Manage. Calls DELETE /procurement/products/{id}.

.PARAMETER id
    The id of the product to delete.
    Alias: productId

.EXAMPLE
    Remove-CWMProduct -id 5

    Deletes product 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMProduct {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('productId')]
        [int]$id
    )

    $Endpoint = "/procurement/products/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
