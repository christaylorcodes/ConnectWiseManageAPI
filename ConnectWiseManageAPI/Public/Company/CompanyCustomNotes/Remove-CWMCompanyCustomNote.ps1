<#
.SYNOPSIS
    Deletes a custom status note of a company.

.DESCRIPTION
    Deletes a custom status note of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/customStatusNotes/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: CompanyID

.PARAMETER id
    The id of the custom status note to delete.

.EXAMPLE
    Remove-CWMCompanyCustomNote -parentId 12 -id 5

    Deletes custom status note 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyCustomNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('CompanyID')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/customStatusNotes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}