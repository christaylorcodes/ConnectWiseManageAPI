function Remove-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$id
    )

    $Endpoint = "/service/tickets/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
