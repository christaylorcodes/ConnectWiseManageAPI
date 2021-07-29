function Get-CWMReport {
    [CmdletBinding()]
    param(
        [Alias('reportName')]
        [string]$id,
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

    $Endpoint = '/system/reports'
    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    if(!$Result){ return }
    if($id){ ConvertFrom-CWMColumnRow -Data $Result }
    else{ $Result }
}