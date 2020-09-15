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
        $subcategory,
        [Parameter(Mandatory=$true)]
        $type,
        [ValidateSet('Agreement', 'Bundle', 'Inventory', 'NonInventory', 'Service')]
        [string]$productClass,
        [bool]$serializedFlag,
        [bool]$serializedCostFlag,
        [bool]$phaseProductFlag,
        $unitOfMeasure,
        [int]$minStockLevel,
        [float]$price,
        [float]$cost,
        [int]$priceAttribute,
        [bool]$taxableFlag,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,6000)]
        [string]$customerDescription,
        $manufacturer,
        [ValidateLength(1,50)]
        [string]$manufacturerPartNumber,
        $vendor,
        [ValidateLength(1,50)]
        [string]$vendorSku,
        [string]$notes,
        [ValidateLength(1,50)]
        [string]$integrationXRef,
        [string]$dateEntered,
        $category,
        $_info,
        $customFields
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/procurement/catalog"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
