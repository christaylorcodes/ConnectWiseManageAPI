function Remove-CWMTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id
    )
    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/<URI>/$ID"
    return Invoke-CWMDeleteMaster -URI $URI
}
