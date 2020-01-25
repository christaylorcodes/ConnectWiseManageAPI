function Get-CWMTicket {
    [CmdletBinding()]
    param(
        [int]$TicketID,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [switch]$all
    )
    if ($TicketID) {
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$($TicketID)"
        return Invoke-CWMGetMaster -URI $URI
    }
    else {
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/search"
        return Invoke-CWMSearchMaster -Arguments $PsBoundParameters -URI $URI
    }
}