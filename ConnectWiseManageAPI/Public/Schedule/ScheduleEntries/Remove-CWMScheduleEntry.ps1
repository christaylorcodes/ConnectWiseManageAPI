function Remove-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$ID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/schedule/entries/$ID"
    return Invoke-CWMDeleteMaster -Arguments $PsBoundParameters -URI $URI
}
