<#
.SYNOPSIS
    Updates a company team member in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company team member.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/teams/{id}

.PARAMETER parentId
    The ID of the company.
    Alias: companyId

.PARAMETER id
    The ID of the team entry to update.
    Alias: teamId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'teamRole'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyTeam -parentId 250 -id 4 -Operation replace -Path 'teamRole' -Value @{ id = 2 }

    Changes the team role of team entry 4 of company 250.

.EXAMPLE
    Update-CWMCompanyTeam 250 4 replace teamRole @{ id = 2 }

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanyTeam -parentId 250 -id 4 -PatchOperations @(
        @{ op = 'replace'; path = 'teamRole'; value = @{ id = 2 } }
        @{ op = 'replace'; path = 'accountManagerFlag'; value = $true }
    )

    Changes the team role and account manager flag in one request.

.NOTES
    Endpoint: PATCH /company/companies/{parentId}/teams/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company team member.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMCompanyTeam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('teamId')]
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

    $Endpoint = "/company/companies/$($parentId)/teams/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
