<#
.SYNOPSIS
    Gets work types.

.DESCRIPTION
    Retrieves work types from ConnectWise Manage, or a single work type by id. Calls GET
    /time/workTypes; -id adds /{id} and -count adds /count.

.PARAMETER id
    The id of a single work type to retrieve.

.PARAMETER count
    Return only the number of matching work types instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "inactiveFlag=false".

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
    Get-CWMWorkType -all

    Retrieves every work type.

.EXAMPLE
    Get-CWMWorkType -id 5

    Retrieves work type 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMWorkType {
    [CmdletBinding()]
    param(
        [Alias('workTypeId')]
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

    $Endpoint = '/time/workTypes'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
