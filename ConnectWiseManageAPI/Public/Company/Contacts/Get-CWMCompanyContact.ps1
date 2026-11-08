<#
.SYNOPSIS
    Gets contacts.

.DESCRIPTION
    Retrieves the contacts from ConnectWise Manage, or a single contact by id. Calls GET /company/contacts;
    -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single contact to retrieve.

.PARAMETER count
    Return only the number of matching contacts instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "lastName='Smith' and company/id=250".

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
    Only return these fields, for example @('id', 'lastName').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyContact -condition "lastName='Smith' and company/id=250" -all

    Retrieves the contacts that match the condition.

.EXAMPLE
    Get-CWMCompanyContact -id 5

    Retrieves contact 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyContact {
    [CmdletBinding()]
    [Alias('Get-CWMContact')]
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

    $Endpoint = '/company/contacts'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}