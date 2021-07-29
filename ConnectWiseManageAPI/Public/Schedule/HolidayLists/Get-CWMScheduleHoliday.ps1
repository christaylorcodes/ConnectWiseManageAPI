function Get-CWMScheduleHoliday {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('holidayListId')]
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

    $Endpoint = "/schedule/holidaylists/$($parentId)/holidays"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}