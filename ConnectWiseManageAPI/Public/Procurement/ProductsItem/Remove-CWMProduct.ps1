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
