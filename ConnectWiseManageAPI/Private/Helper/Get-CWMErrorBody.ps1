function Get-CWMErrorBody {
    <#
    .SYNOPSIS
        Returns the response body of a failed Invoke-WebRequest, identically on Windows PowerShell 5.1 and PowerShell 7.

    .DESCRIPTION
        Both editions put the error response body in $_.ErrorDetails.Message, so that is read first.
        As a fallback (Windows PowerShell 5.1 only), the body is read from the WebException's response stream,
        rewound first because Invoke-WebRequest has usually consumed it already. PowerShell 7's
        HttpResponseMessage has no GetResponseStream method, so the fallback is skipped there.

        The body is returned as an object when it is JSON (ConnectWise errors look like
        { code, message, errors: [ { code, message, resource, field } ] }), otherwise as the raw string.
        Returns $null when there is no body.

    .PARAMETER ErrorRecord
        The ErrorRecord caught from Invoke-WebRequest. Capture $_ into a variable before calling this,
        because nested try/catch blocks change $_.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.ErrorRecord]$ErrorRecord
    )

    $Text = $null
    if ($ErrorRecord.ErrorDetails -and $ErrorRecord.ErrorDetails.Message) {
        $Text = $ErrorRecord.ErrorDetails.Message
    }
    else {
        $Response = $null
        try { $Response = $ErrorRecord.Exception.Response } catch { $Response = $null }
        if ($Response -and $Response.PSObject.Methods['GetResponseStream']) {
            try {
                $Stream = $Response.GetResponseStream()
                if ($Stream.CanSeek) { $Stream.Position = 0 }
                $Reader = New-Object System.IO.StreamReader($Stream)
                $Text = $Reader.ReadToEnd()
            }
            catch { $Text = $null }
        }
    }

    if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
    try { ConvertFrom-Json -InputObject $Text -ErrorAction Stop }
    catch { $Text }
}
