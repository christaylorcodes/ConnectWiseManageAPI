<#
.SYNOPSIS
    Unlinks a company service template in ConnectWise Manage.

.DESCRIPTION
    Calls the 'unlink' action of a company service template. The request is a POST with no body;
    the template itself is not deleted (use Remove-CWMCompanyServiceTemplate for that).

    This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/unlink

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template (required).
    Alias: templateId

.EXAMPLE
    Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15

    Unlinks service template 15 of company 250.

.NOTES
    Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/unlink

    Based on PR #82 by mdewart-Centre.

.LINK
    Add-CWMCompanyServiceTemplateLink

.LINK
    Remove-CWMCompanyServiceTemplate

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
function Remove-CWMCompanyServiceTemplateLink {
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

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/unlink"
    Invoke-CWMActionMaster -Endpoint $Endpoint
}
