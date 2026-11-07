<#
.SYNOPSIS
    Attaches a configuration to a project ticket.

.DESCRIPTION
    Attaches an existing configuration to a project ticket in ConnectWise Manage. Calls POST
    /project/tickets/{parentId}/configurations with a ConfigurationReference body.

.PARAMETER parentId
    The id of the project ticket to add the configuration to.
    Alias: ticketId

.PARAMETER id
    The id of the configuration to attach.
    Alias: deviceIdentifier

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMProjectTicketConfiguration -parentId 1234 -id 77

    Attaches configuration 77 to project ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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