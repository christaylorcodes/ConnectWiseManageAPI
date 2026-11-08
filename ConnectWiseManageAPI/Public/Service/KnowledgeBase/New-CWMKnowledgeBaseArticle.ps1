<#
.SYNOPSIS
    Creates a knowledge base article in ConnectWise Manage.

.DESCRIPTION
    Creates a new knowledge base article in the ConnectWise Manage service module.
    The bound parameters are sent as the JSON body of the request.

    This function calls the ConnectWise Manage API endpoint: POST /service/knowledgeBaseArticles

.PARAMETER title
    The title of the article (required).

.PARAMETER issue
    The issue or problem the article describes (required).

.PARAMETER resolution
    The resolution or answer for the issue (required).

.PARAMETER locationId
    The ID of the location the article belongs to.

.PARAMETER businessUnitId
    The ID of the business unit the article belongs to.

.PARAMETER board
    A reference to the service board for the article.
    Example: @{ id = 1 }

.PARAMETER categoryId
    The ID of the knowledge base category.

.PARAMETER subCategoryId
    The ID of the knowledge base sub-category.

.EXAMPLE
    New-CWMKnowledgeBaseArticle -title 'Reset VPN client' -issue 'VPN client will not connect' -resolution 'Reinstall the client and reboot.'

    Creates a new knowledge base article.

.EXAMPLE
    $Article = @{
        title      = 'Printer offline'
        issue      = 'Printer shows offline on all workstations'
        resolution = 'Power cycle the printer and re-add the port.'
        board      = @{ id = 1 }
    }
    New-CWMKnowledgeBaseArticle @Article

    Creates an article linked to service board 1 using splatting.

.NOTES
    Endpoint: POST /service/knowledgeBaseArticles

    Requested in GitHub issue #59.

.LINK
    Get-CWMKnowledgeBaseArticle

.LINK
    Update-CWMKnowledgeBaseArticle

.LINK
    Remove-CWMKnowledgeBaseArticle

.LINK
    https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles

.OUTPUTS
    PSCustomObject
    Returns the created knowledge base article.
#>
function New-CWMKnowledgeBaseArticle {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
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
        [int]$subCategoryId
    )

    $Endpoint = '/service/knowledgeBaseArticles'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
