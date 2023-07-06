function Remove-CWMTicketConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('configurationId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId
    )
    $Endpoint = "/service/tickets/$($parentId)/configurations/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
