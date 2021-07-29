function Get-CWMTicketNote {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ticketId')]
        [int]$parentId,
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

    $Endpoint = "/service/tickets/$($parentId)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}