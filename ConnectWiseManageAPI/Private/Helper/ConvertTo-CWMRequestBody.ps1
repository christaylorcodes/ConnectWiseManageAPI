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
    $Skip += 'Debug', 'ErrorAction', 'ErrorVariable', 'InformationAction', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable', 'Verbose', 'WarningAction', 'WarningVariable', 'WhatIf', 'Confirm', 'Version', 'grandparentId', 'parentId'

    $Body = @{}
    foreach ($i in $Arguments.GetEnumerator()) {
        if ($Skip -notcontains $i.Key) {
            $Body.Add($i.Key, $i.value)
        }
    }

    ConvertTo-Json $Body -Depth 100
}
