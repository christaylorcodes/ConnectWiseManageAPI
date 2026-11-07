<#
.SYNOPSIS
    Gets the on-hand inventory of a warehouse bin.

.DESCRIPTION
    Retrieves the on-hand inventory records of a warehouse bin from ConnectWise Manage, or a single on-hand
    inventory record by id. Calls GET /procurement/warehouseBins/{parentId}/inventoryOnHand; -id adds /{id}
    and -count adds /count.

.PARAMETER parentId
    The id of the warehouse bin.
    Alias: ProductID

.PARAMETER id
    The id of a single on-hand inventory record to retrieve.

.PARAMETER count
    Return only the number of matching on-hand inventory records instead of the records.

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
    Only return these fields, for example @('id', 'catalogItem').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMInventory -parentId 12 -condition "id>100" -all

    Retrieves the on-hand inventory records of warehouse bin 12 that match the condition.

.EXAMPLE
    Get-CWMInventory -parentId 12 -id 5

    Retrieves on-hand inventory record 5 of warehouse bin 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ProductID')]
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

    $Endpoint = "/procurement/warehouseBins/$($parentId)/inventoryOnHand"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
