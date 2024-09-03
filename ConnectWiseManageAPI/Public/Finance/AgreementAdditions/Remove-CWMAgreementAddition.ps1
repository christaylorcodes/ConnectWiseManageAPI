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