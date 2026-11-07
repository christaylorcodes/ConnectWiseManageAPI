<#
.SYNOPSIS
    Creates a time entry.

.DESCRIPTION
    Creates a time entry in ConnectWise Manage. Calls POST /time/entries; only the parameters you pass are
    sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER company
    Company reference, for example @{ id = 250 }.

.PARAMETER chargeToId
    Charge to id. An integer. If chargeToId is not specified, we assume you enter time against the company
    specified.

.PARAMETER chargeToType
    Charge to type. One of: Company, ServiceTicket, ProjectTicket, ChargeCode, Activity. If chargeToId is
    not specified, we assume you enter time against the company specified.

.PARAMETER member
    Member reference, for example @{ id = 10 }.

.PARAMETER locationId
    Location id. An integer.

.PARAMETER businessUnitId
    Business unit id. An integer.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER agreement
    Agreement reference, for example @{ id = 30 }.

.PARAMETER timeStart
    Time start. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw. Required by
    the API.

.PARAMETER timeEnd
    Time end. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER hoursDeduct
    Hours deduct. A number.

.PARAMETER actualHours
    Actual hours. A number.

.PARAMETER billableOption
    Billable option. One of: Billable, DoNotBill, NoCharge, NoDefault. Required on updates.

.PARAMETER notes
    Notes.

.PARAMETER internalNotes
    Internal notes.

.PARAMETER addToDetailDescriptionFlag
    Add to detail description flag. $true or $false.

.PARAMETER addToInternalAnalysisFlag
    Add to internal analysis flag. $true or $false.

.PARAMETER addToResolutionFlag
    Add to resolution flag. $true or $false.

.PARAMETER emailResourceFlag
    Email resource flag. $true or $false. This is an action flag. To update this value use the
    /service/tickets endpoint automaticEmailResourceFlag field.

.PARAMETER emailContactFlag
    Email contact flag. $true or $false. This is an action flag. To update this value use the
    /service/tickets endpoint automaticEmailContactFlag field.

.PARAMETER emailCcFlag
    Email CC flag. $true or $false. This is an action flag. To update this value use the /service/tickets
    endpoint automaticEmailCcFlag field.

.PARAMETER emailCc
    Email CC. To update this value use the /service/tickets endpoint automaticEmailCc field.

.PARAMETER hoursBilled
    Hours billed. A number.

.PARAMETER enteredBy
    Entered by.

.PARAMETER dateEntered
    Date entered. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER invoice
    Invoice reference, for example @{ id = 1 }.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER hourlyRate
    Hourly rate. A number. This field may only be Updated, it is defaulted on Create.

.PARAMETER timeSheet
    Time sheet reference, for example @{ id = 1 }.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMTimeEntry -chargeToType 'ServiceTicket' -chargeToId 1234 -member @{ id = 10 } -timeStart (ConvertTo-CWMTime (Get-Date).AddHours(-1) -Raw) -timeEnd (ConvertTo-CWMTime (Get-Date) -Raw) -notes 'Replaced the failed drive.'

    Logs the last hour of work by member 10 against service ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMTimeEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true, ParameterSetName = 'Company')]
        [hashtable]$company,
        [Parameter(Mandatory = $true, ParameterSetName = 'ChargeTo')]
        [int]$chargeToId,
        [Parameter(Mandatory = $true, ParameterSetName = 'ChargeTo')]
        [ValidateSet('ServiceTicket', 'ProjectTicket', 'ChargeCode', 'Activity')]
        [string]$chargeToType,
        [hashtable]$member,
        [int]$locationId,
        [int]$businessUnitId,
        [hashtable]$workType,
        [hashtable]$workRole,
        [hashtable]$agreement,
        [Parameter(Mandatory = $true)]
        [string]$timeStart,
        [string]$timeEnd,
        [double]$hoursDeduct,
        [double]$actualHours,
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billableOption,
        [string]$notes,
        [string]$internalNotes,
        [boolean]$addToDetailDescriptionFlag,
        [boolean]$addToInternalAnalysisFlag,
        [boolean]$addToResolutionFlag,
        [boolean]$emailResourceFlag,
        [boolean]$emailContactFlag,
        [boolean]$emailCcFlag,
        [string]$emailCc,
        [double]$hoursBilled,
        [string]$enteredBy,
        [string]$dateEntered,
        [hashtable]$invoice,
        [guid]$mobileGuid,
        [double]$hourlyRate,
        [hashtable]$timeSheet,
        [hashtable[]]$customFields,
        [hashtable]$_info
    )

    $Endpoint = '/time/entries'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}