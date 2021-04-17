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
