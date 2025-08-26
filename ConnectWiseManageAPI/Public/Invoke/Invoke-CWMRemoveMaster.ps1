function Invoke-CWMRemoveMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$Endpoint
    )

    $URI = New-CWMUrl -Endpoint $Endpoint
    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Delete'
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMRemoveMaster")) {
        $Result =  Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){ $Result = $Result.content | ConvertFrom-Json }
    }
    if ($Result.StatusCode -eq 204) { Write-Verbose 'Success' }
    $Result
}
