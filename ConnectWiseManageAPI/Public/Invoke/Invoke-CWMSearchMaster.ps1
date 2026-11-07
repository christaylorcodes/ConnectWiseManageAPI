<#
.SYNOPSIS
    Generic POST-based search handler for complex queries.

.DESCRIPTION
    Master function for POST-based search operations. Used when GET endpoints don't support
    complex queries or when the query string would be too long for a GET request.

    The search endpoint uses POST with query parameters in the request body, allowing for
    more complex filtering than standard GET requests.

    This function calls the ConnectWise Manage API endpoint: POST {Endpoint}/search

.PARAMETER Arguments
    Hashtable containing search parameters (sent as POST body):
    - condition: Filter string
    - orderBy: Sort specification
    - childConditions: Filter on child records
    - customFieldConditions: Filter on custom fields
    - fields: Field selection (sent as URL parameter)
    - page, pageSize: Pagination
    - all: Switch to retrieve all pages

.PARAMETER Endpoint
    The API endpoint path (e.g., '/service/tickets')

.EXAMPLE
    $args = @{
        condition = "company/id=250 and status/name='Open'"
        orderBy = "id desc"
        all = $true
    }
    Invoke-CWMSearchMaster -Arguments $args -Endpoint '/service/tickets'

    Searches for all open tickets for company 250.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by Get-CWM* functions when using search endpoints
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