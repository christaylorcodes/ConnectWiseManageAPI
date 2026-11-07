<#
.SYNOPSIS
    Deletes an agreement addition of an agreement.

.DESCRIPTION
    Deletes an agreement addition of an agreement from ConnectWise Manage. Calls DELETE
    /finance/agreements/{parentId}/additions/{id}.

.PARAMETER id
    The id of the agreement addition to delete.
    Alias: additionId

.PARAMETER agreementid
    The id of the agreement.
    Alias: parentId

.EXAMPLE
    Remove-CWMAgreementAddition -agreementid 12 -id 5

    Deletes agreement addition 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMAgreementAddition {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('additionId')]
        [int]$id,
		[Parameter(Mandatory=$true)]
		[Alias('parentId')]
		[int]$agreementid
    )

    $Endpoint = "/finance/agreements/$($agreementid)/additions/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}