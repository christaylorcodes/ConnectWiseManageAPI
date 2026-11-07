<#
.SYNOPSIS
    Low-level HTTP request handler for all ConnectWise Manage API calls.

.DESCRIPTION
    Core function that handles all HTTP requests to the ConnectWise Manage API.
    Manages authentication headers, connection state, error handling, and automatic
    retry of transient failures that are safe to repeat.

    This is the foundation function used by all other Invoke-CWM*Master functions.
    It should rarely be called directly - use the higher-level master functions instead.
    Behaves the same on Windows PowerShell 5.1 and PowerShell 7.

    Key Features:
    - Validates connection state ($CWMServerConnection)
    - Adds authentication headers automatically
    - Handles URI formatting corrections
    - Retries 429 (any method) and 502/503/504 (GET/HEAD only) with Retry-After or exponential backoff
    - Provides detailed error messages with troubleshooting hints
    - Tracks API version headers

.PARAMETER Arguments
    Hashtable of arguments to pass to Invoke-WebRequest.
    Should include: Uri, Method, and optionally Body, Headers, ContentType, Version
    The hashtable is copied, so the caller's hashtable (and its Headers) is not modified.

.PARAMETER MaxRetry
    Maximum number of retry attempts. Default: 5
    Only 429 Too Many Requests (any method) and 502/503/504 on GET/HEAD are retried. Writes that fail with
    a 5xx are never retried, because the change may already have been applied and repeating it could create
    a duplicate. The wait is the server's Retry-After when present, otherwise 2, 4, 8, 16, 32 seconds
    (capped at 60 seconds).

.EXAMPLE
    $args = @{
        Uri = 'https://api.myconnectwise.net/v4_6_release/apis/3.0/service/tickets/12345'
        Method = 'GET'
    }
    Invoke-CWMWebRequest -Arguments $args

    Makes a GET request to retrieve a ticket.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Internal Function:
    - Called by all Invoke-CWM*Master functions
    - Handles authentication automatically
    - Manages retry logic with exponential backoff
    - Provides detailed error messages

    Insecure redirection (PowerShell 7.4+):
    - When connected with Connect-CWM -AllowInsecureRedirect, non-GET requests are sent with
      -AllowInsecureRedirect -MaximumRedirection 0 (redirects are never followed), and GET requests
      with -MaximumRedirection 50 (the default, re-applied because the setting persists on a shared session).
    - A caller-supplied non-zero MaximumRedirection disables the workaround for that call.

    Error Handling:
    - Validates connection state before requests
    - Parses API error responses
    - Provides context-specific troubleshooting hints
    - Retries only transient failures that are safe to repeat (see MaxRetry)
    - The parsed error body is kept in $script:ErrBody and the raw ErrorDetails in $script:ErrDetails

.LINK
    https://developer.connectwise.com/manage/rest

.LINK
    Connect-CWM

.LINK
    Invoke-CWMGetMaster

#>
function Invoke-CWMWebRequest {
    [CmdletBinding()]
    param(
        $Arguments,
        [int]$MaxRetry = 5
    )

    # Check that we have cached connection info
    if (!$script:CWMServerConnection) {
        $ErrorMessage = @()
        $ErrorMessage += 'Not connected to a Manage server.'
        $ErrorMessage += '--> $CWMServerConnection variable not found.'
        $ErrorMessage += "----> Run 'Connect-CWM' to initialize the connection before issuing other CWM cmdlets."
        return Write-Error ($ErrorMessage | Out-String)
    }

    # Work on copies: callers reuse their hashtable (Invoke-CWMAllResult, per page) and some pass the
    # connection's own Headers (Invoke-CWMSearchMaster), which must not pick up per-request changes.
    if ($Arguments -is [hashtable]) { $Arguments = $Arguments.Clone() }
    if ($Arguments.Headers -is [hashtable]) { $Arguments.Headers = $Arguments.Headers.Clone() }
    elseif (!$Arguments.Headers) { $Arguments.Headers = @{} }

    # Add default set of arguments
    foreach ($Key in $script:CWMServerConnection.Headers.Keys) {
        if ($Arguments.Headers.Keys -notcontains $Key) {
            # Set version
            if ($Key -eq 'Accept' -and $Arguments.Version -and $Arguments.Version -ne $script:CWMServerConnection.Version) {
                $Arguments.Headers.Accept = "application/vnd.connectwise.com+json; version=$($Arguments.Version)"
                Write-Verbose "Version Passed: $($Arguments.Version)"
            }
            else {
                $Arguments.Headers += @{$Key = $script:CWMServerConnection.Headers.$Key }
            }
        }
    }
    $Arguments.Remove('Version')

    if (!$Arguments.SessionVariable) { $Arguments.WebSession = $script:CWMServerConnection.Session }

    # Check URI format
    if ($Arguments.URI -notlike '*`?*' -and $Arguments.URI -like '*`&*') {
        $Arguments.URI = $Arguments.URI -replace '(.*?)&(.*)', '$1?$2'
    }

    # Opt-in workaround (Connect-CWM -AllowInsecureRedirect) for ConnectWise-hosted servers that return an
    # http:// Location header on writes, which PowerShell 7.4+ rejects as an insecure redirection.
    # -AllowInsecureRedirect is ONLY ever paired with -MaximumRedirection 0, so no redirect is followed and
    # nothing (including non-Secure session cookies) is sent over http. Any other redirect count combined
    # with -AllowInsecureRedirect would follow https->http redirects, so a caller-supplied non-zero
    # MaximumRedirection disables the workaround for that call.
    if ($script:CWMServerConnection.AllowInsecureRedirect -and $script:CWMSupportsInsecureRedirect) {
        $CallerSetRedirect = $Arguments.ContainsKey('MaximumRedirection')
        if (!$Arguments.Method -or $Arguments.Method -eq 'Get') {
            # MaximumRedirection 0 persists on a shared WebSession, so reads restore the .NET default explicitly
            if (!$CallerSetRedirect) { $Arguments.MaximumRedirection = 50 }
        }
        elseif (!$CallerSetRedirect -or $Arguments.MaximumRedirection -eq 0) {
            $Arguments.AllowInsecureRedirect = $true
            $Arguments.MaximumRedirection = 0
        }
    }

    # Hide the Invoke-WebRequest progress bar. Function scope only: never touch the caller's or the global preference.
    $ProgressPreference = 'SilentlyContinue'

    # Only build the debug dump when it will be shown: serializing a large (e.g. byte[] document) body is slow.
    # Binary bodies are summarized, the WebSession object is reduced to its type, and Authorization is masked.
    if ($DebugPreference -ne 'SilentlyContinue') {
        $DebugArguments = $Arguments.Clone()
        if ($DebugArguments.Body -is [byte[]]) { $DebugArguments.Body = "[$($DebugArguments.Body.Length) bytes]" }
        if ($DebugArguments.WebSession) { $DebugArguments.WebSession = $DebugArguments.WebSession.GetType().FullName }
        if ($DebugArguments.Headers -is [hashtable] -and $DebugArguments.Headers.Authorization) {
            $DebugArguments.Headers = $DebugArguments.Headers.Clone()
            $DebugArguments.Headers.Authorization = '[redacted]'
        }
        Write-Debug "Arguments: $($DebugArguments | ConvertTo-Json -Depth 5)"
    }

    # Issue request, retrying only where repeating the request cannot duplicate a change (see Test-CWMRetryable)
    $Attempt = 0
    while ($true) {
        $RetryDelay = $null
        try {
            # -Debug:$false: PowerShell 7's own debug output prints request headers, including Authorization
            $Result = Invoke-WebRequest @Arguments -UseBasicParsing -Debug:$false
        }
        catch {
            # Capture now: nested try/catch blocks below replace $_
            $WebError = $_

            # PowerShell 7.4+ insecure redirection check (any http:// Location header on an https request)
            if ($WebError.FullyQualifiedErrorId -like 'InsecureRedirection*') {
                $ErrorMessage = @(
                    'The server response pointed to an http:// address, which PowerShell 7.4+ rejects as an insecure redirection.'
                    '--> On ConnectWise-hosted servers this is usually a Location header on a successful create/update, not a real redirect.'
                    '--> The record MAY HAVE BEEN CREATED or changed. Check before retrying to avoid duplicates.'
                    "--> To work around it, reconnect with 'Connect-CWM ... -AllowInsecureRedirect'. See: Get-Help Connect-CWM -Parameter AllowInsecureRedirect"
                    $WebError.ScriptStackTrace
                )
                return Write-Error ($ErrorMessage | Out-String)
            }

            # 5.1: HttpWebResponse; 7: HttpResponseMessage. Both expose StatusCode.
            $Response = $null
            try { $Response = $WebError.Exception.Response } catch { $Response = $null }
            $StatusCode = 0
            try { if ($Response) { $StatusCode = [int]$Response.StatusCode } } catch { $StatusCode = 0 }

            # Redirect returned while redirects are disabled (e.g. by -AllowInsecureRedirect)
            if ($StatusCode -ge 300 -and $StatusCode -lt 400) {
                $Location = $null
                try { $Location = $Response.Headers.Location } catch { $Location = $null }
                $ErrorMessage = @(
                    "The server responded with a redirect ($StatusCode) that was not followed."
                    "--> Location: $Location"
                    '--> Redirects are not followed for this request (MaximumRedirection 0, e.g. via Connect-CWM -AllowInsecureRedirect), so it was not completed.'
                    '--> Please report this, including the status code and Location, at https://github.com/christaylorcodes/ConnectWiseManageAPI/issues'
                    $WebError.ScriptStackTrace
                )
                return Write-Error ($ErrorMessage | Out-String)
            }

            if ($Attempt -lt $MaxRetry -and (Test-CWMRetryable -StatusCode $StatusCode -Method $Arguments.Method)) {
                $RetryDelay = Get-CWMRetryDelay -Response $Response -Attempt ($Attempt + 1)
                Write-Warning "Issue with request, status: $StatusCode. Retry $($Attempt + 1)/$($MaxRetry), waiting $($RetryDelay)s."
            }
            else {
                return Write-CWMWebRequestError -WebError $WebError -StatusCode $StatusCode -Attempt $Attempt
            }
        }

        if ($null -eq $RetryDelay) { break }
        $Attempt++
        Start-Sleep -Seconds $RetryDelay
    }

    # Save current version
    if (!$script:CWMServerConnection.'api-current-version') {
        $script:CWMServerConnection.'api-current-version' = Get-CWMResponseHeader -Response $Result -Name 'api-current-version'
    }

    $Result
}
