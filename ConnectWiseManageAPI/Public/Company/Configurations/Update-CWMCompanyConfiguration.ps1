<#
.SYNOPSIS
    Updates a company configuration in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company configuration.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/configurations/{id}

.PARAMETER id
    The ID of the configuration to update.
    Alias: configurationId

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
    Update-CWMCompanyConfiguration -id 5501 -Operation replace -Path 'name' -Value 'FILESRV01'

    Renames configuration 5501.

.EXAMPLE
    Update-CWMCompanyConfiguration 5501 replace name 'FILESRV01'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanyConfiguration -id 5501 -PatchOperations @(
        @{ op = 'replace'; path = 'name'; value = 'FILESRV01' }
        @{ op = 'replace'; path = 'serialNumber'; value = 'ABC123' }
        @{ op = 'replace'; path = 'status'; value = @{ id = 2 } }
    )

    Changes the name, serial number and status of configuration 5501 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company configuration.
#>
function Update-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('configurationId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add','replace','remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/company/configurations/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
