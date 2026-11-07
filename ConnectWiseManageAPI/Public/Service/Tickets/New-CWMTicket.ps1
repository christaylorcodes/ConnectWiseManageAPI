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
