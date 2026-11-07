<#
.SYNOPSIS
    Gets the custom status notes of a company.

.DESCRIPTION
    Retrieves the custom status notes of a company from ConnectWise Manage, or a single custom status note
    by id. Calls GET /company/companies/{parentId}/customStatusNotes; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single custom status note to retrieve.

.PARAMETER count
    Return only the number of matching custom status notes instead of the records.

.PARAMETER CompanyID
    The id of the company.

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
    Only return these fields, for example @('id', 'customNote').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyCustomNote -CompanyID 12 -condition "id>100" -all

    Retrieves the custom status notes of company 12 that match the condition.

.EXAMPLE
    Get-CWMCompanyCustomNote -CompanyID 12 -id 5

    Retrieves custom status note 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyCustomNote {
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

    $Endpoint = "/company/companies/$($CompanyID)/customStatusNotes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
