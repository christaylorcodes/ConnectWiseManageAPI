<#
.SYNOPSIS
    Deletes an agreement adjustment of an agreement.

.DESCRIPTION
    Deletes an agreement adjustment from ConnectWise Manage. Calls DELETE /finance/agreements/{parentId}/adjustments/{id}.

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement adjustment to delete.
    Alias: adjustmentId

.EXAMPLE
    Remove-CWMAgreementAdjustment -parentId 12 -id 5

    Deletes agreement adjustment 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('adjustmentId')]
        [int]$id
    )

    $Endpoint = "/finance/agreements/$($parentId)/adjustments/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
