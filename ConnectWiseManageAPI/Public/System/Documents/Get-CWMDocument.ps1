function Get-CWMDocument {
    [CmdletBinding()]
    param(
        [ValidateSet(
            'Agreement',
            'Company',
            'Configuration',
            'Contact',
            'Expense',
            'HTMLTemplate',
            'Opportunity',
            'Project',
            'PurchaseOrder',
            'Rma',
            'SalesOrder',
            'Ticket',
            'ServiceTemplate',
            'ToolbarIcon',
            'Meeting',
            'MeetingNote',
            'ProductSetup',
            'ProjectTemplateTicket',
            'WordTemplate',
            'Member',
            'PhaseStatus',
            'ProjectStatus',
            'TicketStatus'
        )]
        $RecordType,
        [int]$RecordID,
        [int]$page,
        [int]$pageSize,
        [int]$pageID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/documents"
    if ($RecordType) {$URI += "&recordType=$RecordType"}
    if ($RecordID) {$URI += "&recordId=$RecordID"}

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}
