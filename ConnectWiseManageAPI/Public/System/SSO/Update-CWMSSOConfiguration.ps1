<#
.SYNOPSIS
    Updates an SSO configuration in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing SSO configuration.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /system/ssoConfigurations/{id}

.PARAMETER id
    The ID of the SSO configuration to update.

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
    Update-CWMSSOConfiguration -id 1 -Operation replace -Path 'name' -Value 'Azure AD'

    Renames SSO configuration 1.

.EXAMPLE
    Update-CWMSSOConfiguration 1 replace name 'Azure AD'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMSSOConfiguration -id 1 -PatchOperations @(
        @{ op = 'replace'; path = 'name'; value = 'Azure AD' }
        @{ op = 'replace'; path = 'inactiveFlag'; value = $false }
    )

    Renames and re-activates SSO configuration 1 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated SSO configuration.
#>
function Update-CWMSSOConfiguration {
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

    $Endpoint = "/system/ssoConfigurations/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
