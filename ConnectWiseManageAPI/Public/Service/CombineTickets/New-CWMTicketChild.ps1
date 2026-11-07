<#
.SYNOPSIS
    Bundles or merges child tickets into a parent service ticket.

.DESCRIPTION
    Combines one or more service tickets with a parent ticket, using one of the two
    ConnectWise Manage ticket-combining operations:

    - Bundle: attaches the child tickets to the parent. The children stay as separate
      tickets, linked to the parent (their parentTicketId is set), and are closed when the
      parent is closed.
      Calls: POST /service/tickets/{parentId}/attachChildren
      Body:  { "childTicketIds": [ ... ] }

    - Merge: absorbs the child tickets into the parent. The merged tickets are set to the
      status you supply (usually a closed status on their board).
      Calls: POST /service/tickets/{parentId}/merge
      Body:  { "mergeTicketIds": [ ... ], "status": { "id": ..., "name": ..., "sort": ..., "_info": { ... } } }

    The request is sent through Invoke-CWMNewMaster, which serializes the body with enough
    depth that the nested status object (including _info) stays a JSON object.

    The API rejects invalid combinations with a descriptive error, for example when the
    supplied parent is itself a child of another ticket.

    Unbundling: to detach bundled child tickets from the parent again, use
    Remove-CWMTicketChild (POST /service/tickets/{parentId}/detachChildren).

.PARAMETER ParentTicketID
    The ID of the parent ticket that the child tickets are bundled into or merged into.
    Required.

.PARAMETER ChildTicketIDs
    One or more IDs of the tickets to bundle or merge into the parent ticket.
    Required.

.PARAMETER OperationType
    The operation to perform. Required.
    - 'Bundle' attaches the children to the parent (attachChildren).
    - 'Merge' merges the children into the parent (merge); also requires -StatusID.

.PARAMETER StatusID
    Merge only. The ID of the status that the merged child tickets are set to.
    Required for a merge. The status must be valid on the child tickets' board.
    Find status IDs with Get-CWMBoardStatus.

.PARAMETER StatusName
    Merge only. Optional name of the status given in -StatusID. Sent as status.name.

.PARAMETER Sort
    Merge only. Optional sort order of the status. Sent as status.sort.

.PARAMETER _info
    Merge only. Optional _info hashtable for the status reference. Sent as status._info,
    as a nested JSON object.

.EXAMPLE
    New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061 -OperationType Bundle

    Bundles ticket 143061 under ticket 141378.

.EXAMPLE
    New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062, 143063 -OperationType Bundle -WhatIf

    Shows the attachChildren request that would bundle three tickets under 141378, without sending it.

.EXAMPLE
    $Closed = Get-CWMBoardStatus -parentId 1 -condition "name='Closed'"
    New-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061, 143062 -OperationType Merge -StatusID $Closed.id -StatusName $Closed.name

    Merges tickets 143061 and 143062 into ticket 141378 and sets the merged tickets to the
    'Closed' status of service board 1.

.EXAMPLE
    Remove-CWMTicketChild -ParentTicketID 141378 -ChildTicketIDs 143061

    Unbundles ticket 143061 from ticket 141378 again (see Remove-CWMTicketChild).

.NOTES
    Author: Chris Taylor
    Date: 2023-10-11

    API Endpoints:
    - POST /service/tickets/{parentId}/attachChildren (body model TicketBundle: childTicketIds)
    - POST /service/tickets/{parentId}/merge (body model TicketMerge: mergeTicketIds, status)

    Both endpoints return a success response object.

    -OperationType must match the other parameters: -StatusID, -StatusName, -Sort and -_info
    are only valid with 'Merge', and 'Merge' requires -StatusID.

    Supports -WhatIf and -Confirm (handled by Invoke-CWMNewMaster).

.LINK
    Remove-CWMTicketChild

.LINK
    Get-CWMTicket

.LINK
    Get-CWMBoardStatus

.LINK
    https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdAttachChildren

.LINK
    https://developer.connectwise.com/Products/Manage/REST#/Tickets/postServiceTicketsByParentIdMerge

#>
function New-CWMTicketChild {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Bundle')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$ParentTicketID,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [int[]]$ChildTicketIDs,
        [Parameter(Mandatory = $true, ParameterSetName = 'Merge')]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$StatusID,
        [Parameter(ParameterSetName = 'Merge')]
        [string]$StatusName,
        [Parameter(ParameterSetName = 'Merge')]
        [int]$Sort,
        [Parameter(ParameterSetName = 'Merge')]
        [hashtable]$_info,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Bundle', 'Merge')]
        [string]$OperationType
    )

    if ($OperationType -ne $PSCmdlet.ParameterSetName) {
        if ($OperationType -eq 'Merge') { $Message = 'OperationType Merge requires -StatusID.' }
        else { $Message = 'The -StatusID, -StatusName, -Sort and -_info parameters can only be used with -OperationType Merge.' }
        $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new(
                [System.ArgumentException]::new($Message), 'InvalidOperationType',
                [System.Management.Automation.ErrorCategory]::InvalidArgument, $OperationType))
    }

    if ($OperationType -eq 'Bundle') {
        $Endpoint = "/service/tickets/$($ParentTicketID)/attachChildren"
        $Arguments = @{
            childTicketIds = $ChildTicketIDs
        }
    }
    else {
        $Endpoint = "/service/tickets/$($ParentTicketID)/merge"
        $Status = @{ id = $StatusID }
        if ($PSBoundParameters.ContainsKey('StatusName')) { $Status.name = $StatusName }
        if ($PSBoundParameters.ContainsKey('Sort')) { $Status.sort = $Sort }
        if ($PSBoundParameters.ContainsKey('_info')) { $Status._info = $_info }
        $Arguments = @{
            mergeTicketIds = $ChildTicketIDs
            status         = $Status
        }
    }

    # Invoke-CWMNewMaster builds the JSON body from $Arguments (ConvertTo-Json -Depth 100) and handles ShouldProcess
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint $Endpoint
}
