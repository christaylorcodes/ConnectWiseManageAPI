function Remove-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$CompanyConfigurationID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/configurations/$CompanyConfigurationID"
    return Invoke-CWMDeleteMaster -URI $URI
}
