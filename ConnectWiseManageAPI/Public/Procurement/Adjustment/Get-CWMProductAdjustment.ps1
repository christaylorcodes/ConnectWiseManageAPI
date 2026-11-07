<#
.SYNOPSIS
    Gets product adjustments.

.DESCRIPTION
    Retrieves the product adjustments from ConnectWise Manage, or a single product adjustment by id. Calls
    GET /procurement/adjustments; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single product adjustment to retrieve.

.PARAMETER count
    Return only the number of matching product adjustments instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "identifier='ACME'".

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
    Only return these fields, for example @('id', 'identifier').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProductAdjustment -condition "identifier='ACME'" -all

    Retrieves the product adjustments that match the condition.

.EXAMPLE
    Get-CWMProductAdjustment -id 5

    Retrieves product adjustment 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProductAdjustment {
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

    $Endpoint = '/procurement/adjustments'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
