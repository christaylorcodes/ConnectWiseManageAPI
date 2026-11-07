<#
.SYNOPSIS
    Deletes a company type association of a company.

.DESCRIPTION
    Deletes a company type association of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/typeAssociations/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of the company type association to delete.
    Alias: typeAssociationId

.EXAMPLE
    Remove-CWMCompanyTypeAssociation -parentId 12 -id 5

    Deletes company type association 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyTypeAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [Alias('typeAssociationId')]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/typeAssociations/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
