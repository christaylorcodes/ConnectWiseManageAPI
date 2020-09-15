function New-CWMProjectTeamMember {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$ProjectID,
        [int]$id,
        [decimal]$hours,
        [Parameter(Mandatory=$true)]
        $member,
        [Parameter(Mandatory=$true)]
        $projectRole,
        $workRole,
        [string]$startDate,
        [string]$endDate,
        $_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/project/projects/$ProjectID/teamMembers"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
