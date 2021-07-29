function Get-CWMAgreementAddition {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('AgreementID')]
        $parentId,
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

    $Endpoint = "/finance/agreements/$($parentId)/additions"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
