<#
.SYNOPSIS
    Updates a schedule entry in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing schedule entry.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /schedule/entries/{id}

.PARAMETER id
    The ID of the schedule entry to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'doneFlag'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMScheduleEntry -id 3000 -Operation replace -Path 'doneFlag' -Value $true

    Marks schedule entry 3000 as done.

.EXAMPLE
    Update-CWMScheduleEntry 3000 replace doneFlag $true

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMScheduleEntry -id 3000 -PatchOperations @(
        @{ op = 'replace'; path = 'doneFlag'; value = $true }
        @{ op = 'replace'; path = 'hours'; value = 1.5 }
    )

    Marks schedule entry 3000 as done and sets its hours in one request.

.NOTES
    Endpoint: PATCH /schedule/entries/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated schedule entry.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
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

    $Endpoint = "/schedule/entries/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
