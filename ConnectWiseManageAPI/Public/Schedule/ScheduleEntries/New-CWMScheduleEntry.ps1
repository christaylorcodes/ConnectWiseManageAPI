<#
.SYNOPSIS
    Creates a schedule entry.

.DESCRIPTION
    Creates a schedule entry in ConnectWise Manage. Calls POST /schedule/entries; only the parameters you
    pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER objectId
    Object id. An integer.

.PARAMETER name
    Name. Max length 250.

.PARAMETER member
    Member reference, for example @{ id = 10 }.

.PARAMETER where
    Where reference, for example @{ id = 1 }.

.PARAMETER dateStart
    Date start. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER dateEnd
    Date end. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER reminder
    Reminder reference, for example @{ id = 1 }.

.PARAMETER status
    Status reference, for example @{ id = 1 }.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER span
    Span reference, for example @{ id = 1 }.

.PARAMETER doneFlag
    Done flag. $true or $false.

.PARAMETER acknowledgedFlag
    Acknowledged flag. $true or $false.

.PARAMETER ownerFlag
    Owner flag. $true or $false.

.PARAMETER meetingFlag
    Meeting flag. $true or $false.

.PARAMETER allowScheduleConflictsFlag
    Allow schedule conflicts flag. $true or $false.

.PARAMETER addMemberToProjectFlag
    Add member to project flag. $true or $false.

.PARAMETER projectRoleId
    Project role id. An integer.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER closeDate
    Close date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER hours
    Hours. A number.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMScheduleEntry -objectId 1234 -type @{ id = 4 } -member @{ id = 10 } -dateStart (ConvertTo-CWMTime (Get-Date) -Raw) -dateEnd (ConvertTo-CWMTime (Get-Date).AddHours(2) -Raw)

    Schedules member 10 for the next two hours on record 1234, using schedule type 4.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [int]$objectId,
        [ValidateLength(1,250)]
        [string]$name,
        [Parameter(Mandatory=$true)]
        [hashtable]$member,
        [hashtable]$where,
        [string]$dateStart,
        [string]$dateEnd,
        [hashtable]$reminder,
        [hashtable]$status,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [hashtable]$span,
        [boolean]$doneFlag,
        [boolean]$acknowledgedFlag,
        [boolean]$ownerFlag,
        [boolean]$meetingFlag,
        [boolean]$allowScheduleConflictsFlag,
        [boolean]$addMemberToProjectFlag,
        [int]$projectRoleId,
        [GUID]$mobileGuid,
        [string]$closeDate,
        [decimal]$hours,
        [hashtable]$_info
    )

    $Endpoint = '/schedule/entries'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
