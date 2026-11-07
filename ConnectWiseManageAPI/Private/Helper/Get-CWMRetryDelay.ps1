function Get-CWMRetryDelay {
    # Seconds to wait before retry number $Attempt: the server's Retry-After when present, otherwise
    # exponential backoff (2, 4, 8, 16, 32 seconds). Capped at 60 seconds.
    [CmdletBinding()]
    [OutputType([int])]
    param($Response, [int]$Attempt)

    $MaxDelay = 60
    $Delay = $null
    try {
        if ($Response -and $Response.Headers) {
            $RetryAfter = $Response.Headers.RetryAfter # 7: System.Net.Http.Headers.RetryConditionHeaderValue
            if ($RetryAfter) {
                if ($RetryAfter.Delta) { $Delay = [int][math]::Ceiling($RetryAfter.Delta.TotalSeconds) }
                elseif ($RetryAfter.Date) { $Delay = [int][math]::Ceiling(($RetryAfter.Date - [DateTimeOffset]::UtcNow).TotalSeconds) }
            }
            else {
                $Value = $Response.Headers['Retry-After'] # 5.1: WebHeaderCollection string
                if ($Value) {
                    $Seconds = 0
                    $Date = [DateTimeOffset]::MinValue
                    if ([int]::TryParse($Value, [ref]$Seconds)) { $Delay = $Seconds }
                    elseif ([DateTimeOffset]::TryParse($Value, [ref]$Date)) { $Delay = [int][math]::Ceiling(($Date - [DateTimeOffset]::UtcNow).TotalSeconds) }
                }
            }
        }
    }
    catch { $Delay = $null }

    if ($null -eq $Delay -or $Delay -lt 1) { $Delay = [int][math]::Pow(2, $Attempt) }
    [math]::Min($Delay, $MaxDelay)
}
