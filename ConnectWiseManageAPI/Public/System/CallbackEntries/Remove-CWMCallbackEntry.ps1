function Remove-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('callbackId')]
        [int]$id
    )

    $Endpoint = "/system/callbacks/$($id)"
    return Invoke-CWMDeleteMaster -Endpoint $Endpoint
}
