<#
.SYNOPSIS
    Updates a knowledge base article in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing knowledge base article.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/knowledgeBaseArticles/{id}

.PARAMETER id
    The ID of the knowledge base article to update (required).
    Alias: articleId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The article property to change, for example 'title' or 'resolution'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set the property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'resolution' -Value 'Reinstall the client, then reboot.'

    Replaces the resolution text of article 42.

.EXAMPLE
    Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'title' -Value 'Reset VPN client' -WhatIf

    Shows the request that would be sent without changing the article.

.EXAMPLE
    Update-CWMKnowledgeBaseArticle -id 42 -PatchOperations @(
        @{ op = 'replace'; path = 'title'; value = 'Reset VPN client' }
        @{ op = 'replace'; path = 'resolution'; value = 'Reinstall the client, then reboot.' }
    )

    Changes the title and resolution of article 42 in one request.

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('articleId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/service/knowledgeBaseArticles/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
