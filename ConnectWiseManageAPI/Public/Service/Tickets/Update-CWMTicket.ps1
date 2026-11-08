<#
.SYNOPSIS
    Updates an existing service ticket in ConnectWise Manage using patch operations.

.DESCRIPTION
    Modifies ticket properties using JSON Patch operations (add, replace, remove).
    This follows the RFC 6902 JSON Patch standard used by ConnectWise Manage API.

    Use -Operation, -Path and -Value for one change, or -PatchOperations for
    several changes in one request.

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
    The new value for the field (required for 'add' and 'replace'; not needed for 'remove').
    Use -Value $null to set a field to null.
    Type depends on the field being updated:
    - References (status, priority, etc.): @{ id = 123 }
    - Strings: "text value"
    - Numbers: 42
    - Booleans: $true or $false

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

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
    Update-CWMTicket -id 12345 -PatchOperations @(
        @{ op = 'replace'; path = 'status'; value = @{ id = 10 } }
        @{ op = 'replace'; path = 'priority'; value = @{ id = 3 } }
        @{ op = 'replace'; path = 'owner'; value = @{ id = 50 } }
        @{ op = 'remove'; path = 'contact' }
    )

    Changes the status, priority and owner and clears the contact of ticket 12345 in one request.

.NOTES
    Author: Chris Taylor

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('ticketId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/service/tickets/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
