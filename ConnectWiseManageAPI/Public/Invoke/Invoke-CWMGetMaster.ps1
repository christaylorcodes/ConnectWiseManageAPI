<#
.SYNOPSIS
    Generic GET request handler for retrieving ConnectWise Manage records.

.DESCRIPTION
    Master function for all GET operations in the module. Handles direct ID lookups,
    counting, filtering, sorting, field selection, and pagination.

    Used by all Get-CWM* functions (Get-CWMTicket, Get-CWMCompany, etc.) to retrieve data.
    Automatically routes to Invoke-CWMAllResult when -all switch is used.

    This function calls the ConnectWise Manage API endpoint: GET {Endpoint}

.PARAMETER Arguments
    Hashtable containing query parameters:
    - id: Direct ID lookup
    - condition: Filter string
    - orderBy: Sort specification
    - childConditions: Filter on child records
    - customFieldConditions: Filter on custom fields
    - page, pageSize: Pagination
    - pageId: Record id to start forward-only pagination from (sent as &pageId=)
    - fields: Field selection array
    - all: Switch to retrieve all pages
    - count: Switch to return count only

    The id is read from $Arguments.id only; variables in the caller's scope are never used.

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets', '/company/companies')

.EXAMPLE
    $QueryArguments = @{
        condition = "status/name='Open'"
        orderBy = "id desc"
        all = $true
    }
    Invoke-CWMGetMaster -Arguments $QueryArguments -Endpoint '/service/tickets'

    Retrieves all open tickets sorted by ID descending.

.EXAMPLE
    Invoke-CWMGetMaster -Arguments @{ id = 12345 } -Endpoint '/service/tickets'

    Retrieves ticket 12345 (GET /service/tickets/12345).

.EXAMPLE
    Invoke-CWMGetMaster -Arguments @{ pageId = 500; pageSize = 100 } -Endpoint '/service/tickets'

    Retrieves up to 100 tickets, starting from the page identified by pageId 500.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Get-CWM* functions
    - Handles pagination automatically with -all
    - Routes to Invoke-CWMAllResult for -all requests
    - Supports both direct lookups and filtered queries

    pageId support and the $Arguments.id fix are based on PR #82 by mdewart-Centre.

.LINK
    Invoke-CWMWebRequest

.LINK
    Invoke-CWMAllResult

.LINK
    Invoke-CWMSearchMaster

#>
function Invoke-CWMGetMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    $URLParameters = ''

    if ($Arguments.id) { $Endpoint = Join-Url $Endpoint $Arguments.id }

    if ($Arguments.count.IsPresent) { $Endpoint = Join-Url $Endpoint '/count' }

    if ($Arguments.condition) {
        $condition = [System.Web.HttpUtility]::UrlEncode($Arguments.condition)
        $URLParameters += "&conditions=$condition"
    }

    if ($Arguments.childConditions) {
        $childConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.childConditions)
        $URLParameters += "&childConditions=$childConditions"
    }

    if ($Arguments.customFieldConditions) {
        $customFieldConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.customFieldConditions)
        $URLParameters += "&customFieldConditions=$customFieldConditions"
    }

    if ($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URLParameters += "&fields=$fields"
    }

    if ($Arguments.orderBy) {
        $orderBy = [System.Web.HttpUtility]::UrlEncode($Arguments.orderBy)
        $URLParameters += "&orderBy=$orderBy"
    }

    if ($null -ne $Arguments.pageId) {
        $pageId = [System.Web.HttpUtility]::UrlEncode([string]$Arguments.pageId)
        $URLParameters += "&pageId=$pageId"
    }

    $URI = New-CWMUrl -Endpoint $Endpoint -URLParameters $URLParameters

    $WebRequestArguments = @{
        Uri    = $URI
        Method = 'GET'
    }

    if ($Arguments.all -and !$Arguments.count.IsPresent) { $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments }
    else {
        if ($Arguments.pageSize) { $WebRequestArguments.URI += "&pageSize=$($Arguments.pageSize)" }
        if ($Arguments.page) { $WebRequestArguments.URI += "&page=$($Arguments.page)" }

        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            try { $Result = ConvertFrom-CWMJson $Result.Content }
            catch {
                Write-Error 'There was an issue converting the results from JSON.'
                $_
            }
        }
    }

    if ($Arguments.count.IsPresent -and $Result.PSObject.Properties.count) { $Result = $Result.count }

    $Result | Write-Output
}
