<#
.SYNOPSIS
    Creates a new project ticket in ConnectWise Manage.

.DESCRIPTION
    Creates a ticket on a project. summary and project are required; other fields are optional
    and use system defaults when not specified. Use -phase to place the ticket on a project phase.

    The fields mirror the service ticket model (New-CWMTicket) restricted to a conservative
    subset; the full project ticket schema could not be checked against the ConnectWise API
    documentation. Any field not listed here can still be set afterwards with
    Update-CWMProjectTicket.

    This function calls the ConnectWise Manage API endpoint: POST /project/tickets

.PARAMETER summary
    The ticket summary/title (required). Maximum 100 characters.

.PARAMETER project
    Reference to the project the ticket belongs to (required). Format: @{ id = 386 }

.PARAMETER phase
    Reference to the project phase. Format: @{ id = 12 }

.PARAMETER wbsCode
    The work breakdown structure code. Maximum 50 characters.

.PARAMETER board
    Reference to the project board. Format: @{ id = 5 }

.PARAMETER status
    Reference to the status. Format: @{ id = 456 }

.PARAMETER company
    Reference to the company. Format: @{ id = 250 }

.PARAMETER site
    Reference to the company site. Format: @{ id = 10 }

.PARAMETER contact
    Reference to the contact. Format: @{ id = 789 }

.PARAMETER contactName
    The contact's name. Maximum 62 characters.

.PARAMETER contactPhoneNumber
    The contact's phone number. Maximum 20 characters.

.PARAMETER contactEmailAddress
    The contact's email address. Maximum 250 characters.

.PARAMETER type
    Reference to the ticket type. Format: @{ id = 100 }

.PARAMETER subType
    Reference to the ticket subtype. Format: @{ id = 200 }

.PARAMETER item
    Reference to the ticket item. Format: @{ id = 50 }

.PARAMETER priority
    Reference to the priority. Format: @{ id = 3 }

.PARAMETER owner
    Reference to the owning member. Format: @{ id = 150 }

.PARAMETER serviceLocation
    Reference to the service location. Format: @{ id = 1 }

.PARAMETER source
    Reference to the ticket source. Format: @{ id = 2 }

.PARAMETER agreement
    Reference to the agreement. Format: @{ id = 30 }

.PARAMETER requiredDate
    The date the ticket is required by, as an ISO 8601 string, e.g. '2026-12-01T00:00:00Z'.

.PARAMETER budgetHours
    The budgeted hours for the ticket.

.PARAMETER estimatedStartDate
    The estimated start date, as an ISO 8601 string.

.PARAMETER billTime
    How time on the ticket is billed. Passed to the API as-is.

.PARAMETER billExpenses
    How expenses on the ticket are billed. Passed to the API as-is.

.PARAMETER billProducts
    How products on the ticket are billed. Passed to the API as-is.

.PARAMETER externalXRef
    External cross reference. Maximum 100 characters.

.PARAMETER initialDescription
    The initial description of the ticket.

.PARAMETER initialInternalAnalysis
    Initial internal analysis notes (not visible to contacts).

.PARAMETER initialResolution
    Initial resolution notes.

.PARAMETER customFields
    Array of custom field hashtables. Format: @(@{ id = 1; value = 'x' })

.EXAMPLE
    New-CWMProjectTicket -summary 'Migrate file shares' -project @{id=386}

    Creates a project ticket on project 386.

.EXAMPLE
    $Ticket = @{
        summary            = 'Configure backups'
        project            = @{ id = 386 }
        phase              = @{ id = 12 }
        budgetHours        = 4
        initialDescription = 'Set up nightly backups for the new servers.'
    }
    New-CWMProjectTicket @Ticket

    Creates a project ticket on phase 12 of project 386 with a 4 hour budget.

.NOTES
    Fields mirror the service ticket model (New-CWMTicket); they have not been verified
    against the project ticket schema in the ConnectWise API documentation.

.LINK
    Get-CWMProjectTicket

.LINK
    Update-CWMProjectTicket

.LINK
    New-CWMTicket

.LINK
    https://developer.connectwise.com/Products/ConnectWise_PSA/REST
#>
function New-CWMProjectTicket {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 100)]
        [string]$summary,
        [Parameter(Mandatory = $true)]
        [hashtable]$project,
        [hashtable]$phase,
        [ValidateLength(1, 50)]
        [string]$wbsCode,
        [hashtable]$board,
        [hashtable]$status,
        [hashtable]$company,
        [hashtable]$site,
        [hashtable]$contact,
        [ValidateLength(1, 62)]
        [string]$contactName,
        [ValidateLength(1, 20)]
        [string]$contactPhoneNumber,
        [ValidateLength(1, 250)]
        [string]$contactEmailAddress,
        [hashtable]$type,
        [hashtable]$subType,
        [hashtable]$item,
        [hashtable]$priority,
        [hashtable]$owner,
        [hashtable]$serviceLocation,
        [hashtable]$source,
        [hashtable]$agreement,
        [string]$requiredDate,
        [decimal]$budgetHours,
        [string]$estimatedStartDate,
        [string]$billTime,
        [string]$billExpenses,
        [string]$billProducts,
        [ValidateLength(1, 100)]
        [string]$externalXRef,
        [string]$initialDescription,
        [string]$initialInternalAnalysis,
        [string]$initialResolution,
        [hashtable[]]$customFields
    )

    $Endpoint = '/project/tickets'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
