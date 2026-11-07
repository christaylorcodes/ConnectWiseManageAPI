<#
.SYNOPSIS
    Gets all notes of a service ticket.

.DESCRIPTION
    Retrieves all notes of a service ticket from ConnectWise Manage, including time entry and meeting notes
    (noteType TicketNote, TimeEntryNote or MeetingNote). Calls GET /service/tickets/{parentId}/allNotes (GET
    /service/tickets/{parentId}/allNotes/count with -count).

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.PARAMETER count
    Return only the number of matching notes instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'text').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketAllNote -parentId 12 -condition "member/identifier='jdoe'" -all

    Retrieves the notes of service ticket 12 that match the condition.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketAllNote {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$parentId,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = "/service/tickets/$($parentId)/allNotes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}