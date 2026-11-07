<#
.SYNOPSIS
    Updates a time entry in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing time entry.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /time/entries/{id}

.PARAMETER id
    The ID of the time entry to update.
    Alias: entryId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'notes'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMTimeEntry -id 5000 -Operation replace -Path 'notes' -Value 'Replaced the switch'

    Replaces the notes of time entry 5000.

.EXAMPLE
    Update-CWMTimeEntry 5000 replace notes 'Replaced the switch'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMTimeEntry -id 5000 -PatchOperations @(
        @{ op = 'replace'; path = 'notes'; value = 'Replaced the switch' }
        @{ op = 'replace'; path = 'billableOption'; value = 'DoNotBill' }
    )

    Changes the notes and billable option of time entry 5000 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated time entry.
#>
function Update-CWMTimeEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('entryId')]
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

    $Endpoint = "/time/entries/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
