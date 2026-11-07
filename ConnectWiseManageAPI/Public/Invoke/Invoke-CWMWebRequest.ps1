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

    # Issue request
    try {
        Write-Debug "Arguments: $($Arguments | ConvertTo-Json)"
        $prevProgressPreference = $global:ProgressPreference
        $global:ProgressPreference = 'SilentlyContinue'

        $Result = Invoke-WebRequest @Arguments -UseBasicParsing

        $global:ProgressPreference = $prevProgressPreference
    }
    catch {
        $global:ProgressPreference = $prevProgressPreference

        # PowerShell 7.4+ insecure redirection check (any http:// Location header on an https request)
        if ($_.FullyQualifiedErrorId -like 'InsecureRedirection*') {
            $ErrorMessage = @(
                'The server response pointed to an http:// address, which PowerShell 7.4+ rejects as an insecure redirection.'
                '--> On ConnectWise-hosted servers this is usually a Location header on a successful create/update, not a real redirect.'
                '--> The record MAY HAVE BEEN CREATED or changed. Check before retrying to avoid duplicates.'
                "--> To work around it, reconnect with 'Connect-CWM ... -AllowInsecureRedirect'. See: Get-Help Connect-CWM -Parameter AllowInsecureRedirect"
                $_.ScriptStackTrace
            )
            return Write-Error ($ErrorMessage | Out-String)
        }

        # Redirect returned while redirects are disabled (e.g. by -AllowInsecureRedirect)
        $StatusCode = 0
        try { $StatusCode = [int]$_.Exception.Response.StatusCode } catch { $StatusCode = 0 }
        if ($StatusCode -ge 300 -and $StatusCode -lt 400) {
            $Location = $null
            try { $Location = $_.Exception.Response.Headers.Location } catch { $Location = $null }
            $ErrorMessage = @(
                "The server responded with a redirect ($StatusCode) that was not followed."
                "--> Location: $Location"
                '--> Redirects are not followed for this request (MaximumRedirection 0, e.g. via Connect-CWM -AllowInsecureRedirect), so it was not completed.'
                '--> Please report this, including the status code and Location, at https://github.com/christaylorcodes/ConnectWiseManageAPI/issues'
                $_.ScriptStackTrace
            )
            return Write-Error ($ErrorMessage | Out-String)
        }

        # Start error message
        $ErrorMessage = @()

        if ($_.Exception.Response) {
            try {
                # Read exception response
                #this can fail with some type of exceptions
                $ErrorStream = $_.Exception.Response.GetResponseStream()
                $Reader = New-Object System.IO.StreamReader($ErrorStream)
                $script:ErrBody = $Reader.ReadToEnd() | ConvertFrom-Json
            }
            catch {
                $script:ErrBody = $_.Exception.Response.Content
            }
            $ErrBody = $script:ErrBody
            if ($ErrBody.code) {
                $ErrorMessage += 'An exception code has been thrown.'
                $ErrorMessage += "--> $($ErrBody.code)"
                if ($ErrBody.code -eq 'Unauthorized') {
                    $ErrorMessage += "-----> $($ErrBody.message)"
                    $ErrorMessage += "-----> Use 'Disconnect-CWM' or 'Connect-CWM -Force' to set new authentication."
                }
                elseif ($ErrBody.code -eq 'ConnectWiseApi') {
                    switch ($ErrBody.message) {
                        'UserNotAuthenticated' {
                            $ErrorMessage += "-----> $($ErrBody.message)"
                            $ErrorMessage += '-----> Check your connection parameters and/or user permissions.'
                        }
                        Default {
                            $ErrorMessage += "-----> $($ErrBody.message)"
                            $ErrorMessage += '-----> ^ Error has not been documented please report. ^'
                        }
                    }
                }
                else {
                    $ErrorMessage += "-----> $($ErrBody.message)"
                    $ErrorMessage += '-----> ^ Error has not been documented please report. ^'
                }
            }
            elseif ($_.Exception.message) {
                $ErrorMessage += 'An exception has been thrown.'
                $ErrorMessage += "--> $($_.Exception.message)"
            }
        }

        if ($_.ErrorDetails) {
            $ErrorMessage += 'An error has been thrown.'
            $script:ErrDetails = $_.ErrorDetails
            $ErrorMessage += "--> $($ErrDetails.code)"
            $ErrorMessage += "--> $($ErrDetails.message)"
            if ($ErrDetails.errors.message) {
                $ErrorMessage += "-----> $($ErrDetails.errors.message)"
            }
        }

        if ($ErrorMessage.Length -lt 1) { $ErrorMessage = $_ }
        else { $ErrorMessage += $_.ScriptStackTrace }

        return Write-Error ($ErrorMessage | Out-String)
    }

    # Not sure this will be hit with current iwr error handling
    # May need to move to catch block need to find test
    # TODO Find test for retry
    # Retry the request
    $Retry = 0
    while ($Retry -lt $MaxRetry -and $Result.StatusCode -ge 500) {
        $Retry++
        # ConnectWise Manage recommended wait time
        $Wait = $([math]::pow( 2, $Retry))
        Write-Warning "Issue with request, status: $($Result.StatusCode) $($Result.StatusDescription)"
        Write-Warning "$($Retry)/$($MaxRetry) retries, waiting $($Wait)ms."
        Start-Sleep -Milliseconds $Wait
        $Result = Invoke-WebRequest @Arguments -UseBasicParsing
    }
    if ($Retry -ge $MaxRetry) {
        return Write-Error "Max retries hit. Status: $($Result.StatusCode) $($Result.StatusDescription)"
    }

    # Save current version
    if (!$script:CWMServerConnection.'api-current-version') {
        $script:CWMServerConnection.'api-current-version' = $Result.Headers.'api-current-version'
    }

    $Result
}