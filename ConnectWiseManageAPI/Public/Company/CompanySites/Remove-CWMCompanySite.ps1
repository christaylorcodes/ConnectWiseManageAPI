<#
.SYNOPSIS
    Deletes a site of a company.

.DESCRIPTION
    Deletes a site of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/sites/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of the site to delete.

.EXAMPLE
    Remove-CWMCompanySite -parentId 12 -id 5

    Deletes site 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$id
    )
    $Endpoint = "/company/companies/$($parentId)/sites/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
