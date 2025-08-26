function Remove-CWMCompanyCustomNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('CompanyID')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/customStatusNotes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}