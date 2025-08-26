function New-CWMProjectTicketConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [Alias('deviceIdentifier')]
        [string]$id,
        [hashtable]$_info
    )

    $Endpoint = "/project/tickets/$($parentId)/configurations"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}