function Get-CWMTicketTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$parentId,
        [Alias('taskId')]
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

    $Endpoint = "/service/tickets/$($parentId)/tasks"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
