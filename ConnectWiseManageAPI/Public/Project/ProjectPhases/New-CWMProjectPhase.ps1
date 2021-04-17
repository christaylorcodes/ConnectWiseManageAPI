function New-CWMProjectPhase {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [int]$parentId,
        [int]$id,
        [int]$projectId,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$description,
        [hashtable]$board,
        [hashtable]$status,
        [hashtable]$agreement,
        [hashtable]$opportunity,
        [hashtable]$parentPhase,
        [ValidateLength(1, 50)]
        [string]$wbsCode,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billTime,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billExpenses,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billProducts,
        [bool]$markAsMilestoneFlag,
        [string]$notes,
        [string]$deadlineDate,
        [bool]$billSeparatelyFlag,
        [ValidateSet('ActualRates', 'FixedFee', 'NotToExceed', 'OverrideRate')]
        [string]$billingMethod,
        [double]$scheduledHours,
        [string]$scheduledStart,
        [string]$scheduledEnd,
        [double]$actualHours,
        [string]$actualStart,
        [string]$actualEnd,
        [double]$budgetHours,
        [int]$locationId,
        [int]$businessUnitId,
        [double]$hourlyRate,
        [string]$billingStartDate,
        [bool]$billPhaseClosedFlag,
        [bool]$billProjectClosedFlag,
        [double]$downpayment,
        [string]$poNumber,
        [double]$poAmount,
        [double]$estimatedTimeCost,
        [double]$estimatedExpenseCost,
        [double]$estimatedProductCost,
        [double]$estimatedTimeRevenue,
        [double]$estimatedExpenseRevenue,
        [double]$estimatedProductRevenue,
        [hashtable]$currency,
        [hashtable]$billToCompany,
        [hashtable]$billToContact,
        [hashtable]$billToSite,
        [hashtable]$shipToCompany,
        [hashtable]$shipToContact,
        [hashtable]$shipToSite,
        [hashtable]$_info,
        [hashtable[]]$customFields
    )

    $Endpoint = "/project/projects/$($parentId)/phases"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}