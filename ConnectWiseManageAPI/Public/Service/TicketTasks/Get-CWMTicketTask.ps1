function Get-CWMTicketTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$TicketID,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all,
        [string]$TaskID
    )

    If ($TaskID){
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$($TicketID)/tasks/$($TaskID)"
    }
    Else{
        $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$($TicketID)/tasks"
    }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI

}