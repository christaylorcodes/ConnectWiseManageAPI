<#
.SYNOPSIS
    Retrieves all notes on a project ticket in ConnectWise Manage.

.DESCRIPTION
    Gets the combined notes list for a project ticket from the allNotes endpoint.
    This is the project-ticket counterpart of Get-CWMTicketAllNote.
    Supports filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /project/tickets/{parentId}/allNotes

.PARAMETER parentId
    The ID of the project ticket whose notes to retrieve (required).
    Alias: ticketId

.PARAMETER id
    The ID of a specific note. Appended to the request path when specified.

.PARAMETER count
    Returns only the count of matching notes.

.PARAMETER condition
    Filter notes using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Example: "text contains 'reboot'"

.PARAMETER orderBy
    Sort results by specified field and direction.
    Format: "fieldName asc" or "fieldName desc"
    Example: "id desc"

.PARAMETER childConditions
    Filter results based on child record criteria.
    Uses same condition syntax as -condition parameter.

.PARAMETER customFieldConditions
    Filter results based on custom field values.
    Format: "caption='FieldName' and value='FieldValue'"

.PARAMETER page
    The page number to retrieve (used with -pageSize for pagination).

.PARAMETER pageSize
    Number of records to return per page.

.PARAMETER fields
    Specify which fields to return in the response.

.PARAMETER all
    Retrieve all matching notes by automatically handling pagination.

.EXAMPLE
    Get-CWMProjectTicketAllNote -parentId 9876 -all

    Retrieves all notes on project ticket 9876.

.EXAMPLE
    Get-CWMProjectTicketAllNote -ticketId 9876 -orderBy "id desc" -pageSize 10

    Retrieves the ten most recent notes on project ticket 9876.

.NOTES
    Endpoint: GET /project/tickets/{parentId}/allNotes

    Only the list form of this endpoint (GET /project/tickets/{parentId}/allNotes) is
    published in the API definition; -id and -count are passed through like Get-CWMTicketAllNote.

    Originally proposed by jadamwilson in PR #77

.LINK
    Get-CWMProjectTicket

.LINK
    Get-CWMTicketAllNote

.LINK
    https://developer.connectwise.com/manage/rest#/ProjectTicketNotes

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns note objects, or an integer if -count is specified.
#>
function Get-CWMProjectTicketAllNote {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [int]$id,
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

    $Endpoint = "/project/tickets/$($parentId)/allNotes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
