function New-CWMAgreementAddition {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('AgreementId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory=$true)]
        $product,
        [float]$quantity,
        [float]$lessIncluded,
        [float]$unitPrice,
        [float]$unitCost,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge')]
        [string]$billCustomer,
        [string]$effectiveDate,
        [string]$cancelledDate,
        [bool]$taxableFlag,
        [ValidateLength(1,50)]
        [string]$serialNumber,
        [ValidateLength(1,6000)]
        [string]$invoiceDescription,
        [bool]$purchaseItemFlag,
        [bool]$specialOrderFlag,
        [string]$description,
        [float]$billedQuantity,
        [string]$uom,
        [float]$extPrice,
        [float]$extCost,
        [float]$sequenceNumber,
        [float]$margin,
        [float]$prorateCost,
        [float]$proratePrice,
        [float]$extendedProrateCost,
        [float]$extendedProratePrice,
        [bool]$prorateCurrentPeriodFlag,
        [hashtable]$_info
    )

    $Endpoint = "/finance/agreements/$($parentId)/additions"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
