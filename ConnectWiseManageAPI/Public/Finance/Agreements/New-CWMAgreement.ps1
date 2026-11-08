<#
.SYNOPSIS
    Creates an agreement.

.DESCRIPTION
    Creates an agreement in ConnectWise Manage. Calls POST /finance/agreements; only the parameters you pass
    are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER name
    Name. Max length 100. Required by the API.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER company
    Company reference, for example @{ id = 250 }. Required by the API.

.PARAMETER contact
    Contact reference, for example @{ id = 500 }. Required by the API.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER subContractCompany
    Sub contract company reference, for example @{ id = 1 }.

.PARAMETER subContractContact
    Sub contract contact reference, for example @{ id = 1 }.

.PARAMETER parentAgreement
    Parent agreement reference, for example @{ id = 1 }.

.PARAMETER customerPO
    Customer PO. Max length 50.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER department
    Department reference, for example @{ id = 1 }.

.PARAMETER restrictLocationFlag
    Restrict location flag. $true or $false.

.PARAMETER restrictDepartmentFlag
    Restrict department flag. $true or $false.

.PARAMETER startDate
    Start date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER endDate
    End date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER noEndingDateFlag
    No ending date flag. $true or $false.

.PARAMETER opportunity
    Opportunity reference, for example @{ id = 75 }.

.PARAMETER cancelledFlag
    Cancelled flag. $true or $false.

.PARAMETER dateCancelled
    Date cancelled. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER reasonCancelled
    Reason cancelled. Max length 100.

.PARAMETER sla
    SLA reference, for example @{ id = 1 }.

.PARAMETER workOrder
    Work order. Max length 20.

.PARAMETER internalNotes
    Internal notes.

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

.PARAMETER coverAgreementTime
    Cover agreement time. $true or $false.

.PARAMETER coverAgreementProduct
    Cover agreement product. $true or $false.

.PARAMETER coverAgreementExpense
    Cover agreement expense. $true or $false.

.PARAMETER coverSalesTax
    Cover sales tax. $true or $false.

.PARAMETER carryOverUnused
    Carry over unused. $true or $false.

.PARAMETER allowOverruns
    Allow overruns. $true or $false.

.PARAMETER expiredDays
    Expired days. An integer.

.PARAMETER limit
    Limit. An integer.

.PARAMETER expireWhenZero
    Expire when zero. $true or $false.

.PARAMETER chargeToFirm
    Charge to firm. $true or $false.

.PARAMETER employeeCompRate
    Employee comp rate. One of: Actual, Hourly. Required on updates.

.PARAMETER employeeCompNotExceed
    Employee comp not exceed. One of: Billing, Amount, Percent.

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
    Invoicing cycle. One of: ContractYear, CalendarYear. Required on updates.

.PARAMETER billToCompany
    Bill to company reference, for example @{ id = 1 }.

.PARAMETER billToContact
    Bill to contact reference, for example @{ id = 1 }.

.PARAMETER billToSite
    Bill to site reference, for example @{ id = 1 }.

.PARAMETER billAmount
    Bill amount. A number.

.PARAMETER taxable
    Taxable. $true or $false.

.PARAMETER prorateFirstBill
    Prorate first bill. A number.

.PARAMETER billStartDate
    Bill start date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER restrictDownPayment
    Restrict down payment. $true or $false.

.PARAMETER prorateFlag
    Prorate flag. $true or $false.

.PARAMETER invoiceDescription
    Invoice description.

.PARAMETER topComment
    Top comment. $true or $false.

.PARAMETER bottomComment
    Bottom comment. $true or $false.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER projectType
    Project type reference, for example @{ id = 1 }.

.PARAMETER invoiceTemplate
    Invoice template reference, for example @{ id = 1 }.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER billExpenses
    Bill expenses. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER billProducts
    Bill products. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER billableTimeInvoice
    Billable time invoice. $true or $false.

.PARAMETER billableExpenseInvoice
    Billable expense invoice. $true or $false.

.PARAMETER billableProductInvoice
    Billable product invoice. $true or $false.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER periodType
    Period type. One of: Current, Future, Both, Undefined.

.PARAMETER autoInvoiceFlag
    Auto invoice flag. $true or $false.

.PARAMETER nextInvoiceDate
    Next invoice date.

.PARAMETER companyLocation
    Company location reference, for example @{ id = 1 }.

.PARAMETER agreementStatus
    Agreement status. One of: Active, Cancelled, Expired, Inactive.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMAgreement -name 'Managed Services' -type @{ id = 1 } -company @{ id = 250 } -contact @{ id = 500 }

    Creates an agreement of agreement type 1 for company 250 with contact 500.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMAgreement {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$name,
        [hashtable]$type,
        [hashtable]$company,
        [hashtable]$contact,
        [hashtable]$site,
        [hashtable]$subContractCompany,
        [hashtable]$subContractContact,
        [hashtable]$parentAgreement,
        [ValidateLength(1, 50)]
        [string]$customerPO,
        [hashtable]$location,
        [hashtable]$department,
        [boolean]$restrictLocationFlag,
        [boolean]$restrictDepartmentFlag,
        [string]$startDate,
        [string]$endDate,
        [boolean]$noEndingDateFlag,
        [hashtable]$opportunity,
        [boolean]$cancelledFlag,
        [string]$dateCancelled,
        [ValidateLength(1, 100)]
        [string]$reasonCancelled,
        [hashtable]$sla,
        [ValidateLength(1, 20)]
        [string]$workOrder,
        [ValidateLength(1, 5000)]
        [string]$internalNotes,
        [ValidateSet('Amount', 'Hours', 'Incidents')]
        [string]$applicationUnits,
        [double]$applicationLimit,
        [ValidateSet('Contract2Weeks', 'Contract4Weeks', 'ContractYear', 'CalendarMonth', 'CalendarQuarter', 'CalendarWeek', 'ContractQuarter', 'CalendarYear')]
        [string]$applicationCycle,
        [boolean]$applicationUnlimitedFlag,
        [boolean]$oneTimeFlag,
        [boolean]$coverAgreementTime,
        [boolean]$coverAgreementProduct,
        [boolean]$coverAgreementExpense,
        [boolean]$coverSalesTax,
        [boolean]$carryOverUnused,
        [boolean]$allowOverruns,
        [int]$expiredDays,
        [int]$limit,
        [boolean]$expireWhenZero,
        [boolean]$chargeToFirm,
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
        [hashtable]$billToCompany,
        [hashtable]$billToContact,
        [hashtable]$billToSite,
        [double]$billAmount,
        [boolean]$taxable,
        [double]$prorateFirstBill,
        [string]$billStartDate,
        [hashtable]$taxCode,
        [boolean]$restrictDownPayment,
        [boolean]$prorateFlag,
        [string]$invoiceDescription,
        [boolean]$topComment,
        [boolean]$bottomComment,
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
        [boolean]$billableTimeInvoice,
        [boolean]$billableExpenseInvoice,
        [boolean]$billableProductInvoice,
        [hashtable]$currency,
        [ValidateSet('Current', 'Future', 'Both', 'Undefined')]
        [string]$periodType,
        [boolean]$autoInvoiceFlag,
        [string]$nextInvoiceDate,
        [hashtable]$companyLocation,
        [ValidateSet('Active', 'Cancelled', 'Expired', 'Inactive')]
        [string]$agreementStatus,
        [hashtable]$_info,
        [array]$customFields
    )

    $Endpoint = '/finance/agreements'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
