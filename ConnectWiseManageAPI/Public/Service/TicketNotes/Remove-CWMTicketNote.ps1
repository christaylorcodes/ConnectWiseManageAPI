function Remove-CWMTicketNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('noteId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId
    )
    $Endpoint = "/service/tickets/$($parentId)/notes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
