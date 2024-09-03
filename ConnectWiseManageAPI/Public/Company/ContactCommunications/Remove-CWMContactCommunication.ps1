function Remove-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('contactId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('communicationId')]
        [int]$id
    )
    $Endpoint = "/company/contacts/$($parentId)/communications/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
