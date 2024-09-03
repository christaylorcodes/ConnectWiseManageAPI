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
