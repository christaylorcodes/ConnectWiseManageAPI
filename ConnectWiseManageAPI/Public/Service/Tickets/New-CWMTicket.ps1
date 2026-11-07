<#
.SYNOPSIS
    Creates a new service ticket in ConnectWise Manage.

.DESCRIPTION
    Creates a new service ticket with the specified properties. The module only requires
    summary and company; any field you leave out is not sent, and ConnectWise Manage applies
    its own defaults or validation.

    This function calls the ConnectWise Manage API endpoint: POST /service/tickets

.PARAMETER summary
    The ticket summary/title (required). 1-100 characters (enforced by the parameter's ValidateLength).

.PARAMETER company
    Hashtable with company reference (required). Format: @{ id = 123 }

.PARAMETER board
    Hashtable with service board reference. Format: @{ id = 1 }
    If not specified, no board is sent and ConnectWise Manage decides the board.

.PARAMETER status
    Hashtable with status reference. Format: @{ id = 456 }
    If not specified, no status is sent and ConnectWise Manage decides the status.

.PARAMETER priority
    Hashtable with priority reference. Format: @{ id = 3 }

.PARAMETER type
    Hashtable with type reference. Format: @{ id = 100 }

.PARAMETER subType
    Hashtable with subtype reference. Format: @{ id = 200 }

.PARAMETER item
    Hashtable with item reference. Format: @{ id = 50 }

.PARAMETER contact
    Hashtable with contact reference. Format: @{ id = 789 }

.PARAMETER initialDescription
    The initial description/details for the ticket. Supports HTML.

.PARAMETER initialInternalAnalysis
    Internal analysis notes (not visible to contacts).

.PARAMETER initialResolution
    Initial resolution notes.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER recordType
    Record type. One of: ProjectIssue, ProjectTicket, ServiceTicket.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER siteName
    Site name. Max length 156.

.PARAMETER addressLine1
    Address line 1. Max length 50.

.PARAMETER addressLine2
    Address line 2. Max length 50.

.PARAMETER city
    City. Max length 50.

.PARAMETER stateIdentifier
    State identifier. Max length 50.

.PARAMETER zip
    Zip. Max length 12.

.PARAMETER country
    Country reference, for example @{ id = 1 }.

.PARAMETER contactName
    Contact name. Max length 62.

.PARAMETER contactPhoneNumber
    Contact phone number. Max length 20.

.PARAMETER contactPhoneExtension
    Contact phone extension. Max length 15.

.PARAMETER contactEmailAddress
    Contact email address. Max length 250.

.PARAMETER team
    Team reference, for example @{ id = 1 }.

.PARAMETER owner
    Owner reference, for example @{ id = 1 }.

.PARAMETER serviceLocation
    Service location reference, for example @{ id = 1 }.

.PARAMETER source
    Source reference, for example @{ id = 1 }.

.PARAMETER requiredDate
    Required date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER budgetHours
    Budget hours. A number.

.PARAMETER opportunity
    Opportunity reference, for example @{ id = 75 }.

.PARAMETER agreement
    Agreement reference, for example @{ id = 30 }.

.PARAMETER severity
    Severity. One of: Low, Medium, High. Required on updates.

.PARAMETER impact
    Impact. One of: Low, Medium, High. Required on updates.

.PARAMETER externalXRef
    External XRef. Max length 100.

.PARAMETER poNumber
    PO number. Max length 50.

.PARAMETER knowledgeBaseCategoryId
    Knowledge base category id. An integer.

.PARAMETER knowledgeBaseSubCategoryId
    Knowledge base sub category id. An integer.

.PARAMETER allowAllClientsPortalView
    Allow all clients portal view. $true or $false.

.PARAMETER customerUpdatedFlag
    Customer updated flag. $true or $false.

.PARAMETER automaticEmailContactFlag
    Automatic email contact flag. $true or $false.

.PARAMETER automaticEmailResourceFlag
    Automatic email resource flag. $true or $false.

.PARAMETER automaticEmailCcFlag
    Automatic email CC flag. $true or $false.

.PARAMETER automaticEmailCc
    Automatic email CC. Max length 1000.

.PARAMETER contactEmailLookup
    Contact email lookup.

.PARAMETER processNotifications
    Process notifications. $true or $false. Can be set to false to skip notification processing when adding
    or updating a ticket (Defaults to True).

.PARAMETER skipCallback
    Skip callback. $true or $false.

.PARAMETER closedDate
    Closed date.

.PARAMETER closedBy
    Closed by.

.PARAMETER closedFlag
    Closed flag. $true or $false.

.PARAMETER actualHours
    Actual hours. A number.

.PARAMETER approved
    Approved. $true or $false.

.PARAMETER estimatedExpenseCost
    Estimated expense cost. A number.

.PARAMETER estimatedExpenseRevenue
    Estimated expense revenue. A number.

.PARAMETER estimatedProductCost
    Estimated product cost. A number.

.PARAMETER estimatedProductRevenue
    Estimated product revenue. A number.

.PARAMETER estimatedTimeCost
    Estimated time cost. A number.

.PARAMETER estimatedTimeRevenue
    Estimated time revenue. A number.

.PARAMETER billingMethod
    Billing method. One of: ActualRates, FixedFee, NotToExceed, OverrideRate.

.PARAMETER billingAmount
    Billing amount. A number.

.PARAMETER hourlyRate
    Hourly rate. A number.

.PARAMETER subBillingMethod
    Sub billing method. One of: ActualRates, FixedFee, NotToExceed, OverrideRate.

.PARAMETER subBillingAmount
    Sub billing amount. A number.

.PARAMETER subDateAccepted
    Sub date accepted.

.PARAMETER dateResolved
    Date resolved.

.PARAMETER dateResplan
    Date resplan.

.PARAMETER dateResponded
    Date responded.

.PARAMETER resolveMinutes
    Resolve minutes. An integer. To obtain the current SLA times for an active ticket, please use the
    /service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
    tickets.

.PARAMETER resPlanMinutes
    Res plan minutes. An integer. To obtain the current SLA times for an active ticket, please use the
    /service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
    tickets.

.PARAMETER respondMinutes
    Respond minutes. An integer. To obtain the current SLA times for an active ticket, please use the
    /service/tickets/calculateSLA endpoint for multiple tickets or /service/tickets/{id} for individual
    tickets.

.PARAMETER isInSla
    Is in SLA. $true or $false.

.PARAMETER knowledgeBaseLinkId
    Knowledge base link id. An integer.

.PARAMETER resources
    Resources.

.PARAMETER parentTicketId
    Parent ticket id. An integer.

.PARAMETER hasChildTicket
    Has child ticket. $true or $false.

.PARAMETER hasMergedChildTicketFlag
    Has merged child ticket flag. $true or $false.

.PARAMETER knowledgeBaseLinkType
    Knowledge base link type. One of: Activity, ProjectIssue, KnowledgeBaseArticle, ProjectTicket,
    ServiceTicket, Time.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER billExpenses
    Bill expenses. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER billProducts
    Bill products. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER predecessorType
    Predecessor type. One of: Ticket, Phase.

.PARAMETER predecessorId
    Predecessor id. An integer.

.PARAMETER predecessorClosedFlag
    Predecessor closed flag. $true or $false.

.PARAMETER lagDays
    Lag days. An integer.

.PARAMETER lagNonworkingDaysFlag
    Lag nonworking days flag. $true or $false.

.PARAMETER estimatedStartDate
    Estimated start date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER duration
    Duration. An integer.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER department
    Department reference, for example @{ id = 1 }.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER sla
    SLA reference, for example @{ id = 1 }.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER mergedParentTicket
    Merged parent ticket reference, for example @{ id = 1 }.

.PARAMETER integratorTags
    Integrator tags. An array of strings.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    # Minimal ticket creation
    $ticket = @{
        summary = "Password reset request"
        company = @{ id = 250 }
    }
    New-CWMTicket @ticket

    Creates a basic ticket with just summary and company.

.EXAMPLE
    # Full ticket with board, status, and description
    $ticket = @{
        summary = "Server offline - urgent"
        company = @{ id = 250 }
        board = @{ id = 1 }
        status = @{ id = 10 }
        priority = @{ id = 3 }
        initialDescription = "Production server is not responding. Multiple users affected."
    }
    New-CWMTicket @ticket

    Creates a detailed ticket with multiple properties.

.EXAMPLE
    # Ticket with contact information
    $ticketParams = @{
        summary = "Email not working"
        company = @{ id = 250 }
        contact = @{ id = 500 }
        contactPhoneNumber = "555-1234"
        contactEmailAddress = "user@company.com"
        initialDescription = "User reports unable to send/receive email."
    }
    New-CWMTicket @ticketParams

    Creates a ticket with contact details.

.NOTES
    Author: Chris Taylor

    Required Fields:
    - summary (string, max 100 chars)
    - company (hashtable with id)

    Common Optional Fields:
    - board, status, priority, type, subType, item
    - contact, contactName, contactPhoneNumber, contactEmailAddress
    - initialDescription, initialInternalAnalysis, initialResolution
    - owner, team, serviceLocation, source

.LINK
    https://developer.connectwise.com/manage/rest#/Tickets

.LINK
    Get-CWMTicket

.LINK
    Update-CWMTicket

.LINK
    Remove-CWMTicket

#>
function New-CWMTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium', PositionalBinding = $false)]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1,100)]
        [string]$summary,
        [string]$recordType,
        [hashtable]$board,
        [hashtable]$status,
        [Parameter(Mandatory = $true)]
        [hashtable]$company,
        [hashtable]$site,
        [ValidateLength(1,50)]
        [string]$siteName,
        [ValidateLength(1,50)]
        [string]$addressLine1,
        [ValidateLength(1,50)]
        [string]$addressLine2,
        [ValidateLength(1,50)]
        [string]$city,
        [ValidateLength(1,50)]
        [string]$stateIdentifier,
        [ValidateLength(1,12)]
        [string]$zip,
        [hashtable]$country,
        [hashtable]$contact,
        [ValidateLength(1,62)]
        [string]$contactName,
        [ValidateLength(1,20)]
        [string]$contactPhoneNumber,
        [ValidateLength(1,15)]
        [string]$contactPhoneExtension,
        [ValidateLength(1,250)]
        [string]$contactEmailAddress,
        [hashtable]$type,
        [hashtable]$subType,
        [hashtable]$item,
        [hashtable]$team,
        [hashtable]$owner,
        [hashtable]$priority,
        [hashtable]$serviceLocation,
        [hashtable]$source,
        [string]$requiredDate,
        [decimal]$budgetHours,
        [hashtable]$opportunity,
        [hashtable]$agreement,
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$severity,
        [ValidateSet('Low', 'Medium', 'High')]
        [string]$impact,
        [ValidateLength(1,100)]
        [string]$externalXRef,
        [ValidateLength(1,50)]
        [string]$poNumber,
        [int]$knowledgeBaseCategoryId,
        [int]$knowledgeBaseSubCategoryId,
        [boolean]$allowAllClientsPortalView,
        [boolean]$customerUpdatedFlag,
        [boolean]$automaticEmailContactFlag,
        [boolean]$automaticEmailResourceFlag,
        [boolean]$automaticEmailCcFlag,
        [ValidateLength(1,1000)]
        [string]$automaticEmailCc,
        [string]$initialDescription,
        [string]$initialInternalAnalysis,
        [string]$initialResolution,
        [string]$contactEmailLookup,
        [boolean]$processNotifications,
        [boolean]$skipCallback,
        [string]$closedDate,
        [string]$closedBy,
        [boolean]$closedFlag,
        [decimal]$actualHours,
        [boolean]$approved,
        [decimal]$estimatedExpenseCost,
        [decimal]$estimatedExpenseRevenue,
        [decimal]$estimatedProductCost,
        [decimal]$estimatedProductRevenue,
        [decimal]$estimatedTimeCost,
        [decimal]$estimatedTimeRevenue,
        [string]$billingMethod,
        [decimal]$billingAmount,
        [decimal]$hourlyRate,
        [string]$subBillingMethod,
        [decimal]$subBillingAmount,
        [string]$subDateAccepted,
        [string]$dateResolved,
        [string]$dateResplan,
        [string]$dateResponded,
        [int]$resolveMinutes,
        [int]$resPlanMinutes,
        [int]$respondMinutes,
        [boolean]$isInSla,
        [int]$knowledgeBaseLinkId,
        [string]$resources,
        [int]$parentTicketId,
        [boolean]$hasChildTicket,
        [boolean]$hasMergedChildTicketFlag,
        [string]$knowledgeBaseLinkType,
        [string]$billTime,
        [string]$billExpenses,
        [string]$billProducts,
        [string]$predecessorType,
        [int]$predecessorId,
        [boolean]$predecessorClosedFlag,
        [int]$lagDays,
        [boolean]$lagNonworkingDaysFlag,
        [string]$estimatedStartDate,
        [int]$duration,
        [hashtable]$location,
        [hashtable]$department,
        [guid]$mobileGuid,
        [hashtable]$sla,
        [hashtable]$currency,
        [hashtable]$mergedParentTicket,
        [string]$integratorTags,
        [hashtable]$_info,
        [hashtable[]]$customFields
    )
    $Endpoint = '/service/tickets'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
