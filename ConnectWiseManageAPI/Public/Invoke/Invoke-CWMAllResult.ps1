<#
.SYNOPSIS
    Automatic pagination handler that retrieves all pages of results.

.DESCRIPTION
    Handles automatic pagination for API requests using forward-only pagination.
    Called by Invoke-CWMGetMaster and Invoke-CWMSearchMaster when -all switch is used.

    Automatically follows pagination links in response headers to retrieve all pages
    of results. Uses page size 1000 (the API maximum, or -PageSize) and forward-only pagination
    for better performance.

    This function iterates through all pages until no more results are available.

.PARAMETER Arguments
    Hashtable containing web request parameters:
    - Uri: Initial request URI
    - Method: HTTP method (GET or POST)
    - Body: Request body (for POST requests)
    - Headers: Request headers

.PARAMETER PageSize
    Records per request. Defaults to 1000, the API's maximum; values below 1 or above 1000 use 1000.

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
    - Uses page size 1000 (the API maximum) unless -PageSize is smaller
    - Follows Link headers for next page, but only to the connected server: the next-page URL must use
      https (or the scheme of the first request, never a downgrade) and the connection's host and port. Any other
      URL stops paging with an error, so credentials are never sent to another host.
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
        $Arguments,
        [int]$PageSize = 1000
    )
    if ($PageSize -lt 1 -or $PageSize -gt 1000) { $PageSize = 1000 }

    # The next-page URL comes from the server's Link header and is requested with the connection's credentials,
    # so it may only point at the connected server, over https (never a downgrade from the first request).
    try { $AllowedUri = [uri]"https://$($script:CWMServerConnection.Server)"; $AllowedHost = $AllowedUri.Host } catch { $AllowedUri = $null; $AllowedHost = $null }
    try { $FirstScheme = ([uri][string]$Arguments.Uri).Scheme } catch { $FirstScheme = $null }

    # Update header for new pagination-type
    $Arguments.Headers += @{
        'pagination-type' = 'forward-only'
    }

    $Arguments.URI += "&pageSize=$PageSize"

    do {
        $PageResult = Invoke-CWMWebRequest -Arguments $Arguments
        if (!$PageResult) { return }
        if (!$PageResult.Headers.ContainsKey('Link')) {
            return Write-Error "The $((Get-PSCallStack)[2].Command) Endpoint doesn't support 'forward-only' pagination. Please report to ConnectWise."
        }

        $Link = Get-CWMResponseHeader -Response $PageResult -Name 'Link'
        # Link may list several relations (<url>; rel="next", <url>; rel="last"). Follow rel="next"; a single
        # link without any rel is taken as the next page.
        $NextPage = $null
        if ($Link) {
            $Links = @($Link -split ',(?=\s*<)')
            $Next = $Links | Where-Object { $_ -match ';\s*rel\s*=\s*"?next"?' } | Select-Object -First 1
            if (!$Next -and $Links.Count -eq 1 -and $Links[0] -notmatch ';\s*rel\s*=') { $Next = $Links[0] }
            if ($Next -match '<([^>]+)>') { $NextPage = $Matches[1] }
        }
        $Arguments.Uri = $NextPage

        ConvertFrom-CWMJson $PageResult.Content

        if ($NextPage) {
            $NextUri = $null
            if (![uri]::TryCreate($NextPage, [System.UriKind]::Absolute, [ref]$NextUri) -or
                @('https', $FirstScheme) -notcontains $NextUri.Scheme -or
                !$AllowedHost -or $NextUri.Host -ne $AllowedHost -or $NextUri.UserInfo -or
                # Same port; an omitted port and the scheme's default (443 for https) count as equal
                ($NextUri.Port -ne $AllowedUri.Port -and !($NextUri.IsDefaultPort -and $AllowedUri.IsDefaultPort))) {
                return Write-Error "Stopped paging: the server's next-page link points to '$NextPage', which is not an https URL on the connected server ($AllowedHost). The results so far were returned. Please report this at https://github.com/christaylorcodes/ConnectWiseManageAPI/issues"
            }
        }
    }
    while ($NextPage)
}
