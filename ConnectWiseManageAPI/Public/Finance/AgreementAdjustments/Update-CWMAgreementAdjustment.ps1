<#
.SYNOPSIS
    Updates an agreement adjustment in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing agreement adjustment.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /finance/agreements/{parentId}/adjustments/{id}

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement adjustment to update.
    Alias: adjustmentId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'amount'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMAgreementAdjustment -parentId 12 -id 5 -Operation replace -Path 'amount' -Value -75

    Sets amount of agreement adjustment 5 of agreement 12.

.EXAMPLE
    Update-CWMAgreementAdjustment 12 5 replace amount -75

    The same change, using positional parameters.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated agreement adjustment.
#>
function Update-CWMAgreementAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('adjustmentId')]
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

    $Endpoint = "/finance/agreements/$($parentId)/adjustments/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
