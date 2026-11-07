function New-CWMTemplate {
    # 2019.1
    # ^ add a comment for what version of the api you used to create function
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
    )

    # Parameters that should not be included in the body. grandparentId & parentId are already skipped.
    $Skip = @()

    $Endpoint = '<Endpoint>'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint -Skip $Skip
}
