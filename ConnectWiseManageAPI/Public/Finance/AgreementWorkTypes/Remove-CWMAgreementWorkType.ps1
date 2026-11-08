<#
.SYNOPSIS
    Deletes an agreement work type rate of an agreement.

.DESCRIPTION
    Deletes an agreement work type rate from ConnectWise Manage. Calls DELETE /finance/agreements/{parentId}/worktypes/{id}.

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement work type rate to delete.
    Alias: agreementWorkTypeId

.EXAMPLE
    Remove-CWMAgreementWorkType -parentId 12 -id 5

    Deletes agreement work type rate 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementWorkType {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('agreementWorkTypeId')]
        [int]$id
    )

    $Endpoint = "/finance/agreements/$($parentId)/worktypes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
