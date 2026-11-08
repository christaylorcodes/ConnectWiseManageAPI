<#
.SYNOPSIS
    Gets the department locations of a department.

.DESCRIPTION
    Retrieves the department locations of a department from ConnectWise Manage, or a single department
    location by id. Calls GET /system/departments/{parentId}/locations; -id adds /{id} and -count adds
    /count.

.PARAMETER parentId
    The id of the department.

.PARAMETER id
    The id of a single department location to retrieve.

.PARAMETER count
    Return only the number of matching department locations instead of the records.

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
    Only return these fields, for example @('id', 'location').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMDepartmentLocation -parentId 12 -condition "id>100" -all

    Retrieves the department locations of department 12 that match the condition.

.EXAMPLE
    Get-CWMDepartmentLocation -parentId 12 -id 5

    Retrieves department location 5 of department 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMDepartmentLocation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
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

    $Endpoint = "/system/departments/$($parentId)/locations"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
