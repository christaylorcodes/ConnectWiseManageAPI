<#
.SYNOPSIS
    Removes a service template from a company in ConnectWise Manage.

.DESCRIPTION
    Deletes a company service template. Supports -WhatIf and -Confirm.

    This function calls the ConnectWise Manage API endpoint: DELETE /company/companies/{parentId}/serviceTemplates/{id}

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    The ID of the company service template to delete (required).
    Alias: templateId

.EXAMPLE
    Remove-CWMCompanyServiceTemplate -parentId 250 -id 15

    Deletes service template 15 of company 250.

.EXAMPLE
    Remove-CWMCompanyServiceTemplate -companyId 250 -templateId 15 -WhatIf

    Shows the request that would be sent without deleting anything.

.NOTES
    Endpoint: DELETE /company/companies/{parentId}/serviceTemplates/{id}

    Based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMCompanyServiceTemplate

.LINK
    New-CWMCompanyServiceTemplate

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyServiceTemplate {
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

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
