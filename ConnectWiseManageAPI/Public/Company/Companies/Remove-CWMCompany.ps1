<#
.SYNOPSIS
    Deletes a company from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a company record by ID. This action cannot be undone.

    WARNING: Deleting a company will affect all related records including contacts,
    tickets, agreements, projects, and more. Consider marking the company as inactive
    instead of deleting to preserve data integrity.

    This function calls the ConnectWise Manage API endpoint: DELETE /company/companies/{id}

.PARAMETER id
    The company ID to delete (required).
    Alias: companyId

.EXAMPLE
    Remove-CWMCompany -id 250

    Deletes company with ID 250.

.EXAMPLE
    Remove-CWMCompany -id 250 -Confirm:$false

    Deletes the company without confirmation prompt.

.EXAMPLE
    Remove-CWMCompany -id 250 -WhatIf

    Shows what would happen without actually deleting.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Important:
    - This action is permanent and cannot be undone
    - Affects all related records (contacts, tickets, agreements, etc.)
    - Consider using inactive status instead of deletion
    - Supports -WhatIf and -Confirm for safety

    Alternative to Deletion:
    Mark company as inactive instead:
    Update-CWMCompany -id 250 -Operation 'replace' -Path 'status' -Value @{ id = 2 }

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
