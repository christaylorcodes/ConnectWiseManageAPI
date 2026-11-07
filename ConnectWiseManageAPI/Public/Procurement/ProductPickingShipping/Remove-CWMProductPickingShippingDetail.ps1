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
