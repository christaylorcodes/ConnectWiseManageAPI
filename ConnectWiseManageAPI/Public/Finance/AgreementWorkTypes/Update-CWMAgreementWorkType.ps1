<#
.SYNOPSIS
    Updates an agreement work type rate in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing agreement work type rate.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /finance/agreements/{parentId}/worktypes/{id}

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement work type rate to update.
    Alias: agreementWorkTypeId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'rate'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMAgreementWorkType -parentId 12 -id 5 -Operation replace -Path 'rate' -Value 1.25

    Sets rate of agreement work type rate 5 of agreement 12.

.EXAMPLE
    Update-CWMAgreementWorkType 12 5 replace rate 1.25

    The same change, using positional parameters.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated agreement work type rate.
#>
function Update-CWMAgreementWorkType {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('agreementWorkTypeId')]
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

    $Endpoint = "/finance/agreements/$($parentId)/worktypes/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
