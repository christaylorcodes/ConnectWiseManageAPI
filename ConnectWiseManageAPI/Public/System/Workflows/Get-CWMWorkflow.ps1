<#
.SYNOPSIS
    Gets workflow rules.

.DESCRIPTION
    Retrieves workflow rules from ConnectWise Manage, or a single workflow rule by id. Calls GET
    /system/workflows; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single workflow rule to retrieve.

.PARAMETER count
    Return only the number of matching workflow rules instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "activateFlag=true".

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
    Only return these fields, for example @('id', 'name').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMWorkflow -all

    Retrieves every workflow rule.

.EXAMPLE
    Get-CWMWorkflow -id 5

    Retrieves workflow rule 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMWorkflow {
    [CmdletBinding()]
    param(
        [Alias('workflowId')]
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

    $Endpoint = '/system/workflows'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
