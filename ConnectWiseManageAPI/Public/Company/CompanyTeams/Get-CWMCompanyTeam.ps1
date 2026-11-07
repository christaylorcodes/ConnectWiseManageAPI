<#
.SYNOPSIS
    Gets the team members assigned to a company.

.DESCRIPTION
    Retrieves the team member assignments of a company from ConnectWise Manage, or a single team member
    assignment by id. Calls GET /company/companies/{parentId}/teams; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single team member assignment to retrieve.

.PARAMETER count
    Return only the number of matching team member assignments instead of the records.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'".

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
    Only return these fields, for example @('id', 'company').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyTeam -parentId 12 -condition "member/identifier='jdoe'" -all

    Retrieves the team member assignments of company 12 that match the condition.

.EXAMPLE
    Get-CWMCompanyTeam -parentId 12 -id 5

    Retrieves team member assignment 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyTeam {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
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

    $Endpoint = "/company/companies/$($parentId)/teams"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
