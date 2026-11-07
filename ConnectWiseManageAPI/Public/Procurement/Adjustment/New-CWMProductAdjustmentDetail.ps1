<#
.SYNOPSIS
    Creates a product adjustment detail for a product adjustment.

.DESCRIPTION
    Creates a product adjustment detail for a product adjustment in ConnectWise Manage. Calls POST
    /procurement/adjustments/{parentId}/details; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the product adjustment to add the product adjustment detail to.
    Alias: adjustmentID

.PARAMETER catalogItem
    Catalog item reference, for example @{ id = 1 }. Required by the API.

.PARAMETER description
    Description. Max length 50.

.PARAMETER quantityOnHand
    Quantity on hand. A number.

.PARAMETER unitCost
    Unit cost. A number.

.PARAMETER warehouse
    Warehouse reference, for example @{ id = 1 }. Required by the API.

.PARAMETER warehouseBin
    Warehouse bin reference, for example @{ id = 1 }. Required by the API.

.PARAMETER quantityAdjusted
    Quantity adjusted. An integer. Required by the API.

.PARAMETER serialNumber
    Serial number. Max length 1000.

.PARAMETER adjustment
    Adjustment reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMProductAdjustmentDetail -parentId 12 -catalogItem @{ id = 15 } -warehouse @{ id = 1 } -warehouseBin @{ id = 2 } -quantityAdjusted 5

    Adds a detail line for catalog item 15 in warehouse 1, bin 2 to product adjustment 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMProductAdjustmentDetail {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('adjustmentID')]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [hashtable]$catalogItem,
        [ValidateLength(1,100)]
        [string]$description,
        [double]$quantityOnHand,
        [double]$unitCost,
        [Parameter(Mandatory=$true)]
        [hashtable]$warehouse,
        [Parameter(Mandatory=$true)]
        [hashtable]$warehouseBin,
        [Parameter(Mandatory=$true)]
        [int]$quantityAdjusted,
        [ValidateLength(1,100)]
        [string]$serialNumber,
        [hashtable]$adjustment,
        [hashtable]$_info
    )

    $Endpoint = "/procurement/adjustments/$($parentId)/details"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
