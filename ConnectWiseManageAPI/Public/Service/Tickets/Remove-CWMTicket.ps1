<#
.SYNOPSIS
    Deletes a service ticket from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a service ticket by ID. This action cannot be undone.

    Use caution when deleting tickets as this removes all associated data including
    notes, time entries, and configurations. Consider closing tickets instead of
    deleting them to preserve history.

    This function calls the ConnectWise Manage API endpoint: DELETE /service/tickets/{id}

.PARAMETER id
    The ticket ID to delete (required).
    Alias: ticketId

.EXAMPLE
    Remove-CWMTicket -id 12345

    Deletes ticket with ID 12345.

.EXAMPLE
    Remove-CWMTicket -id 12345 -Confirm:$false

    Deletes the ticket without confirmation prompt.

.EXAMPLE
    Remove-CWMTicket -id 12345 -WhatIf

    Shows what would happen without actually deleting the ticket.

.EXAMPLE
    # Delete multiple tickets
    $oldTicketIds = 100, 101, 102
    $oldTicketIds | ForEach-Object { Remove-CWMTicket -id $_ -Confirm:$false }

    Deletes multiple tickets without prompting for each one.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Important:
    - This action is permanent and cannot be undone
    - All ticket data is removed (notes, time entries, etc.)
    - Consider closing tickets instead to preserve history
    - Supports -WhatIf and -Confirm for safety

    Alternative to Deletion:
    Instead of deleting, consider closing the ticket:
    Update-CWMTicket -id 123 -Operation 'replace' -Path 'closedFlag' -Value $true

.LINK
    https://developer.connectwise.com/manage/rest#/Tickets

.LINK
    Get-CWMTicket

.LINK
    New-CWMTicket

.LINK
    Update-CWMTicket

#>
function Remove-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$id
    )

    $Endpoint = "/service/tickets/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
