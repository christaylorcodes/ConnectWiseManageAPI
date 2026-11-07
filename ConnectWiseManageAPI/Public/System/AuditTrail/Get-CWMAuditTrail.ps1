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

    # type, id and deviceIdentifier are query parameters here, not path segments, so they are taken out of
    # a copy of $PSBoundParameters. /count is added before the query string (Invoke-CWMGetMaster would add it after).
    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }
    foreach ($Key in 'type', 'id', 'deviceIdentifier', 'count') { $null = $Arguments.Remove($Key) }

    $Endpoint = '/system/audittrail'
    if ($count) {
        $Endpoint += '/count'
        $null = $Arguments.Remove('all')
    }
    $Endpoint += "?type=$([uri]::EscapeDataString([string]$type))&id=$([uri]::EscapeDataString($id))"
    if ($deviceIdentifier) { $Endpoint += "&deviceIdentifier=$([uri]::EscapeDataString($deviceIdentifier))" }

    $Result = Invoke-CWMGetMaster -Arguments $Arguments -Endpoint $Endpoint
    if ($count -and $null -ne $Result -and $Result.PSObject.Properties['count']) { $Result = $Result.count }
    $Result
}
