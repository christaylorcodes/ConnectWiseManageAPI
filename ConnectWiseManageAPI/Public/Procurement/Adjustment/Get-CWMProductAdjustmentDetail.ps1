<#
.SYNOPSIS
    Gets the product adjustment details of a product adjustment.

.DESCRIPTION
    Retrieves the product adjustment details of a product adjustment from ConnectWise Manage, or a single
    product adjustment detail by id. Calls GET /procurement/adjustments/{parentId}/details; -id adds /{id}
    and -count adds /count.

.PARAMETER parentId
    The id of the product adjustment.
    Alias: adjustmentId

.PARAMETER id
    The id of a single product adjustment detail to retrieve.

.PARAMETER count
    Return only the number of matching product adjustment details instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "description contains 'laptop'".

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
    Only return these fields, for example @('id', 'description').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProductAdjustmentDetail -parentId 12 -condition "description contains 'laptop'" -all

    Retrieves the product adjustment details of product adjustment 12 that match the condition.

.EXAMPLE
    Get-CWMProductAdjustmentDetail -parentId 12 -id 5

    Retrieves product adjustment detail 5 of product adjustment 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProductAdjustmentDetail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('adjustmentId')]
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

    $Endpoint = "/procurement/adjustments/$($parentId)/details"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
