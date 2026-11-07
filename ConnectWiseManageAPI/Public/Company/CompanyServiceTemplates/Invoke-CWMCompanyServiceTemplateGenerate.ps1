<#
.SYNOPSIS
    Runs the 'generate' action of a company service template in ConnectWise Manage.

.DESCRIPTION
    Calls the 'generate' action of a company service template. The body contains
    generateAllRecordsFlag when it is specified, otherwise it is an empty JSON object.

    This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/generate

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template (required).
    Alias: templateId

.PARAMETER generateAllRecordsFlag
    Sent as generateAllRecordsFlag in the request body.

.EXAMPLE
    Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15

    Runs the generate action for service template 15 of company 250.

.EXAMPLE
    Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 -generateAllRecordsFlag $true

    Runs the generate action with generateAllRecordsFlag set to true.

.NOTES
    Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/generate

    Based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMCompanyServiceTemplate

.LINK
    Invoke-CWMNewMaster

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the API response, when there is one.
#>
function Invoke-CWMCompanyServiceTemplateGenerate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('templateId')]
        [int]$id,
        [bool]$generateAllRecordsFlag
    )

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)/generate"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint -Skip @('id')
}
