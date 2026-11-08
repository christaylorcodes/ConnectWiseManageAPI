<#
.SYNOPSIS
    Gets the products of a service ticket.

.DESCRIPTION
    Retrieves the full products of a service ticket. Calls GET /procurement/products with the condition
    ticket/id={parentId}, combined with -condition when given; -count calls /procurement/products/count.

    GET /service/tickets/{id}/products is not used: it returns only id references, and the ConnectWise API
    documentation points to /procurement/products instead. Its suggested chargeToType/chargeToId condition
    names fields the product model does not have, so the product's ticket reference is used.

.PARAMETER parentId
    The id of the service ticket.
    Alias: ticketId

.PARAMETER count
    Return only the number of matching products instead of the records.

.PARAMETER condition
    An extra filter in ConnectWise Manage condition syntax, for example "catalogItem/identifier='LAPTOP'". It
    is combined with the ticket filter using 'and'.

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
    Only return these fields, for example @('id', 'quantity').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMTicketProduct -ticketId 1234 -all

    Retrieves every product of ticket 1234.

.EXAMPLE
    Get-CWMTicketProduct -ticketId 1234 -condition "catalogItem/identifier='LAPTOP'"

    Retrieves the LAPTOP products on ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMTicketProduct {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
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

    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }
    $null = $Arguments.Remove('parentId')

    $TicketCondition = "ticket/id=$($parentId)"
    $Arguments.condition = if ($condition) { "$TicketCondition and ($condition)" } else { $TicketCondition }

    Invoke-CWMGetMaster -Arguments $Arguments -Endpoint '/procurement/products'
}
