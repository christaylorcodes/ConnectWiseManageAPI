<#
.SYNOPSIS
    Gets service level agreements (SLAs).

.DESCRIPTION
    Retrieves the service level agreements (SLAs) from ConnectWise Manage, or a single service level
    agreement (SLA) by id. Calls GET /service/SLAs; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single service level agreement (SLA) to retrieve.

.PARAMETER count
    Return only the number of matching service level agreements (SLAs) instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "name contains 'Support'".

.PARAMETER orderBy
    Sort order as 'field asc' or 'field desc', for example 'id desc'.

.PARAMETER childconditions
    Filter on child (list) fields, in condition syntax.

.PARAMETER customfieldconditions
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
    Get-CWMSLA -condition "name contains 'Support'" -all

    Retrieves the service level agreements (SLAs) that match the condition.

.EXAMPLE
    Get-CWMSLA -id 5

    Retrieves service level agreement (SLA) 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMSLA {
    [CmdletBinding()]
    param(
        [int]$id,
        [switch]$count,
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        $orderBy,
        [string]$childconditions,
        [string]$customfieldconditions,
        [int]$page,
        [int]$pageSize,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/service/SLAs'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}