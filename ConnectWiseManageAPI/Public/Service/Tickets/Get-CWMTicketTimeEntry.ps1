<#
.SYNOPSIS
    Gets the time entries of a service or project ticket.

.DESCRIPTION
    Retrieves the full time entries charged to a ticket. Calls GET /time/entries with the condition
    (chargeToType='ServiceTicket' or chargeToType='ProjectTicket') and chargeToId={parentId}, combined with
    -condition when given; -count calls /time/entries/count.

    GET /service/tickets/{id}/timeentries is not used: it returns only id references, and the ConnectWise API
    documentation points to this /time/entries query instead.

.PARAMETER parentId
    The id of the ticket.
    Alias: ticketId

.PARAMETER count
    Return only the number of matching time entries instead of the records.

.PARAMETER condition
    An extra filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'". It is
    combined with the ticket filter using 'and'.

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'timeStart desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'actualHours').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketTimeEntry -ticketId 1234 -all

    Retrieves every time entry charged to ticket 1234.

.EXAMPLE
    Get-CWMTicketTimeEntry -ticketId 1234 -condition "member/identifier='jdoe'" -fields @('id', 'actualHours')

    Retrieves the id and hours of the time entries jdoe charged to ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketTimeEntry {
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

    $TicketCondition = "(chargeToType='ServiceTicket' or chargeToType='ProjectTicket') and chargeToId=$($parentId)"
    $Arguments.condition = if ($condition) { "$TicketCondition and ($condition)" } else { $TicketCondition }

    Invoke-CWMGetMaster -Arguments $Arguments -Endpoint '/time/entries'
}
