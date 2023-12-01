function Remove-CWMCompanyNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('CompanyID')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$NoteId
    )

    $Endpoint = "/company/companies/$ParentID/notes/$NoteId"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}