<#
.SYNOPSIS
    Gets company statuses.

.DESCRIPTION
    Retrieves the company statuses from ConnectWise Manage, or a single company status by id. Calls GET
    /company/companies/statuses; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single company status to retrieve.

.PARAMETER count
    Return only the number of matching company statuses instead of the records.

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
    Get-CWMCompanyStatus -condition "name contains 'Support'" -all

    Retrieves the company statuses that match the condition.

.EXAMPLE
    Get-CWMCompanyStatus -id 5

    Retrieves company status 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyStatus {
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

    $Endpoint = '/company/companies/statuses'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
