<#
.SYNOPSIS
    Gets the contact notes of a contact.

.DESCRIPTION
    Retrieves the contact notes of a contact from ConnectWise Manage, or a single contact note by id. Calls
    GET /company/contacts/{parentId}/notes; -id adds /{id} and -count adds /count.

.PARAMETER parentId
    The id of the contact.
    Alias: contactId

.PARAMETER id
    The id of a single contact note to retrieve.
    Alias: noteId

.PARAMETER count
    Return only the number of matching contact notes instead of the records.

.PARAMETER condition
    Filter in ConnectWise Manage condition syntax, for example "text contains 'callback'".

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
    Only return these fields, for example @('id', 'text').

.PARAMETER all
    Retrieve every matching record, handling pagination automatically.

.EXAMPLE
    Get-CWMCompanyContactNote -parentId 12 -condition "text contains 'callback'" -all

    Retrieves the contact notes of contact 12 that match the condition.

.EXAMPLE
    Get-CWMCompanyContactNote -parentId 12 -id 5

    Retrieves contact note 5 of contact 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMCompanyContactNote {
    [CmdletBinding()]
    [Alias('Get-CWMContactNote')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [Alias('noteId')]
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

    $Endpoint = "/company/contacts/$($parentId)/notes"
    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
