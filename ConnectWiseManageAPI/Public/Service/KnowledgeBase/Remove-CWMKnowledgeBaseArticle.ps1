<#
.SYNOPSIS
    Deletes a knowledge base article from ConnectWise Manage.

.DESCRIPTION
    Permanently removes a knowledge base article by ID.
    Prompts for confirmation by default (ConfirmImpact High). Use -Confirm:$false to skip the prompt.

    This function calls the ConnectWise Manage API endpoint: DELETE /service/knowledgeBaseArticles/{id}

.PARAMETER id
    The ID of the knowledge base article to delete (required).
    Alias: articleId

.EXAMPLE
    Remove-CWMKnowledgeBaseArticle -id 42

    Deletes article 42 after confirmation.

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

.INPUTS
    None. This function does not accept pipeline input.
#>
function Remove-CWMKnowledgeBaseArticle {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('articleId')]
        [int]$id
    )

    $Endpoint = "/service/knowledgeBaseArticles/$($id)"
    # Confirm here, at High impact. Invoke-CWMRemoveMaster defaults to Medium impact and would not prompt on its own.
    if ($PSCmdlet.ShouldProcess("Knowledge base article $id", 'Remove')) {
        Invoke-CWMRemoveMaster -Endpoint $Endpoint -Confirm:$false
    }
}
