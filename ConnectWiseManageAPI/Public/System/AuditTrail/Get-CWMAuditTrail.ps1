function Get-CWMAuditTrail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet('None', 'Ticket', 'Contact', 'Company', 'Opportunity', 'Time', 'Activity', 'ProductCatalog', 'ProjectTicket', 'Purchasing', 'Configuration', 'Schedule', 'Agreement', 'AgreementAddition', 'Project', 'Invoice', 'PurchaseOrder', 'Expense')]
        $type,
        [Parameter(Mandatory = $true)]
        [string]$id,
        [switch]$count,
        [string]$deviceIdentifier,
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

    $Endpoint = '/system/audittrail'

    if ($Type) { $Endpoint += "&type=$type" }
    if ($ID) {
        $Endpoint += "&id=$id"
        $null = $PsBoundParameters.Remove('id')
    }
    if ($deviceIdentifier) { $Endpoint += "&deviceIdentifier=$deviceIdentifier" }

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}