function Remove-CWMDocument {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('documentId')]
        [int]$id
    )
    $Endpoint = "/system/documents/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
