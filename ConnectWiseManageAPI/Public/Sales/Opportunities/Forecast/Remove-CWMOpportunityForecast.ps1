function Remove-CWMOpportunityForecast {
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId
    )

    $endpoint = "/sales/opportunities/$parentId/forecast"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}