<#
.SYNOPSIS
    Detaches (unbundles) child tickets from a parent service ticket.

.DESCRIPTION
    Reverses a bundle made with New-CWMTicketChild -OperationType Bundle: the child tickets
    are detached from the parent and become independent tickets again.

    Calls: POST /service/tickets/{parentId}/detachChildren
    Body:  { "childTicketIds": [ ... ] }

    The endpoint is a POST (not a DELETE), so the request is sent through Invoke-CWMNewMaster.
    It takes the same TicketBundle body as attachChildren. The API has no endpoint that reverses
    a merge (New-CWMTicketChild -OperationType Merge).

.PARAMETER ParentTicketID
    The ID of the parent ticket that the child tickets are bundled under. Required.

.PARAMETER ChildTicketIDs
    One or more IDs of the child tickets to detach from the parent ticket. Required.

.EXAMPLE
    Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061

    Detaches ticket 143061 from its parent ticket 141378.

.EXAMPLE
    Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062 -WhatIf

    Shows the detachChildren request that would detach two tickets from 141378, without sending it.

.NOTES
    Author: Chris Taylor

    API Endpoint:
    - POST /service/tickets/{parentId}/detachChildren (body model TicketBundle: childTicketIds)

    Returns a success response object.

    Supports -WhatIf and -Confirm (handled by Invoke-CWMNewMaster).

.LINK
    New-CWMTicketChild

.LINK
    Get-CWMTicket

.LINK
    https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdDetachChildren

#>
function Remove-CWMTicketChild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$ParentTicketID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [int[]]$ChildTicketIDs
    )

    $Endpoint = "/service/tickets/$($ParentTicketID)/detachChildren"
    $Arguments = @{
        childTicketIds = $ChildTicketIDs
    }

    # Invoke-CWMNewMaster builds the JSON body from $Arguments and handles ShouldProcess
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint $Endpoint
}
