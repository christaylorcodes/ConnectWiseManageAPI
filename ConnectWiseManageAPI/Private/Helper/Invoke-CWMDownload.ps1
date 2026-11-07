function Invoke-CWMDownload {
    # GETs an endpoint that returns a file (for example /system/documents/{id}/download) and returns its bytes,
    # or writes them to -OutFile and returns the file. Invoke-CWMGetMaster cannot be used: it parses every
    # response as JSON. Accept is overridden because the connection's Accept header asks for JSON.
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Endpoint,
        [string]$OutFile
    )

    $WebRequestArguments = @{
        Uri     = New-CWMUrl -Endpoint $Endpoint
        Method  = 'GET'
        Headers = @{ Accept = '*/*' }
    }
    $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
    if (!$Result) { return }

    # RawContentStream holds the exact bytes on 5.1 and 7; Content may be a byte[] or a decoded string
    if ($Result.RawContentStream) { [byte[]]$Bytes = $Result.RawContentStream.ToArray() }
    elseif ($Result.Content -is [byte[]]) { [byte[]]$Bytes = $Result.Content }
    elseif ($null -ne $Result.Content) { [byte[]]$Bytes = [System.Text.Encoding]::UTF8.GetBytes([string]$Result.Content) }
    else { [byte[]]$Bytes = @() }

    if ($OutFile) {
        $Path = $PSCmdlet.GetUnresolvedProviderPathFromPSPath($OutFile)
        [System.IO.File]::WriteAllBytes($Path, $Bytes)
        Get-Item -LiteralPath $Path
    }
    # The unary comma returns the byte[] as one object instead of one byte at a time
    else { , $Bytes }
}
