function Get-CWMTicket {
    [CmdletBinding()]
    param(
        [Alias('TicketID')]
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
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$($id)"
        return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
    }
    else {
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/search"
        return Invoke-CWMSearchMaster -Arguments $PsBoundParameters -URI $URI
    }
}