<#
.SYNOPSIS
    Deletes an agreement addition of an agreement.

.DESCRIPTION
    Deletes an agreement addition of an agreement from ConnectWise Manage. Calls DELETE
    /finance/agreements/{parentId}/additions/{id}.

.PARAMETER id
    The id of the agreement addition to delete.
    Alias: additionId

.PARAMETER parentId
    The id of the agreement.
    Alias: agreementId

.EXAMPLE
    Remove-CWMAgreementAddition -parentId 12 -id 5

    Deletes agreement addition 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementAddition {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        # Position order kept from the old signature (id first) so positional calls still bind the same way
        [Parameter(Mandatory = $true)]
        [Alias('additionId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId
    )

    $Endpoint = "/finance/agreements/$($parentId)/additions/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}