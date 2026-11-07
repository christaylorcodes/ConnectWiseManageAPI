<#
.SYNOPSIS
    Updates the properties of a ConnectWise Manage member.

.DESCRIPTION
    Applies JSON Patch operations to an existing member.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /system/members/{id}

.PARAMETER id
    The ID of the member you want to update.
    Alias: memberId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'firstName'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMMember -id 150 -Operation replace -Path 'firstName' -Value 'Chris'

    Replaces the first name of member 150.

.EXAMPLE
    Update-CWMMember 150 replace firstName 'Chris'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMMember -id 150 -PatchOperations @(
        @{ op = 'replace'; path = 'firstName'; value = 'Chris' }
        @{ op = 'replace'; path = 'title'; value = 'Engineer' }
    )

    Changes the first name and title of member 150 in one request.

.NOTES
    Endpoint: PATCH /system/members/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated member.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMMember {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('memberId')]
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

    $Endpoint = "/system/members/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
