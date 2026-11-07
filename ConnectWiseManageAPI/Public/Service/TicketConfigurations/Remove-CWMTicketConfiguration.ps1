<#
.SYNOPSIS
    Detaches a configuration from a service ticket.

.DESCRIPTION
    Detaches a configuration from a service ticket in ConnectWise Manage. Calls DELETE
    /service/tickets/{parentId}/configurations/{id}.

.PARAMETER id
    The id of the configuration to detach.
    Alias: configurationId

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.EXAMPLE
    Remove-CWMTicketConfiguration -parentId 12 -id 5

    Deletes configuration 5 of service ticket 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
