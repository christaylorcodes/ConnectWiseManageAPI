function New-CWMMarketingGroupCompany {
    # 2021.1
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Alias('parentId')]
        [int]$groupId,
        [Alias('companyId')]
        [int]$id,
        [boolean]$defaultContactFlag,
        [boolean]$allContactsFlag,
        [boolean]$unsubscribeFlag
    )

    $Endpoint = "/marketing/groups/$($groupId)/companies"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
