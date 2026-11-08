<#
.SYNOPSIS
    Deletes an agreement site of an agreement.

.DESCRIPTION
    Deletes an agreement site of an agreement from ConnectWise Manage. Calls DELETE
    /finance/agreements/{parentId}/sites/{id}.

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement site to delete.
    Alias: siteId

.EXAMPLE
    Remove-CWMAgreementSite -parentId 12 -id 5

    Deletes agreement site 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementSite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('siteId')]
        [int]$id
    )

    $Endpoint = "/finance/agreements/$($parentId)/sites/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
