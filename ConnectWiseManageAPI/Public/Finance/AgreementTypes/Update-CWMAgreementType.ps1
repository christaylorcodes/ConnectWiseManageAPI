<#
.SYNOPSIS
    Updates an agreement type in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing agreement type.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /finance/agreements/types/{id}

.PARAMETER id
    The ID of the agreement type to update.
    Alias: agreementId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'name'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMAgreementType -id 8 -Operation replace -Path 'name' -Value 'Block Time'

    Renames agreement type 8.

.EXAMPLE
    Update-CWMAgreementType 8 replace name 'Block Time'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMAgreementType -id 8 -PatchOperations @(
        @{ op = 'replace'; path = 'name'; value = 'Block Time (old)' }
        @{ op = 'replace'; path = 'inactiveFlag'; value = $true }
    )

    Renames agreement type 8 and marks it inactive in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated agreement type.
#>
function Update-CWMAgreementType {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('agreementId')]
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

    $Endpoint = "/finance/agreements/types/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
