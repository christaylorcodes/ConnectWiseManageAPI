<#
.SYNOPSIS
    Creates an expense entry.

.DESCRIPTION
    Creates an expense entry in ConnectWise Manage. Calls POST /expense/entries; only the parameters you
    pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER company
    Company reference, for example @{ id = 250 }.

.PARAMETER chargeToId
    Charge to id. An integer.

.PARAMETER chargeToType
    Charge to type. One of: Company, ServiceTicket, ProjectTicket, ChargeCode, Activity. Company or
    chargeToType is required.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER member
    Member reference, for example @{ id = 10 }.

.PARAMETER paymentMethod
    Payment method reference, for example @{ id = 1 }.

.PARAMETER classification
    Classification reference, for example @{ id = 1 }.

.PARAMETER amount
    Amount. A number. Required by the API.

.PARAMETER billableOption
    Billable option. One of: Billable, DoNotBill, NoCharge, NoDefault.

.PARAMETER date
    Date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw. Required by the
    API.

.PARAMETER locationId
    Location id. An integer.

.PARAMETER businessUnitId
    Business unit id. An integer.

.PARAMETER notes
    Notes.

.PARAMETER agreement
    Agreement reference, for example @{ id = 30 }.

.PARAMETER agreementAmount
    Agreement amount. A number.

.PARAMETER odometerStart
    Odometer start. A number.

.PARAMETER odometerEnd
    Odometer end. A number.

.PARAMETER ticket
    Ticket reference, for example @{ id = 1234 }.

.PARAMETER project
    Project reference, for example @{ id = 40 }.

.PARAMETER phase
    Phase reference, for example @{ id = 1 }.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMExpenseEntry -company @{ id = 250 } -type @{ id = 1 } -amount 25.50 -date (ConvertTo-CWMTime (Get-Date) -Raw)

    Creates an expense entry of 25.50 with expense type 1 against company 250, dated now.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMExpenseEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [hashtable]$company,
        [int]$chargeToId,
        [ValidateSet ('Company', 'ServiceTicket', 'ProjectTicket', 'ChargeCode', 'Activity')]
        [string]$chargeToType,
        [parameter(Mandatory = $true)]
        [hashtable]$type,
        [Parameter(Mandatory = $true)]
        [hashtable]$member,
        [hashtable]$paymentMethod,
        [hashtable]$classification,
        [parameter(Mandatory = $true)]
        [double]$amount,
        [ValidateSet ('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billableOption,
        [parameter(Mandatory = $true)]
        [string]$date,
        [int]$locationId,
        [int]$businessUnitId,
        [string]$notes,
        [hashtable]$agreement,
        [double]$agreementAmount,
        [double]$odometerStart,
        [double]$odometerEnd,
        [hashtable]$ticket,
        [hashtable]$project,
        [hashtable]$phase,
        [hashtable[]]$customFields
    )

    $Endpoint = '/expense/entries'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
