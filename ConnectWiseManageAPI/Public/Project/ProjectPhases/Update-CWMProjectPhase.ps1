<#
.SYNOPSIS
    Updates a project phase in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing project phase.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /project/projects/{parentId}/phases/{id}

.PARAMETER parentId
    The ID of the project.
    Alias: projectId

.PARAMETER id
    The ID of the phase to update.
    Alias: phaseId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'description'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMProjectPhase -parentId 100 -id 5 -Operation replace -Path 'description' -Value 'Deployment'

    Renames phase 5 of project 100.

.EXAMPLE
    Update-CWMProjectPhase 100 5 replace description 'Deployment'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMProjectPhase -parentId 100 -id 5 -PatchOperations @(
        @{ op = 'replace'; path = 'description'; value = 'Deployment' }
        @{ op = 'replace'; path = 'budgetHours'; value = 40 }
    )

    Changes the description and budget hours of phase 5 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated project phase.
#>
function Update-CWMProjectPhase {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('projectId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('phaseId')]
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

    $Endpoint = "/project/projects/$($parentId)/phases/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
