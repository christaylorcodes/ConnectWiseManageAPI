function Remove-CWMKnowledgeBaseArticle {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('kbId')]
        [int]$id
    )
    $Endpoint = "/service/knowledgeBaseArticles/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
