<#
.SYNOPSIS
    Gets work roles.

.DESCRIPTION
    Retrieves work roles from ConnectWise Manage, or a single work role by id. Calls GET
    /time/workRoles; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single work role to retrieve.

.PARAMETER count
    Return only the number of matching work roles instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "inactiveFlag=false".

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
    Get-CWMWorkRole -all

    Retrieves every work role.

.EXAMPLE
    Get-CWMWorkRole -id 5

    Retrieves work role 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMWorkRole {
    [CmdletBinding()]
    param(
        [Alias('workRoleId')]
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

    $Endpoint = '/time/workRoles'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
