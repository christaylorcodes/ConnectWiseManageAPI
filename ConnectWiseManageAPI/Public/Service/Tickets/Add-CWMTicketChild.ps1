function Add-CWMTicketChild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [int[]]$ChildTicketIds
    )
    $psboundparameters.remove('id')

    $Endpoint = "/service/tickets/$id/attachChildren"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}
