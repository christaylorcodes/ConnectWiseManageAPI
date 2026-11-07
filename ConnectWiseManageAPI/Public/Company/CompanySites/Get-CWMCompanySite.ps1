<#
.SYNOPSIS
    Gets the sites of a company.

.DESCRIPTION
    Retrieves the sites of a company from ConnectWise Manage, or a single site by id. Calls GET
    /company/companies/{parentId}/sites; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of a single site to retrieve.
    Alias: siteId

.PARAMETER count
    Return only the number of matching sites instead of the records.

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
    Get-CWMCompanySite -parentId 12 -condition "name contains 'Support'" -all

    Retrieves the sites of company 12 that match the condition.

.EXAMPLE
    Get-CWMCompanySite -parentId 12 -id 5

    Retrieves site 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanySite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Alias('siteId')]
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

    $Endpoint = "/company/companies/$($parentId)/sites"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
