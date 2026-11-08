<#
.SYNOPSIS
    Updates a user defined field in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing user defined field.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /system/userDefinedFields/{id}

.PARAMETER id
    The id of the user defined field to update.
    Alias: userDefinedFieldId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'helpText'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMUserDefinedField -id 5 -Operation replace -Path 'helpText' -Value 'Customer contract number'

    Sets helpText of user defined field 5.

.EXAMPLE
    Update-CWMUserDefinedField 5 replace helpText 'Customer contract number'

    The same change, using positional parameters.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated user defined field.
#>
function Update-CWMUserDefinedField {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('userDefinedFieldId')]
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

    $Endpoint = "/system/userDefinedFields/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
