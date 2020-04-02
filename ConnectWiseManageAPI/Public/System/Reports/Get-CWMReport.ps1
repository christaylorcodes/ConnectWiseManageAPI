function Get-CWMReport {
    [CmdletBinding()]
    param(
        [string]$Report,
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

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/reports"
    if($Report){
        $URI += "/$Report"
    }
    $Result = Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
    if(!$Result){ return }
    if($Report){ return ConvertFrom-CWMColumnRow -Data $Result }
    return $Result
}