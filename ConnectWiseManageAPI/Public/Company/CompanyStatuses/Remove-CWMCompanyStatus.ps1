function Remove-CWMCompanyStatus {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('statusId')]
        [int]$id
    )
    $Endpoint = "/company/companies/statuses/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
