<#
.SYNOPSIS
    Retrieves company records from ConnectWise Manage.

.DESCRIPTION
    Gets company information from ConnectWise Manage using either direct ID lookup
    or advanced filtering. Supports pagination, field selection, and custom field queries.

    Companies are the primary customer/vendor records in ConnectWise Manage and are
    used throughout the system for tickets, contacts, agreements, projects, and more.

    This function calls the ConnectWise Manage API endpoint: /company/companies

.PARAMETER id
    The unique identifier for a specific company.
    When specified, returns only the company with this ID.
    Alias: companyId

.PARAMETER count
    Returns only the count of matching companies instead of company data.

.PARAMETER condition
    Filter companies using ConnectWise Manage condition syntax.
    Examples:
    - "name='Acme Corp'"
    - "city='New York' and state='NY'"
    - "types contains 'Partner'"
    - "status/name='Active'"

.PARAMETER orderBy
    Sort results by specified field. Examples: "id desc", "name asc"

.PARAMETER childConditions
    Filter based on child record criteria.

.PARAMETER customFieldConditions
    Filter based on custom field values.

.PARAMETER page
    Page number for pagination (default: 1).

.PARAMETER pageSize
    Records per page (max: 1000).

.PARAMETER fields
    Specify which fields to return. Example: @('id', 'name', 'identifier', 'status')

.PARAMETER all
    Retrieve all matching companies automatically handling pagination.

.EXAMPLE
    Get-CWMCompany -id 250

    Retrieves company with ID 250.

.EXAMPLE
    Get-CWMCompany -condition "name='Acme Corp'"

    Finds companies with the name 'Acme Corp'.

.EXAMPLE
    Get-CWMCompany -condition "city='Seattle' and state='WA'" -all

    Gets all companies in Seattle, WA.

.EXAMPLE
    Get-CWMCompany -condition "types contains 'Customer'" -orderBy "name asc" -all

    Retrieves all customer companies sorted by name.

.EXAMPLE
    Get-CWMCompany -condition "status/name='Active'" -fields @('id', 'name', 'phoneNumber') -all

    Gets active companies with only specific fields.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Common Filters:
    - By type: "types contains 'Customer'"
    - By status: "status/name='Active'"
    - By location: "city='CityName' and state='ST'"
    - By territory: "territory/id=5"

.LINK
    https://developer.connectwise.com/manage/rest#/Companies

.LINK
    New-CWMCompany

.LINK
    Update-CWMCompany

.LINK
    Remove-CWMCompany

#>
function Get-CWMCompany {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/company/companies'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
