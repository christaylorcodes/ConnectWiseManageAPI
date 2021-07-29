function Get-CWMScheduleHolidayList {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/schedule/holidaylists'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}