function New-CWMTicketTask {
    # 2020.4
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [Alias('parentId')]
        [int]$ticketId,
        [string]$notes,
        [boolean]$closedFlag,
        [int]$priority,
        [hastable]$schedule,
        [hashtable]$code,
        [string]$resolution,
        [ValidateSet('Transfer', 'Delete', 'Done')]
        $childScheduleAction,
        [int]$childTicketId,
        [hashtable]$_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$($ticketId)/tasks"

    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
