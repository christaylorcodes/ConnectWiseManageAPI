function Invoke-CWMGetMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    if ($Arguments.Condition) {
        $Condition = [System.Web.HttpUtility]::UrlEncode($Arguments.Condition)
        $URLParamaters += "&conditions=$Condition"
    }

    if($Arguments.childConditions) {
        $childConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.childConditions)
        $URLParamaters += "&childConditions=$childConditions"
    }

    if($Arguments.customFieldConditions) {
        $customFieldConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.customFieldConditions)
        $URLParamaters += "&customFieldConditions=$customFieldConditions"
    }

    if($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URLParamaters += "&fields=$fields"
    }

    if($Arguments.orderBy) {
        $orderBy = [System.Web.HttpUtility]::UrlEncode($Arguments.orderBy)
        $URLParamaters += "&orderBy=$orderBy"
    }

    $URI = New-CWMUrl -Endpoint $Endpoint -URLParamaters $URLParamaters

    $WebRequestArguments = @{
        Uri = $URI
        Method = 'GET'
    }

    if ($Arguments.all) {
        $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments
    }
    else {
        if($Arguments.pageSize){
            $WebRequestArguments.URI += "&pageSize=$pageSize"}
        if($Arguments.page){
            $WebRequestArguments.URI += "&page=$page"
        }
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){
            try{
                $Result = $Result.content | ConvertFrom-Json
            }
            catch{
                Write-Error "There was an issue converting the results from JSON."
                $_
            }
        }
    }

    return $Result
}
