<#
.SYNOPSIS
    Updates a knowledge base article in ConnectWise Manage.

.DESCRIPTION
    Applies a single JSON Patch operation to an existing knowledge base article.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/knowledgeBaseArticles/{id}

.PARAMETER id
    The ID of the knowledge base article to update (required).
    Alias: articleId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The article property to change, for example 'title' or 'resolution'.

.PARAMETER Value
    The new value for the property.

.EXAMPLE
    Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'resolution' -Value 'Reinstall the client, then reboot.'

    Replaces the resolution text of article 42.

.EXAMPLE
    Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'title' -Value 'Reset VPN client' -WhatIf

    Shows the request that would be sent without changing the article.

.NOTES
    Endpoint: PATCH /service/knowledgeBaseArticles/{id}

    Requested in GitHub issue #59.

.LINK
    Get-CWMKnowledgeBaseArticle

.LINK
    New-CWMKnowledgeBaseArticle

.LINK
    Remove-CWMKnowledgeBaseArticle

.LINK
    https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles

.OUTPUTS
    PSCustomObject
    Returns the updated knowledge base article.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMKnowledgeBaseArticle {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('articleId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/service/knowledgeBaseArticles/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
