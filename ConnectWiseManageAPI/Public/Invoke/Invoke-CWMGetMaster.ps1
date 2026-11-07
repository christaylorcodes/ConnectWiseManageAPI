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
    - fields: Field selection array
    - all: Switch to retrieve all pages
    - count: Switch to return count only

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets', '/company/companies')

.EXAMPLE
    $args = @{
        condition = "status/name='Open'"
        orderBy = "id desc"
        all = $true
    }
    Invoke-CWMGetMaster -Arguments $args -Endpoint '/service/tickets'

    Retrieves all open tickets sorted by ID descending.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Get-CWM* functions
    - Handles pagination automatically with -all
    - Routes to Invoke-CWMAllResult for -all requests
    - Supports both direct lookups and filtered queries

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

    if ($Arguments.id) { $Endpoint = Join-Url $Endpoint $id }

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
            try { $Result = $Result.content | ConvertFrom-Json }
            catch {
                Write-Error 'There was an issue converting the results from JSON.'
                $_
            }
        }
    }

    if ($Arguments.count.IsPresent -and $Result.PSObject.Properties.count) { $Result = $Result.count }

    $Result | Write-Output
}
