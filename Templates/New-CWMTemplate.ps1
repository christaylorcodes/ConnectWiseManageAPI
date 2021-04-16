function New-CWMTemplate {
    # 2019.1
    # ^ add a comment for what version of the api you used to create function
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/<URI>"

    # If there are parameters that should not be included in the body
    $Skip = @()

    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI -Skip $Skip
}
