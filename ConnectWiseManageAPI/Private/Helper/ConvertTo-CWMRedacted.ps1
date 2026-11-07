function ConvertTo-CWMRedacted {
    # Returns a copy of $InputObject that is safe to print in verbose, debug and -WhatIf output.
    # - Values whose key (or property name) matches password|token|privateKey|secret|memberHash (any case)
    #   become '[redacted]', in nested hashtables, PSCustomObjects and arrays too.
    # - A JSON Patch operation whose 'path' matches has its 'value' redacted.
    # - A JSON string is parsed, redacted and serialized again; it is returned unchanged when nothing matches.
    # - A byte[] (e.g. a multipart upload) becomes '[N bytes]'.
    # Everything else is returned as is. The input is never modified.
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [AllowNull()]
        $InputObject,
        [int]$Depth = 0
    )

    $Pattern = 'password|token|privateKey|secret|memberHash'
    $Mask = '[redacted]'

    if ($null -eq $InputObject) { return $null }
    if ($InputObject -is [byte[]]) { return "[$($InputObject.Length) bytes]" }
    if ($Depth -gt 50) { return $InputObject }

    if ($InputObject -is [string]) {
        # Nothing that could be a sensitive key: keep the text exactly as it is
        if ($InputObject -notmatch $Pattern) { return $InputObject }
        $Trimmed = $InputObject.Trim()
        if ($Trimmed.StartsWith('{') -or $Trimmed.StartsWith('[')) {
            try { $Parsed = ConvertFrom-Json -InputObject $InputObject -ErrorAction Stop }
            catch { return $Mask }
            return ConvertTo-Json -InputObject (ConvertTo-CWMRedacted $Parsed -Depth ($Depth + 1)) -Depth 100
        }
        # Form-encoded text, e.g. UserName=u&Password=p
        return $InputObject -replace "(?i)([^=&\s]*(?:$Pattern)[^=&\s]*=)[^&\s]*", "`$1$Mask"
    }

    $IsDictionary = $InputObject -is [System.Collections.IDictionary]
    if ($IsDictionary -or $InputObject -is [System.Management.Automation.PSCustomObject]) {
        $Copy = [ordered]@{}
        if ($IsDictionary) { foreach ($Key in $InputObject.Keys) { $Copy[[string]$Key] = $InputObject[$Key] } }
        else { foreach ($Property in $InputObject.psobject.Properties) { $Copy[$Property.Name] = $Property.Value } }

        foreach ($Key in @($Copy.Keys)) {
            if ($Key -match $Pattern) { $Copy[$Key] = $Mask }
            else { $Copy[$Key] = ConvertTo-CWMRedacted $Copy[$Key] -Depth ($Depth + 1) }
        }
        # JSON Patch: @{ op = 'replace'; path = 'password'; value = '...' }
        if ($Copy.Contains('op') -and $Copy.Contains('value') -and "$($Copy['path'])" -match $Pattern) { $Copy['value'] = $Mask }

        if ($IsDictionary) { return $Copy }
        return [pscustomobject]$Copy
    }

    if ($InputObject -is [System.Collections.IEnumerable]) {
        $Items = New-Object System.Collections.Generic.List[object]
        foreach ($Item in $InputObject) { $Items.Add((ConvertTo-CWMRedacted $Item -Depth ($Depth + 1))) }
        # The unary comma keeps an array (also with one or no element) from being unrolled
        return , $Items.ToArray()
    }

    $InputObject
}
