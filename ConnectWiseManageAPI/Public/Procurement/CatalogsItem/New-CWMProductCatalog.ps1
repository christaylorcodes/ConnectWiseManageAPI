<#
.SYNOPSIS
    Creates a catalog item.

.DESCRIPTION
    Creates a catalog item in ConnectWise Manage. Calls POST /procurement/catalog; only the parameters you
    pass are sent in the request body.

.PARAMETER identifier
    Identifier. Max length 75. Required by the API.

.PARAMETER description
    Description. Max length 60. Required by the API.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER subcategory
    Subcategory reference, for example @{ id = 1 }. Required by the API.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER productClass
    Product class. One of: Agreement, Bundle, Inventory, NonInventory, Service. Defaults to Non-Inventory.

.PARAMETER serializedFlag
    Serialized flag. $true or $false.

.PARAMETER serializedCostFlag
    Serialized cost flag. $true or $false.

.PARAMETER phaseProductFlag
    Phase product flag. $true or $false.

.PARAMETER unitOfMeasure
    Unit of measure reference, for example @{ id = 1 }.

.PARAMETER minStockLevel
    Min stock level. An integer.

.PARAMETER price
    Price. A number.

.PARAMETER cost
    Cost. A number.

.PARAMETER priceAttribute
    Price attribute. One of: FixedFee, NotToExceed, OverrideRate, TimeAndMaterials.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER customerDescription
    Customer description. Max length 6000. Required by the API.

.PARAMETER manufacturer
    Manufacturer reference, for example @{ id = 1 }.

.PARAMETER manufacturerPartNumber
    Manufacturer part number. Max length 50.

.PARAMETER vendor
    Vendor reference, for example @{ id = 1 }.

.PARAMETER vendorSku
    Vendor SKU. Max length 50.

.PARAMETER notes
    Notes.

.PARAMETER integrationXRef
    Integration XRef. Max length 50.

.PARAMETER category
    Category reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    $CatalogItem = @{
        identifier          = 'USB-C-DOCK'
        description         = 'USB-C docking station'
        customerDescription = 'USB-C docking station'
        subcategory         = @{ id = 3 }
        type                = @{ id = 1 }
        price               = 199
        cost                = 120
    }
    New-CWMProductCatalog @CatalogItem

    Creates a catalog item with the properties the API requires, plus price and cost.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMProductCatalog {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,60)]
        [string]$identifier,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,50)]
        [string]$description,
        [bool]$inactiveFlag,
        [Parameter(Mandatory=$true)]
        [hashtable]$subcategory,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [ValidateSet('Agreement', 'Bundle', 'Inventory', 'NonInventory', 'Service')]
        [string]$productClass,
        [bool]$serializedFlag,
        [bool]$serializedCostFlag,
        [bool]$phaseProductFlag,
        [hashtable]$unitOfMeasure,
        [int]$minStockLevel,
        [double]$price,
        [double]$cost,
        [ValidateSet('FixedFee', 'NotToExceed', 'OverrideRate', 'TimeAndMaterials')]
        [string]$priceAttribute,
        [bool]$taxableFlag,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,6000)]
        [string]$customerDescription,
        [hashtable]$manufacturer,
        [ValidateLength(1,50)]
        [string]$manufacturerPartNumber,
        [hashtable]$vendor,
        [ValidateLength(1,50)]
        [string]$vendorSku,
        [string]$notes,
        [ValidateLength(1,50)]
        [string]$integrationXRef,
        [hashtable]$category,
        [hashtable]$_info,
        [hashtable[]]$customFields
    )

    $Endpoint = '/procurement/catalog'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
