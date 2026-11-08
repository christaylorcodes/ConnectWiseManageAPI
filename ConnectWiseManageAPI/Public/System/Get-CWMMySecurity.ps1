<#
.SYNOPSIS
    Gets the security settings of the authenticated member.

.DESCRIPTION
    Retrieves the module security levels (add, edit, delete, inquire) of the member the API credentials
    belong to. Calls GET /system/mySecurity.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "inquireLevel='All'".

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
    Only return these fields, for example @('id', 'addLevel').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMMySecurity -condition "inquireLevel='All'" -all

    Returns the module functions the connected member can view at the All level.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMMySecurity {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/system/mySecurity'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}