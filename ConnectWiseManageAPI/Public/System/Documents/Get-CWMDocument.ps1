<#
.SYNOPSIS
    Gets documents, or downloads a document.

.DESCRIPTION
    Retrieves the documents attached to a record (-recordType and -recordId), the metadata of one document
    (-id), or the file content of one document (-id -download). Calls GET /system/documents, GET
    /system/documents/{id}, GET /system/documents/{id}/download or GET /system/documents/count.

.PARAMETER id
    The id of a single document.
    Alias: documentId

.PARAMETER download
    With -id, download the file content of the document (GET /system/documents/{id}/download) instead of its
    metadata.

.PARAMETER recordId
    The id of the record whose documents are returned. Use with -recordType.

.PARAMETER recordType
    The type of the record whose documents are returned, for example Ticket, Company or Opportunity. Use
    with -recordId.

.PARAMETER count
    Return only the number of matching documents instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'title').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMDocument -recordType Ticket -recordId 1234 -all

    Lists the documents attached to service ticket 1234.

.EXAMPLE
    Get-CWMDocument -id 55 -download

    Downloads the content of document 55.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
