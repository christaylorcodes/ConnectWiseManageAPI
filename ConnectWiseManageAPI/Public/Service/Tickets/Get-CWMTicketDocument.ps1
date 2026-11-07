<#
.SYNOPSIS
    Gets the documents attached to a service ticket.

.DESCRIPTION
    Retrieves the full documents attached to a service ticket. Calls
    GET /system/documents?recordType=Ticket&recordId={parentId} through Get-CWMDocument; -count calls
    /system/documents/count.

    GET /service/tickets/{id}/documents is not used: it returns only id references, and the ConnectWise API
    documentation points to this /system/documents query instead. Download a document's content with
    Get-CWMDocument -id <id> -download.

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.PARAMETER count
    Return only the number of matching documents instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "title contains 'invoice'".

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
    Only return these fields, for example @('id', 'title').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketDocument -ticketId 1234 -all

    Retrieves every document attached to ticket 1234.

.EXAMPLE
    Get-CWMTicketDocument -ticketId 1234 | ForEach-Object { Get-CWMDocument -id $_.id -download -OutFile "C:\Temp\$($_.fileName)" }

    Saves every document of ticket 1234 to C:\Temp.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketDocument {
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

    Get-CWMDocument -recordType Ticket -recordId $parentId @Arguments
}
