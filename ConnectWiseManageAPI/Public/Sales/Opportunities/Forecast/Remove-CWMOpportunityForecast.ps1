function Remove-CWMOpportunityForecast {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId
    )

    $endpoint = "/sales/opportunities/$parentId/forecast"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}