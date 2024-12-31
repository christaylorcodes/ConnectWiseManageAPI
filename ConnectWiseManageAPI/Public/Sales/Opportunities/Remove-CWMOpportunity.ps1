function Remove-CWMOpportunity {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}