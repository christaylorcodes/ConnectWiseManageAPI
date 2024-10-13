function Remove-CWMKnowledgeBaseSubCategory {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('subCategoryId')]
        [int]$id
    )
    $Endpoint = "/service/knowledgeBaseSubCategories/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
