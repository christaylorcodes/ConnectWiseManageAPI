<#
.SYNOPSIS
    Updates a project ticket in ConnectWise Manage.

.DESCRIPTION
    You can execute a patch method against a Manage project ticket.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /project/tickets/{id}

.PARAMETER id
    The ID of the project ticket to update.
    Alias: ticketID

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'board/id'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMProjectTicket -id 123 -Operation replace -Path 'board/id' -Value 1

    Moves project ticket 123 to board 1.

.EXAMPLE
    Update-CWMProjectTicket 123 replace board/id 1

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMProjectTicket -id 123 -PatchOperations @(
        @{ op = 'replace'; path = 'summary'; value = 'Configure backups' }
        @{ op = 'replace'; path = 'status'; value = @{ id = 5 } }
    )

    Changes the summary and status of project ticket 123 in one request.

.NOTES
    Endpoint: PATCH /project/tickets/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated project ticket.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMProjectTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('ticketID')]
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

    $Endpoint = "/project/tickets/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
