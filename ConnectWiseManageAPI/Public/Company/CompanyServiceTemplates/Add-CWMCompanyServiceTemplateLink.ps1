<#
.SYNOPSIS
    Links a company service template in ConnectWise Manage.

.DESCRIPTION
    Calls the 'link' action of a company service template. The request is a POST with no body.

    This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/link

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template (required).
    Alias: templateId

.EXAMPLE
    Add-CWMCompanyServiceTemplateLink -parentId 250 -id 15

    Links service template 15 of company 250.

.NOTES
    Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/link

    Based on PR #82 by mdewart-Centre.

.LINK
    Remove-CWMCompanyServiceTemplateLink

.LINK
    Get-CWMCompanyServiceTemplate

.LINK
    Invoke-CWMActionMaster

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the API response, when there is one.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Add-CWMCompanyServiceTemplateLink {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/link"
    Invoke-CWMActionMaster -Endpoint $Endpoint
}
