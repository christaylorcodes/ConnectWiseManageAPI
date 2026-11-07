function New-CWMTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
    )

    # Parameters that should not be included in the body. grandparentId & parentId are already skipped.
    $Skip = @()

    $Endpoint = '<Endpoint>'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint -Skip $Skip
}
