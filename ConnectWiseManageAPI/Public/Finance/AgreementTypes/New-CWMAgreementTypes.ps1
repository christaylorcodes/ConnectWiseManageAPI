function New-CWMAgreementTypes {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$name,
        [ValidateSet('Prefix', 'Suffix')]
        [string]$prefixSuffixOption,
        [boolean]$defaultFlag,
        [boolean]$inactiveFlag,
        [boolean]$prePaymentFlag,
        [string]$invoicePreSuffix,
        [hashtable]$location,
        [hashtable]$department,
        [boolean]$restrictLocationFlag,
        [boolean]$restrictDepartmentFlag,
        [hashtable]$sla,
        [ValidateSet('Amount', 'Hours', 'Incidents')]
        [string]$applicationUnits,
        [double]$applicationLimit,
        [ValidateSet('Contract2Weeks', 'Contract4Weeks', 'ContractYear', 'CalendarMonth', 'CalendarQuarter', 'CalendarWeek', 'ContractQuarter', 'CalendarYear')]
        [string]$applicationCycle,
        [boolean]$applicationUnlimitedFlag,
        [boolean]$oneTimeFlag,
        [boolean]$coverAgreementTimeFlag,
        [boolean]$coverAgreementProductFlag,
        [boolean]$coverAgreementExpenseFlag,
        [boolean]$coverSalesTaxFlag,
        [boolean]$carryOverUnusedFlag,
        [boolean]$allowOverrunsFlag,
        [int]$expiredDays,
        [int]$limit,
        [boolean]$expireWhenZero,
        [boolean]$chargeToFirmFlag,
        [ValidateSet('Actual', 'Hourly')]
        [string]$employeeCompRate,
        [ValidateSet('Billing', 'Amount', 'Percent')]
        [string]$employeeCompNotExceed,
        [double]$compHourlyRate,
        [double]$compLimitAmount,
        [hashtable]$billingCycle,
        [boolean]$billOneTimeFlag,
        [hashtable]$billingTerms,
        [ValidateSet('ContractYear', 'CalendarYear')]
        [string]$invoicingCycle,
        [double]$billAmount,
        [boolean]$taxableFlag,
        [boolean]$restrictDownPaymentFlag,
        [string]$invoiceDescription,
        [boolean]$topCommentFlag,
        [boolean]$bottomCommentFlag,
        [hashtable]$workRole,
        [hashtable]$workType,
        [hashtable]$projectType,
        [hashtable]$invoiceTemplate,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billTime,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billExpenses,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billProducts,
        [boolean]$billableTimeInvoiceFlag,
        [boolean]$billableExpenseInvoiceFlag,
        [boolean]$billableProductInvoiceFlag,
        [boolean]$copyWorkRolesFlag,
        [boolean]$copyWorkTypesFlag,
        [array]$exclusionWorkRoleIds,
        [boolean]$addAllWorkRoleExclusions,
        [boolean]$removeAllWorkRoleExclusions,
        [array]$exclusionWorkTypeIds,
        [boolean]$addAllWorkTypeExclusions,
        [boolean]$removeAllWorkTypeExclusions,
        [string]$integrationXRef,
        [boolean]$prorateFlag,
        [hashtable]$emailTemplate,
        [boolean]$autoInvoiceFlag,
        [boolean]$invoiceProratedAdditionsFlag,
        [hashtable]$_info
    )

    if ($PSCmdlet.ShouldProcess($name, "Creating New Agreement Type")) {
        $Endpoint = '/finance/agreement/types'
        Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }

}
