function Get-CWMAuditTrail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [validateset('Ticket', 'ProductCatalog', 'Configuration', 'PurchaseOrder', 'Expense')]
        $Type,
        [Parameter(Mandatory=$true)]
        [string]$ID,
        $deviceIdentifier,
        [string]$childConditions,
        [int]$page,
        [int]$pageSize
    )
    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/audittrail"
    if($Type) {
        $URI += "?type=$type"
    }
    if($ID) {
        $URI += "&id=$ID"
    }
    if($deviceIdentifier) {
        $URI += "&deviceIdentifier=$deviceIdentifier"
    }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}