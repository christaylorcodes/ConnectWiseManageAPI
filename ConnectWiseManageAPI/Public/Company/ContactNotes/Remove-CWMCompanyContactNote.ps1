function Remove-CWMCompanyContactNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias('Remove-CWMContactNote')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('contactId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('noteId')]
        [int]$id
    )
    $Endpoint = "/company/contacts/$($parentId)/notes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
