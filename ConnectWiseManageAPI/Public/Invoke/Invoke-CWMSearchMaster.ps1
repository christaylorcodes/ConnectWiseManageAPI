<#
.SYNOPSIS
    Generic POST-based search handler for complex queries.

.DESCRIPTION
    Master function for POST-based search operations. Used when GET endpoints don't support
    complex queries or when the query string would be too long for a GET request.

    The filter parameters go in the JSON request body, allowing for more complex filtering
    than standard GET requests. Field selection and paging go in the query string.

    This function calls the ConnectWise Manage API endpoint: POST {Endpoint}
    It does not append /search; the endpoint you pass must already include it
    (for example '/service/tickets/search'). Passing a collection endpoint such as
    '/service/tickets' would POST to the create endpoint instead.

.PARAMETER Arguments
    Hashtable containing search parameters:
    - condition: Filter string (POST body, as 'conditions')
    - orderBy: Sort specification (POST body)
    - childConditions: Filter on child records (POST body)
    - customFieldConditions: Filter on custom fields (POST body)
    - fields: Field selection (query string)
    - page, pageSize: Pagination (query string)
    - all: Switch to retrieve all pages

.PARAMETER Endpoint
    The full search endpoint path, including /search (e.g., '/service/tickets/search')

.EXAMPLE
    $SearchArguments = @{
        condition = "company/id=250 and status/name='Open'"
        orderBy = "id desc"
        all = $true
    }
    Invoke-CWMSearchMaster -Arguments $SearchArguments -Endpoint '/service/tickets/search'

    Searches for all open tickets for company 250.

.NOTES
    Author: Chris Taylor

    Internal Function:
    - Called by Get-CWMTicket for list queries (POST /service/tickets/search)
    - Uses POST method with JSON body
    - Supports UTF-8 encoding for international characters
    - Routes to Invoke-CWMAllResult for -all requests

.LINK
    Invoke-CWMWebRequest

.LINK
    Invoke-CWMGetMaster

.LINK
    Invoke-CWMAllResult

#>
function Invoke-CWMSearchMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    $Body = @{}
    switch ($Arguments.Keys) {
        'condition' { $Body.conditions = $Arguments.condition }
        'childConditions' { $Body.childConditions = $Arguments.childConditions }
        'customFieldConditions' { $Body.customFieldConditions = $Arguments.customFieldConditions }
        'orderBy' { $Body.orderBy = $Arguments.orderBy }
    }
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    if ($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URLParameters += "&fields=$fields"
    }

    $URI = New-CWMUrl -Endpoint $Endpoint -URLParameters $URLParameters

    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Post'
        ContentType = 'application/json; charset=utf-8' #needed for accented chars
        Body        = $Body
        Headers     = $script:CWMServerConnection.Headers
    }

    if ($Arguments.all) {
        $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments
    }
    else {
        if ($Arguments.pageSize) { $WebRequestArguments.URI += "&pageSize=$($Arguments.pageSize)" }
        if ($Arguments.page) { $WebRequestArguments.URI += "&page=$($Arguments.page)" }
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }
    }

    $Result | Write-Output
}