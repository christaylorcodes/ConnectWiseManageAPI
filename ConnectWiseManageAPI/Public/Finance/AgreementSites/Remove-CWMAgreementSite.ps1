function Remove-CWMAgreementSite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [Alias('siteId')]
        [int]$id
    )

    $Endpoint = "/finance/agreements/$($parentId)/sites/$($id)"
    return Invoke-CWMDeleteMaster -Endpoint $Endpoint
}
