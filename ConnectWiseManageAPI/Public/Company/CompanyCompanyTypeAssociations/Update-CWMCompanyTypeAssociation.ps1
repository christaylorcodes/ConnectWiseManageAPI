<#
.SYNOPSIS
    Updates a company type association in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company type association.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/typeAssociations/{id}

.PARAMETER parentId
    The ID of the company.
    Alias: companyId

.PARAMETER id
    The ID of the company type association to update.
    Alias: typeAssociationId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'type'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyTypeAssociation -parentId 250 -id 3 -Operation replace -Path 'type' -Value @{ id = 5 }

    Changes type association 3 of company 250 to company type 5.

.EXAMPLE
    Update-CWMCompanyTypeAssociation 250 3 replace type @{ id = 5 }

    The same change, using positional parameters.

.EXAMPLE
    $

    U

.EXAMPLE
    C

    h

.EXAMPLE
    Update-CWMCompanyTypeAssociation -parentId 250 -id 3 -PatchOperations @(
        @{ op = 'replace'; path = 'type'; value = @{ id = 5 } }
    )

    Sends the same change with -PatchOperations. Add more operations to the array to change several properties in one request.

.NOTES
    Endpoint: PATCH /company/companies/{parentId}/typeAssociations/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company type association.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMCompanyTypeAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('typeAssociationId')]
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

    $Endpoint = "/company/companies/$($parentId)/typeAssociations/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
