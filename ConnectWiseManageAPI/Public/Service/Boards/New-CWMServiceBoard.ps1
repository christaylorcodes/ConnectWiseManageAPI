<#
.SYNOPSIS
    Creates a service board.

.DESCRIPTION
    Creates a service board in ConnectWise Manage. Calls POST /service/boards; only the parameters you pass
    are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER name
    Name. Max length 50. Required by the API.

.PARAMETER location
    Location reference, for example @{ id = 1 }. Required by the API.

.PARAMETER department
    Department reference, for example @{ id = 1 }. Required by the API.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER signOffTemplate
    Sign off template reference, for example @{ id = 1 }.

.PARAMETER sendToContactFlag
    Send to contact flag. $true or $false.

.PARAMETER contactTemplate
    Contact template reference, for example @{ id = 1 }.

.PARAMETER sendToResourceFlag
    Send to resource flag. $true or $false.

.PARAMETER resourceTemplate
    Resource template reference, for example @{ id = 1 }.

.PARAMETER projectFlag
    Project flag. $true or $false.

.PARAMETER showDependenciesFlag
    Show dependencies flag. $true or $false. This field only shows if it is Project Board.

.PARAMETER showEstimatesFlag
    Show estimates flag. $true or $false. This field only shows if it is Project Board.

.PARAMETER boardIcon
    Board icon reference, for example @{ id = 1 }.

.PARAMETER billTicketsAfterClosedFlag
    Bill tickets after closed flag. $true or $false.

.PARAMETER billTicketSeparatelyFlag
    Bill ticket separately flag. $true or $false.

.PARAMETER billUnapprovedTimeExpenseFlag
    Bill unapproved time expense flag. $true or $false.

.PARAMETER overrideBillingSetupFlag
    Override billing setup flag. $true or $false.

.PARAMETER dispatchMember
    Dispatch member reference, for example @{ id = 1 }.

.PARAMETER serviceManagerMember
    Service manager member reference, for example @{ id = 1 }.

.PARAMETER dutyManagerMember
    Duty manager member reference, for example @{ id = 1 }.

.PARAMETER oncallMember
    Oncall member reference, for example @{ id = 1 }.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER billExpense
    Bill expense. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER billProduct
    Bill product. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER autoCloseStatus
    Auto close status reference, for example @{ id = 1 }.

.PARAMETER autoAssignNewTicketsFlag
    Auto assign new tickets flag. $true or $false.

.PARAMETER autoAssignNewECTicketsFlag
    Auto assign new EC tickets flag. $true or $false.

.PARAMETER autoAssignNewPortalTicketsFlag
    Auto assign new portal tickets flag. $true or $false.

.PARAMETER discussionsLockedFlag
    Discussions locked flag. $true or $false.

.PARAMETER timeEntryLockedFlag
    Time entry locked flag. $true or $false.

.PARAMETER notifyEmailFrom
    Notify email from. Max length 50.

.PARAMETER notifyEmailFromName
    Notify email from name. Max length 60.

.PARAMETER closedLoopDiscussionsFlag
    Closed loop discussions flag. $true or $false.

.PARAMETER closedLoopResolutionFlag
    Closed loop resolution flag. $true or $false.

.PARAMETER closedLoopInternalAnalysisFlag
    Closed loop internal analysis flag. $true or $false.

.PARAMETER timeEntryDiscussionFlag
    Time entry discussion flag. $true or $false.

.PARAMETER timeEntryResolutionFlag
    Time entry resolution flag. $true or $false.

.PARAMETER timeEntryInternalAnalysisFlag
    Time entry internal analysis flag. $true or $false.

.PARAMETER problemSort
    Problem sort. One of: Ascending, Descending.

.PARAMETER resolutionSort
    Resolution sort. One of: Ascending, Descending.

.PARAMETER internalAnalysisSort
    Internal analysis sort. One of: Ascending, Descending.

.PARAMETER emailConnectorAllowReopenClosedFlag
    Email connector allow reopen closed flag. $true or $false.

.PARAMETER emailConnectorReopenStatus
    Email connector reopen status reference, for example @{ id = 1 }.

.PARAMETER emailConnectorReopenResourcesFlag
    Email connector reopen resources flag. $true or $false. This field can only be set when
    emailConnectorAllowReopenClosed is true.

.PARAMETER emailConnectorNewTicketNoMatchFlag
    Email connector new ticket no match flag. $true or $false. This field can only be set when
    emailConnectorAllowReopenClosed is true.

.PARAMETER emailConnectorNeverReopenByDaysFlag
    Email connector never reopen by days flag. $true or $false. This field can only be set when
    emailConnectorAllowReopenClosed is true.

.PARAMETER emailConnectorReopenDaysLimit
    Email connector reopen days limit. An integer. This field can only be set when
    emailConnectorNeverReopenByDaysFlag and emailConnectorAllowReopenClosed are both true This field is
    required when emailConnectorNeverReopenByDaysFlag is true.

.PARAMETER emailConnectorNeverReopenByDaysClosedFlag
    Email connector never reopen by days closed flag. $true or $false. This field can only be set when
    emailConnectorAllowReopenClosed is true.

.PARAMETER emailConnectorReopenDaysClosedLimit
    Email connector reopen days closed limit. An integer. This field can only be set when
    emailConnectorNeverReopenByDaysClosedFlag and emailConnectorAllowReopenClosed are both true This field
    is required when emailConnectorNeverReopenByDaysClosedFlag is true.

.PARAMETER useMemberDisplayNameFlag
    Use member display name flag. $true or $false.

.PARAMETER sendToCCFlag
    Send to CC flag. $true or $false.

.PARAMETER autoAssignTicketOwnerFlag
    Auto assign ticket owner flag. $true or $false.

.PARAMETER closedLoopAllFlag
    Closed loop all flag. $true or $false.

.PARAMETER percentageCalculation
    Percentage calculation. One of: ActualHours, Manual, ClosedPhases, ClosedTickets.

.PARAMETER allSort
    All sort. One of: Ascending, Descending.

.PARAMETER markFirstNoteIssueFlag
    Mark first note issue flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMServiceBoard -name 'Help Desk' -location @{ id = 1 } -department @{ id = 2 }

    Creates a service board for location 1 and department 2.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMServiceBoard {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [ValidateLength(1,50)]
        [Parameter(Mandatory=$true)]
        [string]$name,
        [hashtable]$location,
        [hashtable]$department,
        [bool]$inactiveFlag,
        [hashtable]$signOffTemplate,
        [bool]$sendToContactFlag,
        [hashtable]$contactTemplate,
        [bool]$sendToResourceFlag,
        [hashtable]$resourceTemplate,
        [bool]$projectFlag,
        [bool]$showDependenciesFlag,
        [bool]$showEstimatesFlag,
        [hashtable]$boardIcon,
        [bool]$billTicketsAfterClosedFlag,
        [bool]$billTicketSeparatelyFlag,
        [bool]$billUnapprovedTimeExpenseFlag,
        [bool]$overrideBillingSetupFlag,
        [hashtable]$dispatchMember,
        [hashtable]$serviceManagerMember,
        [hashtable]$dutyManagerMember,
        [hashtable]$oncallMember,
        [hashtable]$workRole,
        [hashtable]$workType,
        [ValidateSet('Billable','DoNotBill','NoCharge','NoDefault')]
        [string]$billTime,
        [ValidateSet('Billable','DoNotBill','NoCharge','NoDefault')]
        [string]$billExpense,
        [ValidateSet('Billable','DoNotBill','NoCharge','NoDefault')]
        [string]$billProduct,
        [hashtable]$autoCloseStatus,
        [bool]$autoAssignNewTicketsFlag,
        [bool]$autoAssignNewECTicketsFlag,
        [bool]$autoAssignNewPortalTicketsFlag,
        [bool]$discussionsLockedFlag,
        [bool]$timeEntryLockedFlag,
        [ValidateLength(1,50)]
        [string]$notifyEmailFrom,
        [ValidateLength(1,60)]
        [string]$notifyEmailFromName,
        [bool]$closedLoopDiscussionsFlag,
        [bool]$closedLoopResolutionFlag,
        [bool]$closedLoopInternalAnalysisFlag,
        [bool]$timeEntryDiscussionFlag,
        [bool]$timeEntryResolutionFlag,
        [bool]$timeEntryInternalAnalysisFlag,
        [ValidateSet('Ascending','Descending')]
        [string]$problemSort,
        [ValidateSet('Ascending','Descending')]
        [string]$resolutionSort,
        [ValidateSet('Ascending','Descending')]
        [string]$internalAnalysisSort,
        [bool]$emailConnectorAllowReopenClosedFlag,
        [hashtable]$emailConnectorReopenStatus,
        [bool]$emailConnectorReopenResourcesFlag,
        [bool]$emailConnectorNewTicketNoMatchFlag,
        [bool]$emailConnectorNeverReopenByDaysFlag,
        [int]$emailConnectorReopenDaysLimit,
        [bool]$emailConnectorNeverReopenByDaysClosedFlag,
        [int]$emailConnectorReopenDaysClosedLimit,
        [bool]$useMemberDisplayNameFlag,
        [bool]$sendToCCFlag,
        [bool]$autoAssignTicketOwnerFlag,
        [bool]$closedLoopAllFlag,
        [ValidateSet('ActualHours','Manual','ClosedPhases','ClosedTickets')]
        [string]$percentageCalculation,
        [ValidateSet('Ascending','Descending')]
        [string]$allSort,
        [bool]$markFirstNoteIssueFlag,
        [hashtable]$_info
    )

    $Endpoint = '/service/boards'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
