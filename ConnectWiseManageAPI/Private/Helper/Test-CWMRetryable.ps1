function Test-CWMRetryable {
    # Retry only when repeating the request cannot create a duplicate:
    # - 429 Too Many Requests: the server rejected the request before processing it, any method.
    # - 502/503/504 gateway/availability errors: GET/HEAD only, or a request marked -ReadOnly (a search POST such
    #   as /service/tickets/search, which reads and changes nothing). A POST/PATCH/PUT/DELETE that writes may
    #   already have been applied before the gateway failed, so repeating it could create a duplicate ticket or
    #   time entry.
    # Other 4xx/5xx (bad request, auth, not found, conflict, 500) are not transient and are never retried.
    [CmdletBinding()]
    [OutputType([bool])]
    param([int]$StatusCode, [string]$Method, [switch]$ReadOnly)

    if ($StatusCode -eq 429) { return $true }
    if (@(502, 503, 504) -notcontains $StatusCode) { return $false }
    return ($ReadOnly -or !$Method -or @('Get', 'Head') -contains $Method)
}
