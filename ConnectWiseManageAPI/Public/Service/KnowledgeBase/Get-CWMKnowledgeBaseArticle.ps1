<#
.SYNOPSIS
    Retrieves knowledge base articles from ConnectWise Manage.

.DESCRIPTION
    Gets knowledge base articles from the ConnectWise Manage service module.
    Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

    This function calls the ConnectWise Manage API endpoint: GET /service/knowledgeBaseArticles

.PARAMETER id
    The unique identifier of a specific knowledge base article.
    When specified, returns only that article (GET /service/knowledgeBaseArticles/{id}).
    Alias: articleId

.PARAMETER count
    Returns only the count of matching articles instead of the articles themselves
    (GET /service/knowledgeBaseArticles/count).

.PARAMETER condition
    Filter articles using ConnectWise Manage condition syntax.
    Format: "field operator value"
    Operators: =, !=, <, >, <=, >=, contains, like, in
    Multiple conditions can be combined with 'and' or 'or'
    Example: "title contains 'VPN'"

.PARAMETER orderBy
    Sort results by specified field and direction.
    Format: "fieldName asc" or "fieldName desc"
    Example: "id desc"

.PARAMETER childConditions
    Filter results based on child record criteria.
    Uses same condition syntax as -condition parameter.

.PARAMETER customFieldConditions
    Filter results based on custom field values.
    Format: "caption='FieldName' and value='FieldValue'"

.PARAMETER page
    The page number to retrieve (used with -pageSize for pagination).

.PARAMETER pageSize
    Number of records to return per page.

.PARAMETER fields
    Specify which fields to return in the response.
    Example: @('id', 'title', 'issue', 'resolution')

.PARAMETER all
    Retrieve all matching articles by automatically handling pagination.
    Makes multiple API calls if necessary. Use with caution on large datasets.

.EXAMPLE
    Get-CWMKnowledgeBaseArticle -id 42

    Retrieves the knowledge base article with ID 42.

.EXAMPLE
    Get-CWMKnowledgeBaseArticle -condition "title contains 'VPN'" -all

    Retrieves every knowledge base article whose title contains 'VPN'.

.EXAMPLE
    Get-CWMKnowledgeBaseArticle -count

    Returns the number of knowledge base articles.

.NOTES
    Endpoints:
    - GET /service/knowledgeBaseArticles
    - GET /service/knowledgeBaseArticles/{id}
    - GET /service/knowledgeBaseArticles/count

    Requested in GitHub issue #59.

.LINK
    New-CWMKnowledgeBaseArticle

.LINK
    Update-CWMKnowledgeBaseArticle

.LINK
    Remove-CWMKnowledgeBaseArticle

.LINK
    https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles

.OUTPUTS
    PSCustomObject or PSCustomObject[]
    Returns knowledge base article objects, or an integer if -count is specified.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Get-CWMKnowledgeBaseArticle {
    [CmdletBinding()]
    param(
        [Alias('articleId')]
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/service/knowledgeBaseArticles'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
