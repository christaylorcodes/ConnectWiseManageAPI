function Get-CWMKnowledgeBaseCategory {
    [CmdletBinding()]
    param(
        [Alias('categoryId')]
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

    $Endpoint = '/service/knowledgeBaseCategories'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}