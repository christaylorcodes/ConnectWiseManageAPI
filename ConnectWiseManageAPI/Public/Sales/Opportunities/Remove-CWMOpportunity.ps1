function Remove-CWMOpportunity {
    param (
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}