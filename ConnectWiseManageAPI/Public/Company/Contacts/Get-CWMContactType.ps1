<#
.SYNOPSIS
    Gets contact types.

.DESCRIPTION
    Retrieves the contact types from ConnectWise Manage, or a single contact type by id. Calls GET
    /company/contacts/types; -id adds /{id}.

.PARAMETER id
    The id of a single contact type to retrieve.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "description contains 'laptop'".
    Alias: conditions

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

.PARAMETER pageId
    Starts forward-only pagination at the page identified by this value.

.PARAMETER fields
    Only return these fields, for example @('id', 'description').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMContactType -condition "description contains 'laptop'" -all

    Retrieves the contact types that match the condition.

.EXAMPLE
    Get-CWMContactType -id 5

    Retrieves contact type 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMContactType {
    [CmdletBinding()]
    param(
        [int]$id,
        [Alias('conditions')]
        [string]$condition,
        [ValidatePattern('\S* (desc|asc)')]
        [string]$orderBy,
        [string]$childConditions,
        [string]$customFieldConditions,
        [int]$page,
        [int]$pageSize,
        [int]$pageId,
        [string[]]$fields,
        [switch]$all
    )

    $Endpoint = '/company/contacts/types'
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
