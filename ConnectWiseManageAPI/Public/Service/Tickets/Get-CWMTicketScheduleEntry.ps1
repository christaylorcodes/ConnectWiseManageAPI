<#
.SYNOPSIS
    Gets the schedule entries of a service ticket.

.DESCRIPTION
    Retrieves the full schedule entries of a service ticket. Calls GET /schedule/entries with the condition
    type/id=4 and objectId={parentId}, combined with -condition when given; -count calls
    /schedule/entries/count.

    GET /service/tickets/{id}/scheduleentries is not used: it returns only id references, and the ConnectWise
    API documentation points to this /schedule/entries query instead.

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.PARAMETER count
    Return only the number of matching schedule entries instead of the records.

.PARAMETER condition
    An extra filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'". It is
    combined with the ticket filter using 'and'.

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'dateStart desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'dateStart').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketScheduleEntry -ticketId 1234 -all

    Retrieves every schedule entry of ticket 1234.

.EXAMPLE
    Get-CWMTicketScheduleEntry -ticketId 1234 -count

    Returns the number of schedule entries of ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketScheduleEntry {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
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

    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }
    $null = $Arguments.Remove('parentId')

    # Schedule type 4 is the service ticket type
    $TicketCondition = "type/id=4 and objectId=$($parentId)"
    $Arguments.condition = if ($condition) { "$TicketCondition and ($condition)" } else { $TicketCondition }

    Invoke-CWMGetMaster -Arguments $Arguments -Endpoint '/schedule/entries'
}
