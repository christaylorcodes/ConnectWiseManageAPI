<#
.SYNOPSIS
    Gets sales stages.

.DESCRIPTION
    Retrieves the sales stages from ConnectWise Manage. Calls GET /sales/stages.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name contains 'Support'".

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER fields
    Only return these fields, for example @('id', 'name').

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER pageId
    Starts forward-only pagination at the page identified by this value.

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMOpportunityStage -condition "name contains 'Support'" -all

    Retrieves the sales stages that match the condition.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMOpportunityStage {
    [CmdletBinding()]
    param(
        [string]$condition,
        [string]$childConditions,
        [string]$customFieldConditions,
        [string]$orderBy,
        [string[]]$fields,
        [int]$page,
        [int]$pageSize,
        [int]$pageId,
        [switch]$all
    )

    $Endpoint = '/sales/stages'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}