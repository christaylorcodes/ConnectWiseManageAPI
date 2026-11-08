<#
.SYNOPSIS
    Gets the holidays of a holiday list.

.DESCRIPTION
    Retrieves the holidays of a holiday list from ConnectWise Manage, or a single holiday by id. Calls GET
    /schedule/holidayLists/{parentId}/holidays; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the holiday list.
    Alias: holidayListId

.PARAMETER id
    The id of a single holiday to retrieve.

.PARAMETER count
    Return only the number of matching holidays instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name contains 'Support'".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'name').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMScheduleHoliday -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the holidays of holiday list 12 that match the condition.

.EXAMPLE
    Get-CWMScheduleHoliday -parentId 12 -id 5

    Retrieves holiday 5 of holiday list 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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

    $Endpoint = "/schedule/holidayLists/$($parentId)/holidays"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}