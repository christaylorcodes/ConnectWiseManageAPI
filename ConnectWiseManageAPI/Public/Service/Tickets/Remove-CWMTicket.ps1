function Remove-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$TicketID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$TicketID"
    return Invoke-CWMDeleteMaster -URI $URI
}
