<#
.SYNOPSIS
    Creates a service template for a company in ConnectWise Manage.

.DESCRIPTION
    Creates a company service (ticket) template.

    If -company is not specified, it is set to @{ id = <parentId> }. PR #82 reported that without a
    company in the body the API returns a record with id 0 and creates nothing. The caller's
    $PSBoundParameters is not modified.

    This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates

.PARAMETER parentId
    The ID of the company (required).
    Alias: companyId

.PARAMETER id
    Sent as id in the request body.

.PARAMETER name
    The name of the template (required, 1-100 characters).

.PARAMETER board
    The service board reference (required), e.g. @{ id = 1 }.

.PARAMETER type
    The board type reference, e.g. @{ id = 5 }.

.PARAMETER item
    The board item reference, e.g. @{ id = 7 }.

.PARAMETER subtype
    The board subtype reference, e.g. @{ id = 6 }.

.PARAMETER serviceLocation
    The service location reference, e.g. @{ id = 2 }.

.PARAMETER status
    The board status reference (required), e.g. @{ id = 16 }.

.PARAMETER source
    The source reference, e.g. @{ id = 2 }.

.PARAMETER priority
    The priority reference, e.g. @{ id = 4 }.

.PARAMETER team
    The service team reference, e.g. @{ id = 3 }.

.PARAMETER company
    The company reference, e.g. @{ id = 250 }.

.PARAMETER contact
    The contact reference, e.g. @{ id = 12 }.

.PARAMETER site
    The company site reference, e.g. @{ id = 9 }.

.PARAMETER assignedNotifyFlag
    Sets assignedNotifyFlag.

.PARAMETER location
    The location reference, e.g. @{ id = 1 }.

.PARAMETER department
    The department reference, e.g. @{ id = 1 }.

.PARAMETER summary
    The summary of the tickets created from the template (required, 1-100 characters).

.PARAMETER problem
    The problem description (initial description) text.

.PARAMETER hoursBudget
    The budgeted hours.

.PARAMETER hourlyRate
    The hourly rate.

.PARAMETER internalAnalysis
    The internal analysis text.

.PARAMETER resolution
    The resolution text.

.PARAMETER timeBillableFlag
    Sets timeBillableFlag.

.PARAMETER expenseBillableFlag
    Sets expenseBillableFlag.

.PARAMETER productBillableFlag
    Sets productBillableFlag.

.PARAMETER purchaseOrderNumber
    The purchase order number (1-25 characters).

.PARAMETER reference
    The reference (1-50 characters).

.PARAMETER estimatedExpenseCost
    The estimated expense cost.

.PARAMETER estimatedExpenseRevenue
    The estimated expense revenue.

.PARAMETER estimatedProductCost
    The estimated product cost.

.PARAMETER estimatedProductRevenue
    The estimated product revenue.

.PARAMETER estimatedTimeCost
    The estimated time cost.

.PARAMETER estimatedTimeRevenue
    The estimated time revenue.

.PARAMETER billComplete_Flag
    Sets billComplete_Flag.

.PARAMETER billServiceSeparatelyFlag
    Sets billServiceSeparatelyFlag.

.PARAMETER billingAmount
    The billing amount.

.PARAMETER billUnapprovedTimeAndExpensesFlag
    Sets billUnapprovedTimeAndExpensesFlag.

.PARAMETER overrideFlag
    Sets overrideFlag.

.PARAMETER timeInvoiceFlag
    Sets timeInvoiceFlag.

.PARAMETER expenseInvoiceFlag
    Sets expenseInvoiceFlag.

.PARAMETER productInvoiceFlag
    Sets productInvoiceFlag.

.PARAMETER agreement
    The agreement reference, e.g. @{ id = 30 }.

.PARAMETER workRole
    The work role reference, e.g. @{ id = 2 }.

.PARAMETER workType
    The work type reference, e.g. @{ id = 1 }.

.PARAMETER billTime
    How time is billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

.PARAMETER billExpenses
    How expenses are billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

.PARAMETER billProducts
    How products are billed: 'Billable', 'DoNotBill', 'NoCharge' or 'NoDefault'.

.PARAMETER billingMethod
    The billing method: 'ActualRates', 'FixedFee', 'NotToExceed' or 'OverrideRate'.

.PARAMETER severity
    The severity: 'Low', 'Medium' or 'High'.

.PARAMETER impact
    The impact: 'Low', 'Medium' or 'High'.

.PARAMETER assignedBy
    The member reference for assignedBy, e.g. @{ id = 140 }.

.PARAMETER scheduleDaysBefore
    Sets scheduleDaysBefore.

.PARAMETER serviceDaysBefore
    Sets serviceDaysBefore.

.PARAMETER attachScheduleToNewServiceFlag
    Sets attachScheduleToNewServiceFlag.

.PARAMETER templateFlag
    Sets templateFlag.

.PARAMETER emailContactFlag
    Sets emailContactFlag.

.PARAMETER emailResourceFlag
    Sets emailResourceFlag.

.PARAMETER emailCCFlag
    Sets emailCCFlag.

.PARAMETER emailCC
    The CC email address(es) (1-1000 characters).

.PARAMETER restrictDownpaymentFlag
    Sets restrictDownpaymentFlag.

.PARAMETER _info
    The _info metadata object, passed through to the request body.

.PARAMETER connectWiseId
    Sets connectWiseId.

.EXAMPLE
    $Template = @{
        parentId = 250
        name     = 'Monthly maintenance'
        summary  = 'Monthly maintenance'
        board    = @{ id = 1 }
        status   = @{ id = 16 }
    }
    New-CWMCompanyServiceTemplate @Template

    Creates a service template for company 250. The company is set to @{ id = 250 }.

.EXAMPLE
    New-CWMCompanyServiceTemplate -companyId 250 -name 'Patching' -summary 'Patching' -board @{ id = 1 } -status @{ id = 16 } -priority @{ id = 4 } -WhatIf

    Shows the request that would be sent without creating anything.

.NOTES
    Endpoint: POST /company/companies/{parentId}/serviceTemplates

    Based on PR #82 by mdewart-Centre. Unlike #82, the company default is added to a copy of
    $PSBoundParameters instead of to $PSBoundParameters itself.

.LINK
    Get-CWMCompanyServiceTemplate

.LINK
    Set-CWMCompanyServiceTemplate

.LINK
    Update-CWMCompanyServiceTemplate

.LINK
    Remove-CWMCompanyServiceTemplate

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the created company service template.

.INPUTS
    None. This function does not accept pipeline input.
#>
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

    # Work on a copy so $PSBoundParameters is never modified
    $Arguments = @{}
    foreach ($Key in $PsBoundParameters.Keys) { $Arguments[$Key] = $PsBoundParameters[$Key] }

    # Without a company in the body, the API returns a record with id 0 and creates nothing (PR #82)
    if (!$Arguments.ContainsKey('company')) {
        $Arguments.company = @{ id = $parentId }
    }

    $Endpoint = "/company/companies/$($parentId)/serviceTemplates"
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint $Endpoint
}
