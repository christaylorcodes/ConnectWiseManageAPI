<#
.SYNOPSIS
    Updates a task of a service ticket in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing ticket task.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/tickets/{parentId}/tasks/{id}

.PARAMETER parentId
    The ID of the ticket.

.PARAMETER id
    The ID of the task to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'closedFlag'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMTicketTask -parentId 12345 -id 2 -Operation replace -Path 'closedFlag' -Value $true

    Closes task 2 of ticket 12345.

.EXAMPLE
    Update-CWMTicketTask 12345 2 replace closedFlag $true

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMTicketTask -parentId 12345 -id 2 -PatchOperations @(
        @{ op = 'replace'; path = 'notes'; value = 'Done, see resolution' }
        @{ op = 'replace'; path = 'closedFlag'; value = $true }
    )

    Changes the notes and closes task 2 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated ticket task.
#>
function Update-CWMTicketTask {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 4, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/service/tickets/$($parentId)/tasks/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
