function Get-CWMReport {
    [CmdletBinding()]
    param(
        [Alias('reportName')]
        [string]$id,
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

    $Endpoint = '/system/reports'
    if($id){ $Endpoint = Join-Url $Endpoint $id }
    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    if(!$Result){ return }
    if($id){ ConvertFrom-CWMColumnRow -Data $Result }
    else{ $Result }
}