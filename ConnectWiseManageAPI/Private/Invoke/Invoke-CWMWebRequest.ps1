function Invoke-CWMWebRequest {
    [CmdletBinding()]
    param(
        $Arguments,
        [int]$MaxRetry = 5
    )

    # Check that we have cached connection info
    if(!$script:CWMServerConnection){
        $ErrorMessage = @()
        $ErrorMessage += "Not connected to a Manage server."
        $ErrorMessage +=  $_.ScriptStackTrace
        $ErrorMessage += ''
        $ErrorMessage += '--> $CWMServerConnection variable not found.'
        $ErrorMessage += "----> Run 'Connect-CWM' to initialize the connection before issuing other CWM cmdlets."
        Write-Error ($ErrorMessage | Out-String)
        return
    }

    # Add default set of arguments
    foreach($Key in $script:CWMServerConnection.Headers.Keys){
        if($Arguments.Headers.Keys -notcontains $Key){
            $Arguments.Headers += @{$Key = $script:CWMServerConnection.Headers.$Key}
        }
    }
    if(!$Arguments.SessionVariable){ $Arguments.WebSession = $script:CWMServerConnection.Session }

    # Check URI format
    if($Arguments.URI -notlike '*`?*' -and $Arguments.URI -like '*`&*') {
        $Arguments.URI = $Arguments.URI -replace '(.*?)&(.*)', '$1?$2'
    }

    # Issue request
    try {
        $Result = Invoke-WebRequest @Arguments -UseBasicParsing
    }
    catch {
        if($_.Exception.Response){
            # Read exception response
            $ErrorStream = $_.Exception.Response.GetResponseStream()
            $Reader = New-Object System.IO.StreamReader($ErrorStream)
            $script:ErrBody = $Reader.ReadToEnd() | ConvertFrom-Json

            # Start error message
            $ErrorMessage = @()

            if($errBody.code){
                $ErrorMessage += "An exception has been thrown."
                $ErrorMessage +=  $_.ScriptStackTrace
                $ErrorMessage += ''
                $ErrorMessage += "--> $($ErrBody.code)"
                if($errBody.code -eq 'Unauthorized'){
                    $ErrorMessage += "-----> $($ErrBody.message)"
                    $ErrorMessage += "-----> Use 'Disconnect-CWM' or 'Connect-CWM -Force' to set new authentication."
                }
                else {
                    $ErrorMessage += "-----> $($ErrBody.message)"
                    $ErrorMessage += "-----> ^ Error has not been documented please report. ^"
                }
            } elseif ($_.Exception.message) {
                $ErrorMessage += "An exception has been thrown."
                $ErrorMessage +=  $_.ScriptStackTrace
                $ErrorMessage += ''
                $ErrorMessage += "--> $($_.Exception.message)"
            }
        }

        if ($_.ErrorDetails) {
            $ErrorMessage += "An error has been thrown."
            $ErrorMessage +=  $_.ScriptStackTrace
            $ErrorMessage += ''
            $script:errDetails = $_.ErrorDetails | ConvertFrom-Json
            $ErrorMessage += "--> $($errDetails.code)"
            $ErrorMessage += "--> $($errDetails.message)"
            if($errDetails.errors.message){
                $ErrorMessage += "-----> $($errDetails.errors.message)"
            }
        }
        Write-Error ($ErrorMessage | out-string)
        return
    }

    # Not sure this will be hit with current iwr error handling
    # May need to move to catch block need to find test
    # TODO Find test for retry
    # Retry the request
    $Retry = 0
    while ($Retry -lt $MaxRetry -and $Result.StatusCode -eq 500) {
        $Retry++
        # ConnectWise Manage recommended wait time
        $Wait = $([math]::pow( 2, $Retry))
        Write-Warning "Issue with request, status: $($Result.StatusCode) $($Result.StatusDescription)"
        Write-Warning "$($Retry)/$($MaxRetry) retries, waiting $($Wait)ms."
        Start-Sleep -Milliseconds $Wait
        $Result = Invoke-WebRequest @Arguments -UseBasicParsing
    }
    if ($Retry -ge $MaxRetry) {
        Write-Error "Max retries hit. Status: $($Result.StatusCode) $($Result.StatusDescription)"
        return
    }

    # Save current version
    if (!$script:CWMServerConnection.'api-current-version') {
        $script:CWMServerConnection.'api-current-version' = $Result.Headers.'api-current-version'
    }

    return $Result
}