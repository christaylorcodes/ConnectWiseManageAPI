function Remove-CWMCompanyContact {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    [Alias('Remove-CWMContact')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$id
    )

    $Endpoint = "/company/contacts/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}