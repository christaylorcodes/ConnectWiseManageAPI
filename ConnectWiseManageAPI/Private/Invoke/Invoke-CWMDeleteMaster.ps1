function Invoke-CWMDeleteMaster {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $Arguments,
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
    return $Result
}
