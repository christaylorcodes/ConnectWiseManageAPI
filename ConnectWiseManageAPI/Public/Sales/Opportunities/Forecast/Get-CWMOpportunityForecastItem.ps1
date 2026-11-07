<#
.SYNOPSIS
    Gets a forecast item of an opportunity.

.DESCRIPTION
    Retrieves one forecast item of an opportunity from ConnectWise Manage. Calls GET
    /sales/opportunities/{parentId}/forecast/{id}.

.PARAMETER parentId
    The id of the opportunity.

.PARAMETER id
    The id of the forecast item to retrieve.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "id>100".

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER fields
    Only return these fields, for example @('id', 'forecastItems').

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER pageID
    Starts forward-only pagination at the page identified by this value.

.EXAMPLE
    Get-CWMOpportunityForecastItem -parentId 75 -id 5

    Retrieves forecast item 5 of opportunity 75.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMOpportunityForecastItem {
    param (
        [Parameter(Mandatory=$true)]
        [int32]$parentId,
        [Parameter(Mandatory=$true)]
        [int32]$id,
        [string]$condition,
        [string]$childConditions,
        [string]$customFieldConditions,
        [string]$orderBy,
        [string]$fields,
        [Int32]$page,
        [Int32]$pageSize,
        [Int32]$pageID
    )

    $endpoint = "/sales/opportunities/$parentId/forecast"

    Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}