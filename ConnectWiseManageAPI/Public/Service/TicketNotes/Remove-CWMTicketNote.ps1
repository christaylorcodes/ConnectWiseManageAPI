<#
.SYNOPSIS
    Deletes a note of a service ticket.

.DESCRIPTION
    Deletes a note of a service ticket from ConnectWise Manage. Calls DELETE
    /service/tickets/{parentId}/notes/{id}.

.PARAMETER id
    The id of the note to delete.
    Alias: noteId

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.EXAMPLE
    Remove-CWMTicketNote -parentId 12 -id 5

    Deletes note 5 of service ticket 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
