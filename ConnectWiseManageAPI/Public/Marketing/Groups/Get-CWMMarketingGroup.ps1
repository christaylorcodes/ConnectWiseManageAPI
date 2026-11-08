<#
.SYNOPSIS
    Gets marketing groups.

.DESCRIPTION
    Retrieves the marketing groups from ConnectWise Manage, or a single marketing group by id. Calls GET
    /marketing/groups; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single marketing group to retrieve.

.PARAMETER count
    Return only the number of matching marketing groups instead of the records.

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
    Get-CWMMarketingGroup -condition "name contains 'Support'" -all

    Retrieves the marketing groups that match the condition.

.EXAMPLE
    Get-CWMMarketingGroup -id 5

    Retrieves marketing group 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMMarketingGroup {
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

    $Endpoint = '/marketing/groups'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
