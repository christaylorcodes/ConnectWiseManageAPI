function Remove-CWMCompanyTypeAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$CompanyID,
        [Parameter(Mandatory=$true)]
        [int]$TypeAssociationID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/companies/$CompanyID/typeAssociations/$TypeAssociationID"
    return Invoke-CWMDeleteMaster -URI $URI
}
