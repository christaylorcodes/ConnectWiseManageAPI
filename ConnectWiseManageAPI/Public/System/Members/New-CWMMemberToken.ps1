function New-CWMMemberToken {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$memberIdentifier
    )
    $Skip = 'Headers'
    $Endpoint = "/system/members/$([uri]::EscapeDataString($memberIdentifier))/tokens"
    Invoke-CWMNewMaster -Arguments @{Headers = @{'x-cw-usertype' = 'member' } } -Endpoint $Endpoint -Skip $Skip
}
