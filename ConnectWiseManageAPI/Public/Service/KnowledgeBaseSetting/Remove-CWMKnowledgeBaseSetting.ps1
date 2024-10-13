function Remove-CWMKnowledgeBaseSetting {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('settingId')]
        [int]$id
    )
    $Endpoint = "/service/knowledgebasesettings/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
