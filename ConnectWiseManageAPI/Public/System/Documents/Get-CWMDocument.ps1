function Get-CWMDocument {
    [CmdletBinding()]
    param(
        [Parameter(ParameterSetName = 'ID')]
        [Alias('documentId')]
        [int]$id,
        [Parameter(ParameterSetName = 'ID')]
        [switch]$download,
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

    # Work on a copy so $PSBoundParameters is never modified. recordId/recordType are query parameters and
    # /count goes before the query string (Invoke-CWMGetMaster would add it after), so both are built here.
    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }
    foreach ($Key in 'download', 'recordId', 'recordType', 'count') { $null = $Arguments.Remove($Key) }

    $Endpoint = '/system/documents'
    if ($count) {
        # GET /system/documents/count (there is no per-document count)
        $Endpoint += '/count'
        foreach ($Key in 'id', 'all') { $null = $Arguments.Remove($Key) }
    }
    elseif ($id -and $download) {
        $Endpoint += "/$($id)/download"
        $null = $Arguments.Remove('id')
    }
    if ($PSCmdlet.ParameterSetName -eq 'Record') {
        $Endpoint += "?recordId=$($recordId)&recordType=$([uri]::EscapeDataString($recordType))"
    }

    $Result = Invoke-CWMGetMaster -Arguments $Arguments -Endpoint $Endpoint
    if ($count -and $null -ne $Result -and $Result.PSObject.Properties['count']) { $Result = $Result.count }
    $Result
}
