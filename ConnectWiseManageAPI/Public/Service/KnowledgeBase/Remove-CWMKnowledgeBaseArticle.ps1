<#
.SYNOPSIS
    Deletes a knowledge base article from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a knowledge base article by ID.
    Like the other Remove-CWM* functions, it does not prompt by default; use -Confirm to be prompted
    or -WhatIf to see what would be deleted.

    This function calls the ConnectWise Manage API endpoint: DELETE /service/knowledgeBaseArticles/{id}

.PARAMETER id
    The ID of the knowledge base article to delete (required).
    Alias: articleId

.EXAMPLE
    Remove-CWMKnowledgeBaseArticle -id 42 -Confirm

    Prompts for confirmation, then deletes article 42.

.EXAMPLE
    Remove-CWMKnowledgeBaseArticle -id 42 -WhatIf

    Shows what would be deleted without deleting it.

.NOTES
    Endpoint: DELETE /service/knowledgeBaseArticles/{id}

    Requested in GitHub issue #59.

.LINK
    Get-CWMKnowledgeBaseArticle

.LINK
    New-CWMKnowledgeBaseArticle

.LINK
    Update-CWMKnowledgeBaseArticle

.LINK
    https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles
#>
function Remove-CWMKnowledgeBaseArticle {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('articleId')]
        [int]$id
    )

    $Endpoint = "/service/knowledgeBaseArticles/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
