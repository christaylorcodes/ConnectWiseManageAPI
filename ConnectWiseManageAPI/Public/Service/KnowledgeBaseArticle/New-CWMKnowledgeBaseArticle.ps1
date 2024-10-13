function New-CWMKnowledgeBaseArticle {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Alias('kbId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [string]$title,
        [Parameter(Mandatory = $true)]
        [string]$issue,
        [Parameter(Mandatory = $true)]
        [string]$resolution,
        [int]$locationId,
        [int]$businessUnitId,
        [hashtable]$board,
        [int]$categoryId,
        [int]$subCategoryId,
        [string]$dateCreated,
        [string]$createdBy,
        [hashtable]$_info
        
    )

    $Endpoint = "/service/knowledgeBaseArticles"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
