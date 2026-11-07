<#
.SYNOPSIS
    Deletes a service ticket from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a service ticket by ID. This action cannot be undone.

    ConnectWise Manage decides what happens to related records (notes, time entries,
    configurations) and may refuse the delete, for example when time has been entered.
    Consider closing tickets instead of deleting them to preserve history.

    ConfirmImpact is Medium, so with the default $ConfirmPreference (High) there is no
    confirmation prompt: the ticket is deleted immediately. Use -Confirm to be prompted
    or -WhatIf to preview.

    This function calls the ConnectWise Manage API endpoint: DELETE /service/tickets/{id}

.PARAMETER id
    The ticket ID to delete (required).
    Alias: ticketId

.EXAMPLE
    Remove-CWMTicket -id 12345

    Deletes ticket with ID 12345.

.EXAMPLE
    Remove-CWMTicket -id 12345 -Confirm

    Prompts for confirmation before deleting the ticket.

.EXAMPLE
    Remove-CWMTicket -id 12345 -WhatIf

    Shows what would happen without actually deleting the ticket.

.EXAMPLE
    # Delete multiple tickets
    $oldTicketIds = 100, 101, 102
    $oldTicketIds | ForEach-Object { Remove-CWMTicket -id $_ }

    Deletes multiple tickets. No prompt is shown by default; add -Confirm to be prompted for each one.

.NOTES
    Author: Chris Taylor

    Important:
    - This action is permanent and cannot be undone
    - ConnectWise Manage may reject the delete (for example when time entries exist)
    - Consider closing tickets instead to preserve history
    - Supports -WhatIf and -Confirm (no prompt by default)

    Alternative to Deletion:
    Instead of deleting, move the ticket to a closed status on its board:
    $Closed = Get-CWMBoardStatus -serviceBoardId 1 -condition "closedStatus=true" | Select-Object -First 1
    Update-CWMTicket -id 123 -Operation 'replace' -Path 'status' -Value @{ id = $Closed.id }

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
