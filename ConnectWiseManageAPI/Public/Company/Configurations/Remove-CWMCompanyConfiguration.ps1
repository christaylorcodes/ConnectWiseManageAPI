function Remove-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$CompanyConfigurationID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/configurations/$CompanyConfigurationID"
    return Invoke-CWMDeleteMaster -Arguments $PsBoundParameters -URI $URI
}
