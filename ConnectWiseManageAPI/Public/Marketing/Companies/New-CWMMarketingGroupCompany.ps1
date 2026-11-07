function New-CWMMarketingGroupCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        # Route id only: parentId is never sent in the request body (groupId was, before it became an alias)
        [Parameter(Mandatory = $true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('companyId')]
        [int]$id,
        [boolean]$defaultContactFlag,
        [boolean]$allContactsFlag,
        [boolean]$unsubscribeFlag
    )

    $Endpoint = "/marketing/groups/$($parentId)/companies"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
