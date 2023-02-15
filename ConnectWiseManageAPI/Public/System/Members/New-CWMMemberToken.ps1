function New-CWMMemberToken {
    # 2022.1
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        $memberIdentifier
    )
    $Skip = 'Headers'
    $Endpoint = "/system/members/$($memberIdentifier)/tokens"
    Invoke-CWMNewMaster -Arguments @{Headers = @{'x-cw-usertype' = 'member' } } -Endpoint $Endpoint -Skip $Skip
}
