function New-CWMProjectTeamMember {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('projectId')]
        [int]$parentId,
        [int]$id,
        [decimal]$hours,
        [Parameter(Mandatory = $true)]
        [hashtable]$member,
        [Parameter(Mandatory = $true)]
        [hashtable]$projectRole,
        [hashtable]$workRole,
        [string]$startDate,
        [string]$endDate,
        [hashtable]$_info
    )

    $Endpoint = "/project/projects/$($parentId)/teamMembers"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
