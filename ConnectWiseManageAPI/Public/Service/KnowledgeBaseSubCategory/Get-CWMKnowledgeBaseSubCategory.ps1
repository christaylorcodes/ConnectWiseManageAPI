function Get-CWMKnowledgeBaseSubCategory {
    [CmdletBinding()]
    param(
        [Alias('subCategoryId')]
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

    $Endpoint = '/service/knowledgeBaseSubCategories'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}