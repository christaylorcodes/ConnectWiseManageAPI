<#
.SYNOPSIS
    Gets the companies in a marketing group.

.DESCRIPTION
    Retrieves the companies of a marketing group from ConnectWise Manage, or a single company by id. Calls
    GET /marketing/groups/{parentId}/companies; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the marketing group.
    Alias: groupId

.PARAMETER id
    The id of a single company to retrieve.
    Alias: companyId

.PARAMETER count
    Return only the number of matching companies instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

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
    Only return these fields, for example @('id', 'groupId').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMMarketingGroupCompany -parentId 12 -condition "id>100" -all

    Retrieves the companies of marketing group 12 that match the condition.

.EXAMPLE
    Get-CWMMarketingGroupCompany -parentId 12 -id 5

    Retrieves company 5 of marketing group 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMMarketingGroupCompany {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('companyId')]
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

    $Endpoint = "/marketing/groups/$($parentId)/companies"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}