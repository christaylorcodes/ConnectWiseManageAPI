<#
.SYNOPSIS
    Creates a team member for a project.

.DESCRIPTION
    Creates a team member for a project in ConnectWise Manage. Calls POST
    /project/projects/{parentId}/teamMembers; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the project to add the team member to.
    Alias: projectId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER hours
    Hours. A number.

.PARAMETER member
    Member reference, for example @{ id = 10 }. Required by the API.

.PARAMETER projectRole
    Project role reference, for example @{ id = 1 }. Required by the API.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER startDate
    Start date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER endDate
    End date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMProjectTeamMember -parentId 40 -member @{ id = 10 } -projectRole @{ id = 1 }

    Adds member 10 to project 40 with project role 1.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
