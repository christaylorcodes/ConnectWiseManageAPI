function Remove-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('companyConfigurationId')]
        [int]$id
    )

    $Endpoint = "/company/configurations/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
