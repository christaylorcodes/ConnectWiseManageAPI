<#
.SYNOPSIS
    Creates an invoice.

.DESCRIPTION
    Creates an invoice in ConnectWise Manage. Calls POST /finance/invoices; only the
    parameters you pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new record.

.PARAMETER invoiceNumber
    Invoice number.

.PARAMETER type
    Type. One of: Agreement, CreditMemo, DownPayment, Miscellaneous, Progress, Standard, Consolidated. Required by the API.

.PARAMETER status
    Status reference, for example @{ id = 1 }.

.PARAMETER company
    Company reference, for example @{ id = 1 }. Required by the API.

.PARAMETER billToCompany
    Bill to company reference, for example @{ id = 1 }.

.PARAMETER shipToCompany
    Ship to company reference, for example @{ id = 1 }.

.PARAMETER accountNumber
    Account number.

.PARAMETER applyToType
    Apply to type. One of: All, Agreement, Project, ProjectPhase, SalesOrder, Ticket.

.PARAMETER applyToId
    Apply to id. A whole number.

.PARAMETER attention
    Attention.

.PARAMETER shipToAttention
    Ship to attention.

.PARAMETER billingSite
    Billing site reference, for example @{ id = 1 }.

.PARAMETER billingSiteAddressLine1
    Billing site address line1.

.PARAMETER billingSiteAddressLine2
    Billing site address line2.

.PARAMETER billingSiteCity
    Billing site city.

.PARAMETER billingSiteState
    Billing site state.

.PARAMETER billingSiteZip
    Billing site zip.

.PARAMETER billingSiteCountry
    Billing site country.

.PARAMETER shippingSite
    Shipping site reference, for example @{ id = 1 }.

.PARAMETER shippingSiteAddressLine1
    Shipping site address line1.

.PARAMETER shippingSiteAddressLine2
    Shipping site address line2.

.PARAMETER shippingSiteCity
    Shipping site city.

.PARAMETER shippingSiteState
    Shipping site state.

.PARAMETER shippingSiteZip
    Shipping site zip.

.PARAMETER shippingSiteCountry
    Shipping site country.

.PARAMETER billingTerms
    Billing terms reference, for example @{ id = 1 }.

.PARAMETER reference
    Reference.

.PARAMETER customerPO
    Customer po.

.PARAMETER templateSetupId
    Template setup id. A whole number.

.PARAMETER invoiceTemplate
    Invoice template reference, for example @{ id = 1 }.

.PARAMETER emailTemplateId
    Email template id. A whole number.

.PARAMETER addToBatchEmailList
    Add to batch email list. $true or $false.

.PARAMETER date
    Date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER restrictDownpaymentFlag
    Restrict downpayment flag. $true or $false.

.PARAMETER locationId
    Location id. A whole number.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER departmentId
    Department id. A whole number.

.PARAMETER department
    Department reference, for example @{ id = 1 }.

.PARAMETER territoryId
    Territory id. A whole number.

.PARAMETER territory
    Territory reference, for example @{ id = 1 }.

.PARAMETER topComment
    Top comment.

.PARAMETER bottomComment
    Bottom comment.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER internalNotes
    Internal notes.

.PARAMETER downpaymentPreviouslyTaxedFlag
    Downpayment previously taxed flag. $true or $false.

.PARAMETER serviceTotal
    Service total. A number.

.PARAMETER overrideDownPaymentAmountFlag
    Override down payment amount flag. $true or $false.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER dueDate
    Due date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER expenseTotal
    Expense total. A number.

.PARAMETER productTotal
    Product total. A number.

.PARAMETER previousProgressApplied
    Previous progress applied. A number.

.PARAMETER serviceAdjustmentAmount
    Service adjustment amount. A number.

.PARAMETER agreementAmount
    Agreement amount. A number.

.PARAMETER downpaymentApplied
    Downpayment applied. A number.

.PARAMETER subtotal
    Subtotal. A number.

.PARAMETER total
    Total. A number.

.PARAMETER remainingDownpayment
    Remaining downpayment. A number.

.PARAMETER salesTax
    Sales tax. A number.

.PARAMETER adjustmentReason
    Adjustment reason.

.PARAMETER adjustedBy
    Adjusted by.

.PARAMETER closedBy
    Closed by.

.PARAMETER payments
    Payments. A number.

.PARAMETER credits
    Credits. A number.

.PARAMETER balance
    Balance. A number.

.PARAMETER specialInvoiceFlag
    Special invoice flag. $true or $false.

.PARAMETER billingSetupReference
    Billing setup reference reference, for example @{ id = 1 }.

.PARAMETER ticket
    Ticket reference, for example @{ id = 1 }.

.PARAMETER project
    Project reference, for example @{ id = 1 }.

.PARAMETER phase
    Phase reference, for example @{ id = 1 }.

.PARAMETER salesOrder
    Sales order reference, for example @{ id = 1 }.

.PARAMETER agreement
    Agreement reference, for example @{ id = 1 }.

.PARAMETER glBatch
    Gl batch reference, for example @{ id = 1 }.

.PARAMETER unbatchedBatch
    Unbatched batch reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom field values, for example @(@{ id = 4; value = 'x' }).

.EXAMPLE
    New-CWMInvoice -type Miscellaneous -company @{ id = 250 } -reference 'Project kickoff'

    Creates a miscellaneous invoice for company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMInvoice {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [string]$invoiceNumber,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Agreement', 'CreditMemo', 'DownPayment', 'Miscellaneous', 'Progress', 'Standard', 'Consolidated')]
        [string]$type,
        $status,
        [Parameter(Mandatory = $true)]
        $company,
        $billToCompany,
        $shipToCompany,
        [string]$accountNumber,
        [ValidateSet('All', 'Agreement', 'Project', 'ProjectPhase', 'SalesOrder', 'Ticket')]
        [string]$applyToType,
        [int]$applyToId,
        [string]$attention,
        [string]$shipToAttention,
        $billingSite,
        [string]$billingSiteAddressLine1,
        [string]$billingSiteAddressLine2,
        [string]$billingSiteCity,
        [string]$billingSiteState,
        [string]$billingSiteZip,
        [string]$billingSiteCountry,
        $shippingSite,
        [string]$shippingSiteAddressLine1,
        [string]$shippingSiteAddressLine2,
        [string]$shippingSiteCity,
        [string]$shippingSiteState,
        [string]$shippingSiteZip,
        [string]$shippingSiteCountry,
        $billingTerms,
        [string]$reference,
        [string]$customerPO,
        [int]$templateSetupId,
        $invoiceTemplate,
        [int]$emailTemplateId,
        [bool]$addToBatchEmailList,
        [string]$date,
        [bool]$restrictDownpaymentFlag,
        [int]$locationId,
        $location,
        [int]$departmentId,
        $department,
        [int]$territoryId,
        $territory,
        [string]$topComment,
        [string]$bottomComment,
        [bool]$taxableFlag,
        $taxCode,
        [string]$internalNotes,
        [bool]$downpaymentPreviouslyTaxedFlag,
        [float]$serviceTotal,
        [bool]$overrideDownPaymentAmountFlag,
        $currency,
        [string]$dueDate,
        [float]$expenseTotal,
        [float]$productTotal,
        [float]$previousProgressApplied,
        [float]$serviceAdjustmentAmount,
        [float]$agreementAmount,
        [float]$downpaymentApplied,
        [float]$subtotal,
        [float]$total,
        [float]$remainingDownpayment,
        [float]$salesTax,
        [string]$adjustmentReason,
        [string]$adjustedBy,
        [string]$closedBy,
        [float]$payments,
        [float]$credits,
        [float]$balance,
        [bool]$specialInvoiceFlag,
        $billingSetupReference,
        $ticket,
        $project,
        $phase,
        $salesOrder,
        $agreement,
        $glBatch,
        $unbatchedBatch,
        [hashtable]$_info,
        [array]$customFields
    )

    $Endpoint = '/finance/invoices'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
