<#
.SYNOPSIS
    Creates a task for a service ticket.

.DESCRIPTION
    Creates a task for a service ticket in ConnectWise Manage. Calls POST /service/tickets/{parentId}/tasks;
    only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the service ticket to add the task to.
    Alias: ticketId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER notes
    Notes.

.PARAMETER closedFlag
    Closed flag. $true or $false.

.PARAMETER priority
    Priority. An integer.

.PARAMETER schedule
    Schedule reference, for example @{ id = 1 }.

.PARAMETER code
    Code reference, for example @{ id = 1 }.

.PARAMETER resolution
    Resolution.

.PARAMETER childScheduleAction
    Child schedule action. One of: Transfer, Delete, Done.

.PARAMETER childTicketId
    Child ticket id. An integer.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMTicketTask -parentId 1234 -notes 'Replace the toner cartridge.'

    Adds a task to service ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMTicketTask {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [int]$id,
        [string]$notes,
        [boolean]$closedFlag,
        [int]$priority,
        [hashtable]$schedule,
        [hashtable]$code,
        [string]$resolution,
        [ValidateSet('Transfer', 'Delete', 'Done')]
        $childScheduleAction,
        [int]$childTicketId,
        [hashtable]$_info
    )

    $Endpoint = "/service/tickets/$($parentId)/tasks"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
