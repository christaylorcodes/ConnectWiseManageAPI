function ConvertFrom-CWMJson {
    <#
    .SYNOPSIS
        Converts a ConnectWise Manage JSON response body to objects, identically on Windows PowerShell 5.1 and PowerShell 7.

    .DESCRIPTION
        ConvertFrom-Json behaves differently between editions:
        - Windows PowerShell 5.1 writes a top-level JSON array to the pipeline as ONE object (an Object[]).
        - PowerShell 7 enumerates the array and writes each element separately.

        This helper always writes each element of a top-level array separately (and a top-level object as itself),
        so callers get the same stream on both editions. Nested arrays are kept intact. Empty input writes nothing.

        Date strings are NOT normalized: PowerShell 7 still converts ISO 8601 strings to [datetime].

    .PARAMETER InputObject
        The JSON text, usually the Content of an Invoke-CWMWebRequest result.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]$InputObject
    )

    process {
        if ([string]::IsNullOrWhiteSpace($InputObject)) { return }

        # -NoEnumerate (PowerShell 6.0+) makes 7 behave like 5.1: a top-level array comes back as one Object[]
        $JsonArguments = @{ InputObject = $InputObject; ErrorAction = 'Stop' }
        if ($script:CWMJsonSupportsNoEnumerate) { $JsonArguments.NoEnumerate = $true }
        $Parsed = ConvertFrom-Json @JsonArguments

        if ($Parsed -is [array]) {
            # The unary comma keeps a nested array element as one object instead of flattening it
            foreach ($Item in $Parsed) { , $Item }
        }
        elseif ($null -ne $Parsed) { $Parsed }
    }
}
