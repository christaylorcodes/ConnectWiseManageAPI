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
        [int]$serialNumberIds,
        [string]$serialNumbers,
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
        [hashtable]$customFields
        
    )

    $Endpoint = '/procurement/products'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
