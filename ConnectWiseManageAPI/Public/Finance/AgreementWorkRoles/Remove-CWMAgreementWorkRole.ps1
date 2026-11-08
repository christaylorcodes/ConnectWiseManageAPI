<#
.SYNOPSIS
    Deletes an agreement work role rate of an agreement.

.DESCRIPTION
    Deletes an agreement work role rate from ConnectWise Manage. Calls DELETE /finance/agreements/{parentId}/workroles/{id}.

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.PARAMETER id
    The id of the agreement work role rate to delete.
    Alias: agreementWorkRoleId

.EXAMPLE
    Remove-CWMAgreementWorkRole -parentId 12 -id 5

    Deletes agreement work role rate 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementWorkRole {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('agreementWorkRoleId')]
        [int]$id
    )

    $Endpoint = "/finance/agreements/$($parentId)/workroles/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
