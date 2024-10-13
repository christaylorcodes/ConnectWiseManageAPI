function New-CWMKnowledgeBaseSubCategory {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Alias('subCategoryId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1,50)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [hashtable]$category,
        [hashtable]$location,
        [hashtable]$department,
        [hashtable]$_info
        
    )

    $Endpoint = "/service/knowledgeBaseSubCategories"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
