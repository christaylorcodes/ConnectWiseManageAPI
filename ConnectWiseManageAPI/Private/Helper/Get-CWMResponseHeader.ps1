function Get-CWMResponseHeader {
    <#
    .SYNOPSIS
        Reads one response header as a single string, identically on Windows PowerShell 5.1 and PowerShell 7.

    .DESCRIPTION
        Invoke-WebRequest returns header values as [string] on Windows PowerShell 5.1 (multiple values already
        joined with ', ') and as [string[]] on PowerShell 7. This helper joins with ', ' on both, so string methods
        such as .Split() work the same everywhere. Returns $null when the header is absent.

    .PARAMETER Response
        The object returned by Invoke-WebRequest / Invoke-CWMWebRequest.

    .PARAMETER Name
        The header name (case-insensitive).
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param(
        $Response,
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    if (!$Response -or !$Response.Headers) { return $null }
    if (!$Response.Headers.ContainsKey($Name)) { return $null }

    $Value = $Response.Headers[$Name]
    if ($null -eq $Value) { return $null }
    [string]::Join(', ', [string[]]@($Value))
}
