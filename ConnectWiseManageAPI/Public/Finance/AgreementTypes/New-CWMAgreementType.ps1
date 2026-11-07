<#
.SYNOPSIS
    Creates an agreement type.

.DESCRIPTION
    Creates an agreement type in ConnectWise Manage. Calls POST /finance/agreements/types; only the
    parameters you pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER name
    Name. Max length 50. Required by the API.

.PARAMETER prefixSuffixOption
    Prefix suffix option. One of: Prefix, Suffix.

.PARAMETER defaultFlag
    Default flag. $true or $false.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER prePaymentFlag
    Pre payment flag. $true or $false.

.PARAMETER invoicePreSuffix
    Invoice pre suffix. Max length 5.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER department
    Department reference, for example @{ id = 1 }.

.PARAMETER restrictLocationFlag
    Restrict location flag. $true or $false.

.PARAMETER restrictDepartmentFlag
    Restrict department flag. $true or $false.

.PARAMETER sla
    SLA reference, for example @{ id = 1 }.

.PARAMETER applicationUnits
    Application units. One of: Amount, Hours, Incidents.

.PARAMETER applicationLimit
    Application limit. A number.

.PARAMETER applicationCycle
    Application cycle. One of: Contract2Weeks, Contract4Weeks, ContractYear, CalendarMonth, CalendarQuarter,
    CalendarWeek, ContractQuarter, CalendarYear.

.PARAMETER applicationUnlimitedFlag
    Application unlimited flag. $true or $false.

.PARAMETER oneTimeFlag
    One time flag. $true or $false.

.PARAMETER coverAgreementTimeFlag
    Cover agreement time flag. $true or $false.

.PARAMETER coverAgreementProductFlag
    Cover agreement product flag. $true or $false.

.PARAMETER coverAgreementExpenseFlag
    Cover agreement expense flag. $true or $false.

.PARAMETER coverSalesTaxFlag
    Cover sales tax flag. $true or $false.

.PARAMETER carryOverUnusedFlag
    Carry over unused flag. $true or $false.

.PARAMETER allowOverrunsFlag
    Allow overruns flag. $true or $false.

.PARAMETER expiredDays
    Expired days. An integer.

.PARAMETER limit
    Limit. An integer.

.PARAMETER expireWhenZero
    Expire when zero. $true or $false.

.PARAMETER chargeToFirmFlag
    Charge to firm flag. $true or $false.

.PARAMETER employeeCompRate
    Employee comp rate. One of: Actual, Hourly. Required by the API.

.PARAMETER employeeCompNotExceed
    Employee comp not exceed. One of: Billing, Amount, Percent. Required by the API.

.PARAMETER compHourlyRate
    Comp hourly rate. A number.

.PARAMETER compLimitAmount
    Comp limit amount. A number.

.PARAMETER billingCycle
    Billing cycle reference, for example @{ id = 1 }.

.PARAMETER billOneTimeFlag
    Bill one time flag. $true or $false.

.PARAMETER billingTerms
    Billing terms reference, for example @{ id = 1 }.

.PARAMETER invoicingCycle
    Invoicing cycle. One of: ContractYear, CalendarYear. Required by the API.

.PARAMETER billAmount
    Bill amount. A number.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER restrictDownPaymentFlag
    Restrict down payment flag. $true or $false.

.PARAMETER invoiceDescription
    Invoice description. Max length 4000.

.PARAMETER topCommentFlag
    Top comment flag. $true or $false.

.PARAMETER bottomCommentFlag
    Bottom comment flag. $true or $false.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER projectType
    Project type reference, for example @{ id = 1 }.

.PARAMETER invoiceTemplate
    Invoice template reference, for example @{ id = 1 }.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault. Required by the API.

.PARAMETER billExpenses
    Bill expenses. One of: Billable, DoNotBill, NoCharge, NoDefault. Required by the API.

.PARAMETER billProducts
    Bill products. One of: Billable, DoNotBill, NoCharge, NoDefault. Required by the API.

.PARAMETER billableTimeInvoiceFlag
    Billable time invoice flag. $true or $false.

.PARAMETER billableExpenseInvoiceFlag
    Billable expense invoice flag. $true or $false.

.PARAMETER billableProductInvoiceFlag
    Billable product invoice flag. $true or $false.

.PARAMETER copyWorkRolesFlag
    Copy work roles flag. $true or $false.

.PARAMETER copyWorkTypesFlag
    Copy work types flag. $true or $false.

.PARAMETER exclusionWorkRoleIds
    Exclusion work role ids. An array of integers.

.PARAMETER addAllWorkRoleExclusions
    Add all work role exclusions. $true or $false.

.PARAMETER removeAllWorkRoleExclusions
    Remove all work role exclusions. $true or $false.

.PARAMETER exclusionWorkTypeIds
    Exclusion work type ids. An array of integers.

.PARAMETER addAllWorkTypeExclusions
    Add all work type exclusions. $true or $false.

.PARAMETER removeAllWorkTypeExclusions
    Remove all work type exclusions. $true or $false.

.PARAMETER integrationXRef
    Integration XRef. Max length 50.

.PARAMETER prorateFlag
    Prorate flag. $true or $false.

.PARAMETER emailTemplate
    Email template reference, for example @{ id = 1 }.

.PARAMETER autoInvoiceFlag
    Auto invoice flag. $true or $false.

.PARAMETER invoiceProratedAdditionsFlag
    Invoice prorated additions flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    $AgreementType = @{
        name                  = 'Block Hours'
        employeeCompRate      = 'Actual'
        employeeCompNotExceed = 'Billing'
        invoicingCycle        = 'ContractYear'
        billTime              = 'Billable'
        billExpenses          = 'Billable'
        billProducts          = 'Billable'
    }
    New-CWMAgreementType @AgreementType

    Creates an agreement type with the properties the API requires.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMAgreementType {
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
        $Endpoint = '/finance/agreements/types'
        Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }

}
