function Remove-CWMKnowledgeBaseCategory {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('categoryId')]
        [int]$id
    )
    $Endpoint = "/service/knowledgeBaseCategories/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
