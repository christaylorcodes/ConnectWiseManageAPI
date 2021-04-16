function Get-CWMAgreementSite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('AgreementID')]
        [int]$parentId,
        [int]$id,
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

    $Endpoint = "/finance/agreements/$($parentId)/sites"
    if($id){ $Endpoint = Join-Url $Endpoint $id }

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
