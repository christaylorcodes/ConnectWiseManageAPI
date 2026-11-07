<#
.SYNOPSIS
    Copies a company service template in ConnectWise Manage.

.DESCRIPTION
    Calls the 'copy' action of a company service template. The request is a POST with no body.

    This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/copy

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template to copy (required).
    Alias: templateId

.EXAMPLE
    Copy-CWMCompanyServiceTemplate -parentId 250 -id 15

    Copies service template 15 of company 250.

.NOTES
    Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/copy

    Based on PR #82 by mdewart-Centre.

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
function Copy-CWMCompanyServiceTemplate {
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

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/copy"
    Invoke-CWMActionMaster -Endpoint $Endpoint
}
