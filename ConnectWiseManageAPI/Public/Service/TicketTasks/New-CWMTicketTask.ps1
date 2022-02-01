function New-CWMTicketTask {
    # 2020.4
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [int]$id,
        [string]$notes,
        [boolean]$closedFlag,
        [int]$priority,
        [hashtable]$schedule,
        [hashtable]$code,
        [string]$resolution,
        [ValidateSet('Transfer', 'Delete', 'Done')]
        $childScheduleAction,
        [int]$childTicketId,
        [hashtable]$_info
    )

    $Endpoint = "/service/tickets/$($parentId)/tasks"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
