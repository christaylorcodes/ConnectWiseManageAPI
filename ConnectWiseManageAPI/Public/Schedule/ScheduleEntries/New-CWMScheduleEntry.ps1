function New-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [int]$objectId,
        [ValidateLength(1,250)]
        [string]$name,
        [Parameter(Mandatory=$true)]
        $member,
        $where,
        [string]$dateStart,
        [string]$dateEnd,
        $reminder,
        $status,
        [Parameter(Mandatory=$true)]
        $type,
        $span,
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
        $_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/schedule/entries"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
