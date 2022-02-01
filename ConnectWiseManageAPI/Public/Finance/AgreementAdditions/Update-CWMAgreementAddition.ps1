function Update-CWMAgreementAddition {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('additionId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/finance/agreements/$($parentId)/additions/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
