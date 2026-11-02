function New-CWMCompanyServiceTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [hashtable]$board,
        [hashtable]$type,
        [hashtable]$item,
        [hashtable]$subtype,
        [hashtable]$serviceLocation,
        [Parameter(Mandatory = $true)]
        [hashtable]$status,
        [hashtable]$source,
        [hashtable]$priority,
        [hashtable]$team,
        [hashtable]$company,
        [hashtable]$contact,
        [hashtable]$site,
        [bool]$assignedNotifyFlag,
        [hashtable]$location,
        [hashtable]$department,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$summary,
        [string]$problem,
        [double]$hoursBudget,
        [double]$hourlyRate,
        [string]$internalAnalysis,
        [string]$resolution,
        [bool]$timeBillableFlag,
        [bool]$expenseBillableFlag,
        [bool]$productBillableFlag,
        [ValidateLength(1, 25)]
        [string]$purchaseOrderNumber,
        [ValidateLength(1, 50)]
        [string]$reference,
        [double]$estimatedExpenseCost,
        [double]$estimatedExpenseRevenue,
        [double]$estimatedProductCost,
        [double]$estimatedProductRevenue,
        [double]$estimatedTimeCost,
        [double]$estimatedTimeRevenue,
        [bool]$billComplete_Flag,
        [bool]$billServiceSeparatelyFlag,
        [double]$billingAmount,
        [bool]$billUnapprovedTimeAndExpensesFlag,
        [bool]$overrideFlag,
        [bool]$timeInvoiceFlag,
        [bool]$expenseInvoiceFlag,
        [bool]$productInvoiceFlag,
        [hashtable]$agreement,
        [hashtable]$workRole,
        [hashtable]$workType,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billTime,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billExpenses,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billProducts,
        [ValidateSet('ActualRates', 'FixedFee', 'NotToExceed', 'OverrideRate')]
        [string]$billingMethod,
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$severity,
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$impact,
        [hashtable]$assignedBy,
        [int]$scheduleDaysBefore,
        [int]$serviceDaysBefore,
        [bool]$attachScheduleToNewServiceFlag,
        [bool]$templateFlag,
        [bool]$emailContactFlag,
        [bool]$emailResourceFlag,
        [bool]$emailCCFlag,
        [ValidateLength(1, 1000)]
        [string]$emailCC,
        [bool]$restrictDownpaymentFlag,
        [hashtable]$_info,
        [string]$connectWiseId
    )

    # Without a company in the body, the API returns 201 with id 0 and creates nothing
    if (!$PsBoundParameters.ContainsKey('company')) {
        $PsBoundParameters.company = @{ id = $parentId }
    }

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
