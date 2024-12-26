function Update-CWMOpportunityForecastItem {
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityID')]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/sales/opportunities/$parentId/forecast/$id"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}