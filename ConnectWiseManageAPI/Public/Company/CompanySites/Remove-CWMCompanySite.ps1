function Remove-CWMCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$id
    )
    $Endpoint = "/company/companies/$($parentId)/sites/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
