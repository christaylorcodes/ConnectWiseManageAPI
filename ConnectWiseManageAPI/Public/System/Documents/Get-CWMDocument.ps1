function Get-CWMDocument {
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'ID')]
        [Alias('documentId')]
        [int]$id,
        [Parameter(Mandatory = $true, ParameterSetName = 'Record')]
        [int]$recordId,
        [Parameter(Mandatory = $true, ParameterSetName = 'Record')]
        [ValidateSet('Activity', 'Agreement', 'Company', 'Config', 'Configuration', 'Contact', 'CustomImage',
        'Document', 'Expense', 'HTMLTemplate', 'Invoice', 'Opportunity', 'Project', 'ProjectActivity',
        'PurchaseOrder', 'Rma', 'SalesOrder', 'Service', 'Ticket', 'ProjectTicket', 'ServiceTemplate',
        'StandardServiceTemplate', 'SrDetail', 'TimeEntry', 'JobHeader', 'MarketingManagerAudit', 'KnowledgeBase',
        'ToolbarIcon', 'Meeting', 'MeetingNote', 'ProductSetup', 'ProjectTemplateTicket', 'BillingSetup',
        'ServiceBoard', 'WordTemplate', 'Member', 'PortalImagePortalLogo', 'PortalImageReportLogo',
        'TopNavigationLogo', 'PhaseStatus', 'ProjectStatus', 'TicketStatus', 'Schedule', 'Priority', 'Unassigned')]
        [string]$recordType,
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

    $Endpoint = '/system/documents'
    if($recordId -and $recordType){ $Endpoint = "$($Endpoint)?recordId=$($recordId)&recordType=$($recordType)" }

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
