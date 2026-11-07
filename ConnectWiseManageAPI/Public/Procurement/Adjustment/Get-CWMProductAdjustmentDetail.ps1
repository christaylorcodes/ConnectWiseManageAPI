function Get-CWMProductAdjustmentDetail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('adjustmentId')]
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

    $Endpoint = "/procurement/adjustments/$($parentId)/details"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
