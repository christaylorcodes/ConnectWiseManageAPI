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
