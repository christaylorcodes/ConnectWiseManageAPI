<#
.SYNOPSIS
    Creates an agreement addition for an agreement.

.DESCRIPTION
    Creates an agreement addition for an agreement in ConnectWise Manage. Calls POST
    /finance/agreements/{parentId}/additions; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the agreement to add the agreement addition to.
    Alias: AgreementId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER product
    Product reference, for example @{ id = 1 }. Required by the API.

.PARAMETER quantity
    Quantity. A number.

.PARAMETER lessIncluded
    Less included. A number.

.PARAMETER unitPrice
    Unit price. A number.

.PARAMETER unitCost
    Unit cost. A number.

.PARAMETER billCustomer
    Bill customer. One of: Billable, DoNotBill, NoCharge. Required by the API.

.PARAMETER effectiveDate
    Effective date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER cancelledDate
    Cancelled date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER serialNumber
    Serial number. Max length 50.

.PARAMETER invoiceDescription
    Invoice description. Max length 6000.

.PARAMETER purchaseItemFlag
    Purchase item flag. $true or $false.

.PARAMETER specialOrderFlag
    Special order flag. $true or $false.

.PARAMETER description
    Description.

.PARAMETER billedQuantity
    Billed quantity. A number.

.PARAMETER uom
    UOM.

.PARAMETER extPrice
    Ext price. A number.

.PARAMETER extCost
    Ext cost. A number.

.PARAMETER sequenceNumber
    Sequence number. A number.

.PARAMETER margin
    Margin. A number.

.PARAMETER prorateCost
    Prorate cost. A number.

.PARAMETER proratePrice
    Prorate price. A number.

.PARAMETER extendedProrateCost
    Extended prorate cost. A number.

.PARAMETER extendedProratePrice
    Extended prorate price. A number.

.PARAMETER prorateCurrentPeriodFlag
    Prorate current period flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMAgreementAddition -parentId 30 -product @{ id = 15 } -billCustomer 'Billable' -quantity 5

    Adds five of catalog product 15 to agreement 30 as a billable addition.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
        [double]$quantity,
        [double]$lessIncluded,
        [double]$unitPrice,
        [double]$unitCost,
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
        [double]$billedQuantity,
        [string]$uom,
        [double]$extPrice,
        [double]$extCost,
        [double]$sequenceNumber,
        [double]$margin,
        [double]$prorateCost,
        [double]$proratePrice,
        [double]$extendedProrateCost,
        [double]$extendedProratePrice,
        [bool]$prorateCurrentPeriodFlag,
        [hashtable]$_info
    )

    $Endpoint = "/finance/agreements/$($parentId)/additions"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
