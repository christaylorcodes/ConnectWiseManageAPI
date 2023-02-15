function Remove-CWMCompanyTeam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('teamId')]
        [int]$id
    )
    $Endpoint = "/company/companies/$($parentId)/teams/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}