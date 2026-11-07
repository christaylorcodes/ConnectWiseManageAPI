function Write-CWMWebRequestError {
    # Builds the error message for a failed request. The wording is kept from earlier versions so scripts
    # matching on it keep working; the HTTP status is added as an extra line.
    # $script:ErrBody (parsed body) and $script:ErrDetails (raw ErrorDetails) are kept for scripts that read them.
    [CmdletBinding()]
    param(
        [System.Management.Automation.ErrorRecord]$WebError,
        [int]$StatusCode,
        [int]$Attempt
    )

    $ErrorMessage = @()
    $script:ErrBody = $null

    if ($WebError.Exception.Response) {
        $ErrBody = Get-CWMErrorBody -ErrorRecord $WebError
        $script:ErrBody = $ErrBody
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
            # Field-level validation errors, e.g. { code: 'InvalidObject', errors: [ { message: 'summary is required' } ] }
            foreach ($FieldError in @($ErrBody.errors)) {
                if ($FieldError.message) { $ErrorMessage += "-----> $($FieldError.message)" }
            }
        }
        elseif ($WebError.Exception.Message) {
            $ErrorMessage += 'An exception has been thrown.'
            $ErrorMessage += "--> $($WebError.Exception.Message)"
            # Non-JSON body (e.g. an HTML error page from a proxy)
            if ($ErrBody -is [string]) { $ErrorMessage += "--> $ErrBody" }
        }
        if ($StatusCode) { $ErrorMessage += "--> HTTP status: $StatusCode" }
        if ($Attempt) { $ErrorMessage += "--> Failed after $Attempt retries." }
    }

    if ($WebError.ErrorDetails) { $script:ErrDetails = $WebError.ErrorDetails }

    if ($ErrorMessage.Length -lt 1) { $ErrorMessage = $WebError }
    else { $ErrorMessage += $WebError.ScriptStackTrace }

    Write-Error ($ErrorMessage | Out-String)
}
