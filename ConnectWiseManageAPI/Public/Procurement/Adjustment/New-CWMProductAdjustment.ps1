function New-CWMProductAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,50)]
        [string]$identifier,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [ValidateLength(1,100)]
        [string]$reason,
        [string]$notes,
        [hashtable]$adjustmentDetails,
        [hashtable]$_info
    )

    $Endpoint = '/procurement/adjustments'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
