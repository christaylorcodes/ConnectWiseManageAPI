<#
.SYNOPSIS
    Creates a phase for a project.

.DESCRIPTION
    Creates a phase for a project in ConnectWise Manage. Calls POST /project/projects/{parentId}/phases;
    only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the project to add the phase to.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER projectId
    Project id. An integer.

.PARAMETER description
    Description. Max length 100. Required by the API.

.PARAMETER board
    Board reference, for example @{ id = 1 }.

.PARAMETER status
    Status reference, for example @{ id = 1 }.

.PARAMETER agreement
    Agreement reference, for example @{ id = 30 }.

.PARAMETER opportunity
    Opportunity reference, for example @{ id = 75 }.

.PARAMETER parentPhase
    Parent phase reference, for example @{ id = 1 }.

.PARAMETER wbsCode
    WBS code. Max length 50.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER billExpenses
    Bill expenses. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER billProducts
    Bill products. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER markAsMilestoneFlag
    Mark as milestone flag. $true or $false.

.PARAMETER notes
    Notes.

.PARAMETER deadlineDate
    Deadline date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER billSeparatelyFlag
    Bill separately flag. $true or $false.

.PARAMETER billingMethod
    Billing method. One of: ActualRates, FixedFee, NotToExceed, OverrideRate. BillingMethod is required if
    the phase billSeparatelyFlag is true.

.PARAMETER scheduledHours
    Scheduled hours. A number.

.PARAMETER scheduledStart
    Scheduled start.

.PARAMETER scheduledEnd
    Scheduled end.

.PARAMETER actualHours
    Actual hours. A number.

.PARAMETER actualStart
    Actual start.

.PARAMETER actualEnd
    Actual end.

.PARAMETER budgetHours
    Budget hours. A number.

.PARAMETER locationId
    Location id. An integer.

.PARAMETER businessUnitId
    Business unit id. An integer.

.PARAMETER hourlyRate
    Hourly rate. A number.

.PARAMETER billingStartDate
    Billing start date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER billPhaseClosedFlag
    Bill phase closed flag. $true or $false. This phase can only be billed after it has been closed.

.PARAMETER billProjectClosedFlag
    Bill project closed flag. $true or $false. This phase can only be billed after the project has been
    closed.

.PARAMETER downpayment
    Downpayment. A number.

.PARAMETER poNumber
    PO number. Max length 25.

.PARAMETER poAmount
    PO amount. A number.

.PARAMETER estimatedTimeCost
    Estimated time cost. A number.

.PARAMETER estimatedExpenseCost
    Estimated expense cost. A number.

.PARAMETER estimatedProductCost
    Estimated product cost. A number.

.PARAMETER estimatedTimeRevenue
    Estimated time revenue. A number.

.PARAMETER estimatedExpenseRevenue
    Estimated expense revenue. A number.

.PARAMETER estimatedProductRevenue
    Estimated product revenue. A number.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER billToCompany
    Bill to company reference, for example @{ id = 1 }.

.PARAMETER billToContact
    Bill to contact reference, for example @{ id = 1 }.

.PARAMETER billToSite
    Bill to site reference, for example @{ id = 1 }.

.PARAMETER shipToCompany
    Ship to company reference, for example @{ id = 1 }.

.PARAMETER shipToContact
    Ship to contact reference, for example @{ id = 1 }.

.PARAMETER shipToSite
    Ship to site reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMProjectPhase -parentId 40 -description 'Discovery'

    Adds a phase named Discovery to project 40.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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