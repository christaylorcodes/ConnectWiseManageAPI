<#
.SYNOPSIS
    Gets configuration statuses.

.DESCRIPTION
    Retrieves configuration statuses from ConnectWise Manage, or a single configuration status by id. Calls GET
    /company/configurations/statuses; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single configuration status to retrieve.

.PARAMETER count
    Return only the number of matching configuration statuses instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "closedFlag=false".

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
    Get-CWMConfigurationStatus -all

    Retrieves every configuration status.

.EXAMPLE
    Get-CWMConfigurationStatus -id 5

    Retrieves configuration status 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMConfigurationStatus {
    [CmdletBinding()]
    param(
        [Alias('statusId')]
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

    $Endpoint = '/company/configurations/statuses'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
