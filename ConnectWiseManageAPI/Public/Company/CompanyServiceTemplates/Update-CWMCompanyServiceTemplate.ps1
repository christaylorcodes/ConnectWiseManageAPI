<#
.SYNOPSIS
    Updates a company service template in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company service template.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.
    To replace the whole template, use Set-CWMCompanyServiceTemplate.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/serviceTemplates/{id}

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template to update (required).
    Alias: templateId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The template property to change, for example 'summary' or 'priority'.

.PARAMETER Value
    The new value for the property.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -Operation replace -Path 'summary' -Value 'Monthly maintenance'

    Replaces the summary of service template 15 of company 250.

.EXAMPLE
    Update-CWMCompanyServiceTemplate 250 15 replace summary 'Monthly maintenance'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -PatchOperations @(
        @{ op = 'replace'; path = 'summary'; value = 'Monthly maintenance' }
        @{ op = 'replace'; path = 'priority'; value = @{ id = 4 } }
    )

    Changes the summary and priority in one request.

.NOTES
    Endpoint: PATCH /company/companies/{parentId}/serviceTemplates/{id}

    Based on PR #82 by mdewart-Centre. #82 accepted only -PatchOperations; -Operation/-Path/-Value were
    added to match the other Update-CWM* functions.

.LINK
    Get-CWMCompanyServiceTemplate

.LINK
    Set-CWMCompanyServiceTemplate

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company service template.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMCompanyServiceTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('templateId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Mandatory = $true, Position = 4, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
