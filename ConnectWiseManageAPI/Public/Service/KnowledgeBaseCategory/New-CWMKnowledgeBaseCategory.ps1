function New-CWMKnowledgeBaseCategory {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Alias('categoryId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1,50)]
        [string]$name,
        [hashtable]$location,
        [hashtable]$department,
        [hashtable]$approver,
        [hashtable]$_info
        
    )

    $Endpoint = "/service/knowledgeBaseCategories"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
