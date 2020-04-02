function Get-CWMProductComponent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$ProductID,
        [string]$Condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
        )
    if(!$script:CWMServerConnection){
        Write-Error "Not connected to a Manage server. Run Connect-CWM first."
        break
    }

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/procurement/products/$($ProductID)/components"
    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}
