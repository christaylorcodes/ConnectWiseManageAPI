function Get-CWMKnowledgeBaseArticle {
    [CmdletBinding()]
    param(
        [Alias('kbId')]
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        $orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/service/knowledgeBaseArticles'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}