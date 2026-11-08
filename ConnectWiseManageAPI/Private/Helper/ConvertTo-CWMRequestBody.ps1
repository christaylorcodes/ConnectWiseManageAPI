function ConvertTo-CWMRequestBody {
    # Shared by Invoke-CWMNewMaster and Invoke-CWMSetMaster. Returns $Arguments.Body unchanged when given
    # (a string or a byte[] multipart body); otherwise the remaining arguments as JSON, leaving out
    # PowerShell common parameters, module-only parameters and the names in $Skip.
    [CmdletBinding()]
    param(
        $Arguments,
        [string[]]$Skip
    )

    # The unary comma stops a byte[] body from being written to the pipeline one byte at a time
    if ($Arguments.Body) { return , $Arguments.Body }

    # 'Version' is no longer used (the API version comes from Connect-CWM) but is still kept out of the
    # body, so older scripts that pass it in -Arguments do not send it to the API.
    $Skip += 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable', 'ProgressAction', 'Verbose', 'WarningAction', 'WarningVariable', 'WhatIf', 'Confirm', 'Version', 'grandparentId', 'parentId'

    $Body = @{}
    foreach ($i in $Arguments.GetEnumerator()) {
        if ($Skip -notcontains $i.Key) {
            $Value = $i.value
            # Values without dates are added untouched, exactly as before
            if (Test-CWMBodyDate $Value) {
                $Value = ConvertTo-CWMBodyDate $Value
                if ($Value -is [array]) { $Value = $Value.psobject.BaseObject }
            }
            $Body.Add($i.Key, $Value)
        }
    }

    ConvertTo-Json $Body -Depth 100
}

function Test-CWMBodyDate {
    # True when $Value is, or contains (in hashtables, objects or arrays), a [datetime] or [DateTimeOffset]
    param($Value)

    if ($null -eq $Value -or $Value -is [string]) { return $false }
    if ($Value -is [datetime] -or $Value -is [DateTimeOffset]) { return $true }
    if ($Value -is [System.Collections.IDictionary]) {
        foreach ($Key in $Value.Keys) { if (Test-CWMBodyDate $Value[$Key]) { return $true } }
        return $false
    }
    if ($Value -is [System.Management.Automation.PSCustomObject]) {
        foreach ($Property in $Value.PSObject.Properties) { if (Test-CWMBodyDate $Property.Value) { return $true } }
        return $false
    }
    if ($Value -is [array]) {
        foreach ($Item in $Value) { if (Test-CWMBodyDate $Item) { return $true } }
    }
    $false
}

function ConvertTo-CWMBodyDate {
    # Returns a copy of $Value with every [datetime]/[DateTimeOffset] in it (also inside hashtables, objects
    # and arrays) replaced by an ISO 8601 UTC string. ConvertTo-Json writes dates differently per edition
    # (5.1: "\/Date(ms)\/", 7: ISO with the local offset, or no offset for unspecified-kind dates). The
    # caller's objects are never changed.
    # Dates of unspecified kind (e.g. [datetime]'2026-01-02') are sent as UTC unchanged, which is what
    # PowerShell 7 sent before (no offset, read as UTC). Converting them as local time would move a calendar
    # date to the previous day for users east of UTC. Local and UTC dates are converted to UTC.
    # Arrays returned by a function are PSObject-wrapped, which 5.1's ConvertTo-Json writes as
    # {"value":[..],"Count":n}; every converted array is therefore unwrapped before it is stored.
    param($Value)

    if ($null -eq $Value) { return $null }
    if ($Value -is [datetime]) {
        if ($Value.Kind -ne [System.DateTimeKind]::Unspecified) { $Value = $Value.ToUniversalTime() }
        return $Value.ToString("yyyy-MM-dd'T'HH:mm:ss'Z'", [cultureinfo]::InvariantCulture)
    }
    if ($Value -is [DateTimeOffset]) {
        return $Value.UtcDateTime.ToString("yyyy-MM-dd'T'HH:mm:ss'Z'", [cultureinfo]::InvariantCulture)
    }
    if ($Value -is [System.Collections.IDictionary]) {
        $Copy = [ordered]@{}
        foreach ($Key in $Value.Keys) {
            $Converted = ConvertTo-CWMBodyDate $Value[$Key]
            if ($Converted -is [array]) { $Converted = $Converted.psobject.BaseObject }
            $Copy[$Key] = $Converted
        }
        return $Copy
    }
    if ($Value -is [System.Management.Automation.PSCustomObject]) {
        $Copy = [ordered]@{}
        foreach ($Property in $Value.PSObject.Properties) {
            $Converted = ConvertTo-CWMBodyDate $Property.Value
            if ($Converted -is [array]) { $Converted = $Converted.psobject.BaseObject }
            $Copy[$Property.Name] = $Converted
        }
        return [pscustomobject]$Copy
    }
    if ($Value -is [array]) {
        $Items = New-Object System.Collections.Generic.List[object]
        foreach ($Item in $Value) {
            $Converted = ConvertTo-CWMBodyDate $Item
            if ($Converted -is [array]) { $Converted = $Converted.psobject.BaseObject }
            $Items.Add($Converted)
        }
        # The unary comma keeps the array (also with one element) from being unrolled
        return , $Items.ToArray()
    }
    $Value
}
