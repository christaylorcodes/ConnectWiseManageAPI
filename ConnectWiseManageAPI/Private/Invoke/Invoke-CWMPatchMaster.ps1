function Invoke-CWMPatchMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
        [string]$URI
    )

    Write-Verbose $($Arguments.Value | Out-String)
    $Body =@(
        @{
            op = $Arguments.Operation
            path = $Arguments.Path
            value = $Arguments.Value
        }
    )
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Patch'
        ContentType = 'application/json'
        Body = $Body
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMNewMaster, with body:`r`n$Body`r`n")) {
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){
            $Result = $Result.content | ConvertFrom-Json
        }
    }
    return $Result
}
