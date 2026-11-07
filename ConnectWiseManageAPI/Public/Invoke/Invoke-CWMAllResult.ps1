<#
.SYNOPSIS
    Automatic pagination handler that retrieves all pages of results.

.DESCRIPTION
    Handles automatic pagination for API requests using forward-only pagination.
    Called by Invoke-CWMGetMaster and Invoke-CWMSearchMaster when -all switch is used.

    Automatically follows pagination links in response headers to retrieve all pages
    of results. Uses page size 999 and forward-only pagination
    for better performance.

    This function iterates through all pages until no more results are available.

.PARAMETER Arguments
    Hashtable containing web request parameters:
    - Uri: Initial request URI
    - Method: HTTP method (GET or POST)
    - Body: Request body (for POST requests)
    - Headers: Request headers

.EXAMPLE
    $Condition = [System.Web.HttpUtility]::UrlEncode("status/name='Open'")
    $RequestArguments = @{
        Uri = "https://na.myconnectwise.net/v4_6_release/apis/3.0/service/tickets?conditions=$Condition"
        Method = 'GET'
    }
    Invoke-CWMAllResult -Arguments $RequestArguments

    Retrieves all pages of open tickets.

.NOTES
    Author: Chris Taylor

    Internal Function:
    - Called by Invoke-CWMGetMaster and Invoke-CWMSearchMaster
    - Uses forward-only pagination for performance
    - Uses page size 999
    - Follows Link headers for next page
    - Returns results from all pages

    Performance:
    - More efficient than manual pagination
    - Reduces number of API calls
    - Recommended for retrieving large datasets

.LINK
    Invoke-CWMWebRequest

.LINK
    Invoke-CWMGetMaster

.LINK
    Invoke-CWMSearchMaster

#>
function Invoke-CWMAllResult {
    [CmdletBinding()]
    param(
        $Arguments
    )

    # Update header for new pagination-type
    $Arguments.Headers += @{
        'pagination-type' = 'forward-only'
    }

    # Up the pagesize to max
    $Arguments.URI += '&pageSize=999'

    do {
        $PageResult = Invoke-CWMWebRequest -Arguments $Arguments
        if (!$PageResult) { return }
        if (!$PageResult.Headers.ContainsKey('Link')) {
            return Write-Error "The $((Get-PSCallStack)[2].Command) Endpoint doesn't support 'forward-only' pagination. Please report to ConnectWise."
        }

        $Link = Get-CWMResponseHeader -Response $PageResult -Name 'Link'
        if ($Link) { $NextPage = $Link.Split(';')[0].trimstart('<').trimend('>') }
        else { $NextPage = $null }
        $Arguments.Uri = $NextPage

        ConvertFrom-CWMJson $PageResult.Content
    }
    while ($NextPage)
}
