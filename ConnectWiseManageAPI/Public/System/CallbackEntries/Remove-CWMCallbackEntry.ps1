function Remove-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$ID
    )
    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/callbacks/$ID"
    return Invoke-CWMDeleteMaster -URI $URI
}
