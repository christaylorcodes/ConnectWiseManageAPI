function Remove-CWMMarketingGroupCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('companyId')]
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $Endpoint = "/marketing/groups/$($parentId)/companies/$($id)"
    return Invoke-CWMDeleteMaster -Endpoint $Endpoint
}
