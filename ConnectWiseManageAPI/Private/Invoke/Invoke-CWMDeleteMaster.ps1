function Invoke-CWMDeleteMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]$URI
    )

    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Delete'
    }
    if ($PSCmdlet.ShouldProcess($WebRequestArguments.URI, "Invoke-CWMDeleteMaster")) {
        $Result =  Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){
            $Result = $Result.content | ConvertFrom-Json
        }
    }
    if ($Result.StatusCode -eq 204) {
        Write-Verbose 'Success'
        return
    }
    return $Result
}
