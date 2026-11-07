<#
.SYNOPSIS
    Gets purchase orders.

.DESCRIPTION
    Retrieves the purchase orders from ConnectWise Manage, or a single purchase order by id. Calls GET
    /procurement/purchaseorders; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single purchase order to retrieve.

.PARAMETER count
    Return only the number of matching purchase orders instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "closedFlag=false".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childconditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customfieldconditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'businessUnitId').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMPurchaseOrder -condition "closedFlag=false" -all

    Retrieves the purchase orders that match the condition.

.EXAMPLE
    Get-CWMPurchaseOrder -id 5

    Retrieves purchase order 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMPurchaseOrder {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/procurement/purchaseorders'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}