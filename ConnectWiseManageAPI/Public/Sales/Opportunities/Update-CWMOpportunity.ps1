function Update-CWMOpportunity {
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityID')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    $Endpoint = "/sales/opportunities/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}