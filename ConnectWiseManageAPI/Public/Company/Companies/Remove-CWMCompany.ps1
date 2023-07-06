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
