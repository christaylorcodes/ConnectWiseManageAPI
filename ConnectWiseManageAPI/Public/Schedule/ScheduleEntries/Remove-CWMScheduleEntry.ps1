function Remove-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$ID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/schedule/entries/$ID"
    return Invoke-CWMDeleteMaster -URI $URI
}
