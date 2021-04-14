function New-CWMTicketTask {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess','', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [int]$TicketID,
        [string]$Notes,
        [boolean]$ClosedFlag,
        [int]$Priority,
        [string]$Resolution,
        $_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$ticketId/tasks"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}