function Get-CWMTicket {
    [CmdletBinding()]
    param(
        [Alias('ticketId')]
        [int]$id,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )
    if ($id) {
        $Endpoint = '/service/tickets'
        if($id){ $Endpoint = Join-Url $Endpoint $id }

        Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
    else {
        $Endpoint = '/service/tickets/search'
        Invoke-CWMSearchMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}