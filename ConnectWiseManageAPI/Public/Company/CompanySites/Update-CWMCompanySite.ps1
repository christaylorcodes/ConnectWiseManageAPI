<#
.SYNOPSIS
    Updates a company site in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company site.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/sites/{id}

.PARAMETER parentId
    The ID of the company.
    Alias: companyId

.PARAMETER id
    The ID of the site to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'phoneNumber'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanySite -parentId 250 -id 12 -Operation replace -Path 'phoneNumber' -Value '2065559999'

    Replaces the phone number of site 12 of company 250.

.EXAMPLE
    Update-CWMCompanySite 250 12 replace phoneNumber '2065559999'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanySite -parentId 250 -id 12 -PatchOperations @(
        @{ op = 'replace'; path = 'addressLine1'; value = '100 Main St' }
        @{ op = 'replace'; path = 'city'; value = 'Tampa' }
        @{ op = 'remove'; path = 'addressLine2' }
    )

    Changes the address and clears address line 2 of site 12 in one request.

.NOTES
    Endpoint: PATCH /company/companies/{parentId}/sites/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company site.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
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

    $Endpoint = "/company/companies/$($parentId)/sites/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
