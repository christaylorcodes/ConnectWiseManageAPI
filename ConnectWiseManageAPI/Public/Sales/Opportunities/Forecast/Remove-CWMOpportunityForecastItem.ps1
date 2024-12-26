function Remove-CWMOpportunityForecastItem {
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$parentId/forecast/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}