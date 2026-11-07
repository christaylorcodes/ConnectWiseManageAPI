<#
.SYNOPSIS
    Attaches a configuration to a service ticket.

.DESCRIPTION
    Attaches an existing configuration to a service ticket in ConnectWise Manage. Calls POST
    /service/tickets/{parentId}/configurations with a ConfigurationReference body.

.PARAMETER parentId
    The id of the service ticket to add the configuration to.
    Alias: ticketId

.PARAMETER id
    The id of the configuration to attach.
    Alias: deviceIdentifier

.EXAMPLE
    New-CWMTicketConfiguration -parentId 1234 -id 77

    Attaches configuration 77 to service ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMTicketConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [Alias('deviceIdentifier')]
        [string]$id
    )

    $Endpoint = "/service/tickets/$($parentId)/configurations"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}