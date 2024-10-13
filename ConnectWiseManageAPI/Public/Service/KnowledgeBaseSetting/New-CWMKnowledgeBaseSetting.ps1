function New-CWMKnowledgeBaseSetting {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Alias('settingId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [bool]$requireApproval,
        [Parameter(Mandatory = $true)]
        [hashtable]$defaultApprover,
        [hashtable]$_info
        
    )

    $Endpoint = "/service/knowledgebasesettings"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
