<#
.SYNOPSIS
    Gets the agreement sites of an agreement.

.DESCRIPTION
    Retrieves the agreement sites of an agreement from ConnectWise Manage, or a single agreement site by id.
    Calls GET /finance/agreements/{parentId}/sites; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the agreement.
    Alias: AgreementID

.PARAMETER id
    The id of a single agreement site to retrieve.

.PARAMETER count
    Return only the number of matching agreement sites instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "company/id=250".

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
    Get-CWMAgreementSite -parentId 12 -condition "company/id=250" -all

    Retrieves the agreement sites of agreement 12 that match the condition.

.EXAMPLE
    Get-CWMAgreementSite -parentId 12 -id 5

    Retrieves agreement site 5 of agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMAgreementSite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('AgreementID')]
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

    $Endpoint = "/finance/agreements/$($parentId)/sites"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
