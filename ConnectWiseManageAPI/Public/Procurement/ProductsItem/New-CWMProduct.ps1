<#
.SYNOPSIS
    Creates a product.

.DESCRIPTION
    Creates a product in ConnectWise Manage. Calls POST /procurement/products; only the parameters you pass
    are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER catalogItem
    Catalog item reference, for example @{ id = 1 }. Required by the API.

.PARAMETER description
    Description. Max length 2000.

.PARAMETER sequenceNumber
    Sequence number. A number.

.PARAMETER quantity
    Quantity. A number.

.PARAMETER unitOfMeasure
    Unit of measure reference, for example @{ id = 1 }.

.PARAMETER price
    Price. A number.

.PARAMETER cost
    Cost. A number.

.PARAMETER extPrice
    Ext price. A number.

.PARAMETER extCost
    Ext cost. A number.

.PARAMETER discount
    Discount. A number.

.PARAMETER margin
    Margin. A number.

.PARAMETER agreementAmount
    Agreement amount. A number.

.PARAMETER priceMethod
    Price method. One of: FlatRateForRange, PercentMarkupFromCost, PercentMarkdownFromPrice, PricePerUnit.

.PARAMETER billableOption
    Billable option. One of: Billable, DoNotBill, NoCharge. Required by the API.

.PARAMETER agreement
    Agreement reference, for example @{ id = 30 }.

.PARAMETER locationId
    Location id. An integer. Required on updates.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER businessUnitId
    Business unit id. An integer. Required on updates.

.PARAMETER businessUnit
    Business unit reference, for example @{ id = 1 }.

.PARAMETER vendor
    Vendor reference, for example @{ id = 1 }.

.PARAMETER vendorSku
    Vendor SKU. Max length 50.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER dropshipFlag
    Dropship flag. $true or $false.

.PARAMETER specialOrderFlag
    Special order flag. $true or $false.

.PARAMETER phaseProductFlag
    Phase product flag. $true or $false.

.PARAMETER cancelledFlag
    Cancelled flag. $true or $false.

.PARAMETER quantityCancelled
    Quantity cancelled. A number.

.PARAMETER cancelledReason
    Cancelled reason. Max length 100.

.PARAMETER customerDescription
    Customer description. Max length 6000. Required on updates.

.PARAMETER internalNotes
    Internal notes. Max length 1000.

.PARAMETER productSuppliedFlag
    Product supplied flag. $true or $false.

.PARAMETER subContractorShipToId
    Sub contractor ship to id. An integer.

.PARAMETER subContractorAmountLimit
    Sub contractor amount limit. A number.

.PARAMETER recurring
    Recurring, as a hashtable with the properties of the API's ProductRecurring object.

.PARAMETER sla
    SLA reference, for example @{ id = 1 }.

.PARAMETER entityType
    Entity type reference, for example @{ id = 1 }.

.PARAMETER ticket
    Ticket reference, for example @{ id = 1234 }.

.PARAMETER project
    Project reference, for example @{ id = 40 }.

.PARAMETER phase
    Phase reference, for example @{ id = 1 }.

.PARAMETER salesOrder
    Sales order reference, for example @{ id = 1 }.

.PARAMETER opportunity
    Opportunity reference, for example @{ id = 75 }.

.PARAMETER invoice
    Invoice reference, for example @{ id = 1 }.

.PARAMETER warehouseId
    Warehouse id. An integer.

.PARAMETER warehouseIdObject
    Warehouse id object reference, for example @{ id = 1 }.

.PARAMETER warehouseBinId
    Warehouse bin id. An integer.

.PARAMETER warehouseBinIdObject
    Warehouse bin id object reference, for example @{ id = 1 }.

.PARAMETER calculatedPriceFlag
    Calculated price flag. $true or $false.

.PARAMETER calculatedCostFlag
    Calculated cost flag. $true or $false.

.PARAMETER forecastDetailId
    Forecast detail id. An integer.

.PARAMETER cancelledBy
    Cancelled by. An integer.

.PARAMETER cancelledDate
    Cancelled date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER warehouse
    Warehouse.

.PARAMETER warehouseBin
    Warehouse bin.

.PARAMETER purchaseDate
    Purchase date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER integrationXRef
    Integration XRef.

.PARAMETER listPrice
    List price. A number.

.PARAMETER serialNumberIds
    Serial number ids. An array of integers.

.PARAMETER serialNumbers
    Serial numbers. An array of strings.

.PARAMETER company
    Company reference, for example @{ id = 250 }.

.PARAMETER forecastStatus
    Forecast status reference, for example @{ id = 1 }.

.PARAMETER productClass
    Product class. One of: Agreement, Bundle, Inventory, NonInventory, Service.

.PARAMETER needToPurchaseFlag
    Need to purchase flag. $true or $false.

.PARAMETER needToOrderQuantity
    Need to order quantity. An integer.

.PARAMETER minimumStockFlag
    Minimum stock flag. $true or $false.

.PARAMETER shipSet
    Ship set. Max length 10.

.PARAMETER calculatedPrice
    Calculated price. A number.

.PARAMETER calculatedCost
    Calculated cost. A number.

.PARAMETER invoiceGrouping
    Invoice grouping reference, for example @{ id = 1 }.

.PARAMETER poApprovedFlag
    PO approved flag. $true or $false.

.PARAMETER uom
    UOM.

.PARAMETER addComponentsFlag
    Add components flag. $true or $false.

.PARAMETER ignorePricingSchedulesFlag
    Ignore pricing schedules flag. $true or $false.

.PARAMETER asioSubscriptionsID
    Asio subscriptions id.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER bypassForecastUpdate
    Bypass forecast update. $true or $false.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMProduct -catalogItem @{ id = 15 } -billableOption 'Billable' -quantity 2 -ticket @{ id = 1234 }

    Adds two of catalog item 15 to ticket 1234 as a billable product.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMProduct {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory=$true)]
        [hashtable]$catalogItem,
        [ValidateLength(1,2000)]
        [string]$description,
        [decimal]$sequenceNumber,
        [decimal]$quantity,
        [hashtable]$unitOfMeasure,
        [decimal]$price,
        [decimal]$cost,
        [decimal]$extPrice,
        [decimal]$extCost,
        [decimal]$discount,
        [decimal]$margin,
        [decimal]$agreementAmount,
        [ValidateSet('FlatRateForRange', 'PercentMarkupFromCost', 'PercentMarkdownFromPrice', 'PricePerUnit')]
        [string]$priceMethod,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge')]
        [string]$billableOption,
        [hashtable]$agreement,
        [int]$locationId,
        [hashtable]$location,
        [int]$businessUnitId,
        [hashtable]$businessUnit,
        [hashtable]$vendor,
        [ValidateLength(1,50)]
        [string]$vendorSku,
        [bool]$taxableFlag,
        [bool]$dropshipFlag,
        [bool]$specialOrderFlag,
        [bool]$phaseProductFlag,
        [bool]$cancelledFlag,
        [decimal]$quantityCancelled,
        [ValidateLength(1,100)]
        [string]$cancelledReason,
        [ValidateLength(1,6000)]
        [string]$customerDescription,
        [ValidateLength(1,1000)]
        [string]$internalNotes,
        [bool]$productSuppliedFlag,
        [int]$subContractorShipToId,
        [decimal]$subContractorAmountLimit,
        [hashtable]$recurring,
        [hashtable]$sla,
        [hashtable]$entityType,
        [hashtable]$ticket,
        [hashtable]$project,
        [hashtable]$phase,
        [hashtable]$salesOrder,
        [hashtable]$opportunity,
        [hashtable]$invoice,
        [int]$warehouseId,
        [hashtable]$warehouseIdObject,
        [int]$warehouseBinId,
        [hashtable]$warehouseBinIdObject,
        [bool]$calculatedPriceFlag,
        [bool]$calculatedCostFlag,
        [int]$forecastDetailId,
        [int]$cancelledBy,
        [string]$cancelledDate,
        [string]$warehouse,
        [string]$warehouseBin,
        [string]$purchaseDate,
        [hashtable]$taxCode,
        [string]$integrationXRef,
        [decimal]$listPrice,
        [int[]]$serialNumberIds,
        [string[]]$serialNumbers,
        [hashtable]$company,
        [hashtable]$forecastStatus,
        [ValidateSet('Agreement', 'Bundle', 'Inventory', 'NonInventory', 'Service')]
        [string]$productClass,
        [bool]$needToPurchaseFlag,
        [int]$needToOrderQuantity,
        [bool]$minimumStockFlag,
        [ValidateLength(1,10)]
        [string]$shipSet,
        [decimal]$calculatedPrice,
        [decimal]$calculatedCost,
        [hashtable]$invoiceGrouping,
        [bool]$poApprovedFlag,
        [string]$uom,
        [bool]$addComponentsFlag,
        [bool]$ignorePricingSchedulesFlag,
        [string]$asioSubscriptionsID,
        [hashtable]$_info,
        [bool]$bypassForecastUpdate,
        [hashtable[]]$customFields
    )

    $Endpoint = '/procurement/products'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
