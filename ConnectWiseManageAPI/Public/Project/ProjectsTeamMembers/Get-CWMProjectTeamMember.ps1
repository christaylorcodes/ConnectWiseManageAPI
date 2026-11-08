<#
.SYNOPSIS
    Gets the team members of a project.

.DESCRIPTION
    Retrieves the team members of a project from ConnectWise Manage, or a single team member by id. Calls
    GET /project/projects/{parentId}/teamMembers; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the project.
    Alias: ProjectID

.PARAMETER id
    The id of a single team member to retrieve.

.PARAMETER count
    Return only the number of matching team members instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "member/identifier='jdoe'".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childConditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customFieldConditions
    Filter on custom field values, in condition syntax.

.PARAMETER page
    The page number to return. Use with -pageSize.

.PARAMETER pageSize
    The number of records per page. Without it the API's default page size applies.

.PARAMETER fields
    Only return these fields, for example @('id', 'projectId').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProjectTeamMember -parentId 12 -condition "member/identifier='jdoe'" -all

    Retrieves the team members of project 12 that match the condition.

.EXAMPLE
    Get-CWMProjectTeamMember -parentId 12 -id 5

    Retrieves team member 5 of project 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProjectTeamMember {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('ProjectID')]
        [int]$parentId,
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = "/project/projects/$($parentId)/teamMembers"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
