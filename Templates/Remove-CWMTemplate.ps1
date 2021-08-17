function Remove-CWMTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('somethingId')]
        [int]$id
    )
    $Endpoint = "<Endpoint>"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
