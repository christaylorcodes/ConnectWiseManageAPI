<#
.SYNOPSIS
    Gets the company type associations of a company.

.DESCRIPTION
    Retrieves the company type associations of a company from ConnectWise Manage, or a single company type
    association by id. Calls GET /company/companies/{parentId}/typeAssociations; -id adds /{id} and -count
    adds /count.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of a single company type association to retrieve.

.PARAMETER count
    Return only the number of matching company type associations instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "type/id=1".

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
    Only return these fields, for example @('id', 'type').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyTypeAssociation -parentId 12 -condition "type/id=1" -all

    Retrieves the company type associations of company 12 that match the condition.

.EXAMPLE
    Get-CWMCompanyTypeAssociation -parentId 12 -id 5

    Retrieves company type association 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyTypeAssociation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
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

    $Endpoint = "/company/companies/$($parentId)/typeAssociations"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
