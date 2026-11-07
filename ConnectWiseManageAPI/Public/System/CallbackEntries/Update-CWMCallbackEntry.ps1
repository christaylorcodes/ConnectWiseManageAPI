<#
.SYNOPSIS
    Updates a callback entry in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing callback.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /system/callbacks/{id}

.PARAMETER id
    The ID of the Callback that you are updating.
    Alias: callbackId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'url'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCallbackEntry -id 15 -Operation replace -Path 'url' -Value 'https://example.com/hook'

    Replaces the URL of callback 15.

.EXAMPLE
    Update-CWMCallbackEntry 15 replace url 'https://example.com/hook'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCallbackEntry -id 15 -PatchOperations @(
        @{ op = 'replace'; path = 'url'; value = 'https://example.com/hook' }
        @{ op = 'replace'; path = 'inactiveFlag'; value = $false }
    )

    Changes the URL and re-activates callback 15 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated callback.
#>
function Update-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('callbackId')]
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

    $Endpoint = "/system/callbacks/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
