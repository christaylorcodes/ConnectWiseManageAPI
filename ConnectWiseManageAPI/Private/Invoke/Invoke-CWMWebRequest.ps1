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

    # Issue request
    try {
        Write-Debug "Arguments: $($Arguments | ConvertTo-Json)"
        $Result = Invoke-WebRequest @Arguments -UseBasicParsing
    }
    catch {
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