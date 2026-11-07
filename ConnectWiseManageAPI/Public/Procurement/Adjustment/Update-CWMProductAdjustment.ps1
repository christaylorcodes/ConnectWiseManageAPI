<#
.SYNOPSIS
    Updates an inventory adjustment in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing inventory adjustment.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /procurement/adjustments/{id}

.PARAMETER id
    The ID of the adjustment to update.
    Alias: catalogId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'reason'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMProductAdjustment -id 40 -Operation replace -Path 'reason' -Value 'Cycle count'

    Replaces the reason of adjustment 40.

.EXAMPLE
    Update-CWMProductAdjustment 40 replace reason 'Cycle count'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMProductAdjustment -id 40 -PatchOperations @(
        @{ op = 'replace'; path = 'reason'; value = 'Cycle count' }
        @{ op = 'replace'; path = 'closedFlag'; value = $true }
    )

    Changes the reason and closes adjustment 40 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated inventory adjustment.
#>
function Update-CWMProductAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('catalogId')]
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

    $Endpoint = "/procurement/adjustments/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
