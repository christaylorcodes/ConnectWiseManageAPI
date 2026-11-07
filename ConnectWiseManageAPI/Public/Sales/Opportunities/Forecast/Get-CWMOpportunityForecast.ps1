<#
.SYNOPSIS
    Gets the forecast of an opportunity.

.DESCRIPTION
    Retrieves the forecast of an opportunity from ConnectWise Manage. Calls GET
    /sales/opportunities/{parentId}/forecast.

.PARAMETER parentId
    The id of the opportunity.

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

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMOpportunityForecast -parentId 12 -condition "id>100" -all

    Retrieves the forecasts of opportunity 12 that match the condition.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMOpportunityForecast {
        param (
            [Parameter(Mandatory=$true)]
            [int32]$parentId,
            [string]$condition,
            [string]$childConditions,
            [string]$customFieldConditions,
            [string]$orderBy,
            [string]$fields,
            [Int32]$page,
            [Int32]$pageSize,
            [Int32]$pageID,
            [switch]$all
        )

        $endpoint = "/sales/opportunities/$parentId/forecast"

        Invoke-CWMGetMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}