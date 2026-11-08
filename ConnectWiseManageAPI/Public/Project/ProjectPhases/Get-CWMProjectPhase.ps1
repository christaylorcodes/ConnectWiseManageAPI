<#
.SYNOPSIS
    Gets the phases of a project.

.DESCRIPTION
    Retrieves the phases of a project from ConnectWise Manage, or a single phase by id. Calls GET
    /project/projects/{parentId}/phases; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the project.
    Alias: projectId

.PARAMETER id
    The id of a single phase to retrieve.

.PARAMETER count
    Return only the number of matching phases instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "description contains 'laptop'".

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
    Only return these fields, for example @('id', 'description').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMProjectPhase -parentId 12 -condition "description contains 'laptop'" -all

    Retrieves the phases of project 12 that match the condition.

.EXAMPLE
    Get-CWMProjectPhase -parentId 12 -id 5

    Retrieves phase 5 of project 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMProjectPhase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('projectId')]
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

    $Endpoint = "/project/projects/$($parentId)/phases"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
