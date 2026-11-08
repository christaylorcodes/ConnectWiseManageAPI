<#
.SYNOPSIS
    Deletes a company from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a company record by ID. This action cannot be undone.

    ConnectWise Manage decides what happens to related records (contacts, tickets,
    agreements, projects) and may refuse the delete. Consider marking the company as
    inactive instead of deleting it to preserve history.

    ConfirmImpact is Medium, so with the default $ConfirmPreference (High) there is no
    confirmation prompt: the company is deleted immediately. Use -Confirm to be prompted
    or -WhatIf to preview.

    This function calls the ConnectWise Manage API endpoint: DELETE /company/companies/{id}

.PARAMETER id
    The company ID to delete (required).
    Alias: companyId

.EXAMPLE
    Remove-CWMCompany -id 250

    Deletes company with ID 250.

.EXAMPLE
    Remove-CWMCompany -id 250 -Confirm

    Prompts for confirmation before deleting the company.

.EXAMPLE
    Remove-CWMCompany -id 250 -WhatIf

    Shows what would happen without actually deleting.

.NOTES
    Author: Chris Taylor

    Important:
    - This action is permanent and cannot be undone
    - ConnectWise Manage may reject the delete when related records exist
    - Consider using an inactive status instead of deletion
    - Supports -WhatIf and -Confirm (no prompt by default)

    Alternative to Deletion:
    Mark the company inactive instead. Status IDs differ per instance, so look the ID up first:
    $Inactive = Get-CWMCompanyStatus -condition "inactiveFlag=true" | Select-Object -First 1
    Update-CWMCompany -id 250 -Operation 'replace' -Path 'status' -Value @{ id = $Inactive.id }

.LINK
    https://developer.connectwise.com/manage/rest#/Companies

.LINK
    Get-CWMCompany

.LINK
    New-CWMCompany

.LINK
    Update-CWMCompany

#>
function Remove-CWMCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$id
    )
    $Endpoint = "/company/companies/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
