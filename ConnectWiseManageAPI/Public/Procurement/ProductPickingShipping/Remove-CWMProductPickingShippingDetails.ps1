function Remove-CWMProductPickingShippingDetails {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $Endpoint = "/procurement/products/{parentId}/pickingShippingDetails/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
