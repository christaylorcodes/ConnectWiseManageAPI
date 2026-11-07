<#
.SYNOPSIS
    Updates an existing service ticket in ConnectWise Manage using patch operations.

.DESCRIPTION
    Modifies ticket properties using JSON Patch operations (add, replace, remove).
    This follows the RFC 6902 JSON Patch standard used by ConnectWise Manage API.

    Each update requires specifying the operation type, field path, and value.
    Multiple fields can be updated by calling this function multiple times or
    by using Invoke-CWMUpdateMaster directly with an array of operations.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/tickets/{id}

.PARAMETER id
    The ticket ID to update (required).
    Alias: ticketId

.PARAMETER Operation
    The patch operation to perform (required).
    Valid values: 'add', 'replace', 'remove'
    - replace: Modifies an existing field value
    - add: Adds a value to an array or creates a field
    - remove: Removes a field value

.PARAMETER Path
    The field path to modify (required).
    Examples: 'status', 'summary', 'priority', 'owner'
    For nested fields use slash notation: 'customFields/0/value'

.PARAMETER Value
    The new value for the field (required for 'add' and 'replace').
    Type depends on the field being updated:
    - References (status, priority, etc.): @{ id = 123 }
    - Strings: "text value"
    - Numbers: 42
    - Booleans: $true or $false

.EXAMPLE
    Update-CWMTicket -id 12345 -Operation 'replace' -Path 'summary' -Value 'Updated ticket title'

    Updates the ticket summary.

.EXAMPLE
    Update-CWMTicket -id 12345 -Operation 'replace' -Path 'status' -Value @{ id = 10 }

    Changes the ticket status using a status ID reference.

.EXAMPLE
    Update-CWMTicket -id 12345 -Operation 'replace' -Path 'priority' -Value @{ id = 5 }

    Updates the ticket priority.

.EXAMPLE
    # Update multiple fields (call function multiple times)
    $ticketId = 12345
    Update-CWMTicket -id $ticketId -Operation 'replace' -Path 'status' -Value @{ id = 10 }
    Update-CWMTicket -id $ticketId -Operation 'replace' -Path 'priority' -Value @{ id = 3 }
    Update-CWMTicket -id $ticketId -Operation 'replace' -Path 'owner' -Value @{ id = 50 }

    Updates multiple ticket fields sequentially.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Common Update Paths:
    - 'summary' - Ticket title
    - 'status' - Ticket status (hashtable: @{ id = X })
    - 'priority' - Ticket priority (hashtable: @{ id = X })
    - 'owner' - Assigned owner (hashtable: @{ id = X })
    - 'company' - Company (hashtable: @{ id = X })
    - 'board' - Service board (hashtable: @{ id = X })
    - 'type' - Ticket type (hashtable: @{ id = X })

    Hashtable Reference Format:
    Most reference fields require: @{ id = <number> }
    Some also accept: @{ id = <number>; name = "Name" }

.LINK
    https://developer.connectwise.com/manage/rest#/Tickets

.LINK
    Get-CWMTicket

.LINK
    New-CWMTicket

.LINK
    Remove-CWMTicket

#>
function Update-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/service/tickets/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
