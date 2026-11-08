<#
.SYNOPSIS
    Gets the member record of the authenticated member.

.DESCRIPTION
    Retrieves the MyMember record of the member the API credentials belong to. Calls GET /system/myMembers.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "identifier='ACME'".

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
    Only return these fields, for example @('id', 'identifier').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMMyMember -fields @('id', 'identifier', 'defaultEmail')

    Returns the id, identifier and default email setting of the connected member.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMMyMember {
    [CmdletBinding()]
    param(
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

    $Endpoint = '/system/myMembers'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
