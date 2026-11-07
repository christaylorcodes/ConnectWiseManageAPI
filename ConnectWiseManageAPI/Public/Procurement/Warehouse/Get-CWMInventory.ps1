function Get-CWMInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ProductID')]
        [int]$parentId,
        [int]$id,
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

    $Endpoint = "/procurement/warehouseBins/$($parentId)/inventoryOnHand"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
