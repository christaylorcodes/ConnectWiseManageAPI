function Invoke-CWMUpdateMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$Endpoint
    )

    Write-Verbose $($Arguments.Value | Out-String)
    $Body = @(
        @{
            op    = $Arguments.Operation
            path  = $Arguments.Path
            value = $Arguments.Value
        }
    )
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Patch'
        ContentType = 'application/json'
        Body        = $Body
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMUpdateMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result
}
