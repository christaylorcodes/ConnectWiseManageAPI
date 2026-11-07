<#
.SYNOPSIS
    Gets the notes of a company.

.DESCRIPTION
    Retrieves the notes of a company from ConnectWise Manage, or a single note by id. Calls GET
    /company/companies/{parentId}/notes; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single note to retrieve.

.PARAMETER count
    Return only the number of matching notes instead of the records.

.PARAMETER CompanyID
    The id of the company.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "text contains 'callback'".

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
    Only return these fields, for example @('id', 'text').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyNote -CompanyID 12 -condition "text contains 'callback'" -all

    Retrieves the notes of company 12 that match the condition.

.EXAMPLE
    Get-CWMCompanyNote -CompanyID 12 -id 5

    Retrieves note 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyNote {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [Parameter(Mandatory = $true)]
        [int]$CompanyID,
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

    $Endpoint = "/company/companies/$($CompanyID)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
