function Update-CWMOpportunityForecast {
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityID')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/sales/opportunities/$parentId/forecast"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}