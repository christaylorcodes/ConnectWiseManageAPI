function Remove-CWMMarketingGroupCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$ID,
        [Parameter(Mandatory=$true)]
        [int]$CompanyId
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/marketing/groups/$($ID)/companies/$($CompanyId)"
    return Invoke-CWMDeleteMaster -URI $URI
}
