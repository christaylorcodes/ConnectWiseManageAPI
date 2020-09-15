function New-CWMCompanyTypeAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$id,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [hashtable]$company,
        [hashtable]$_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/companyTypeAssociations"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
