function Get-CWMTicket {
    [CmdletBinding()]
    param(
        [Alias('ticketId')]
        [int]$id,
        [switch]$count,
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
    if ($id -or $count.IsPresent) {
        $Endpoint = '/service/tickets'
        Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
    else {
        $Endpoint = '/service/tickets/search'
        Invoke-CWMSearchMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}