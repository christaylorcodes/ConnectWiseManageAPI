function Get-CWMAuditTrail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [validateset('Ticket', 'ProductCatalog', 'Configuration', 'PurchaseOrder', 'Expense')]
        $Type,
        [Parameter(Mandatory=$true)]
        [string]$ID,
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

    $Endpoint = '/company/companies'

    if($Type){ $Endpoint += "&type=$type" }
    if($ID){ $Endpoint += "&id=$ID" }
    if($deviceIdentifier){ $Endpoint += "&deviceIdentifier=$deviceIdentifier" }

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}