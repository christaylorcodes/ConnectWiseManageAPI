function Remove-CWMOpportunityForecastItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$parentId/forecast/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}