function Invoke-CWMGetMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$URI
    )

    if ($Arguments.Condition) {
        $Condition = [System.Web.HttpUtility]::UrlEncode($Arguments.Condition)
        $URI += "&conditions=$Condition"
    }

    if($Arguments.childConditions) {
        $childConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.childConditions)
        $URI += "&childConditions=$childConditions"
    }

    if($Arguments.customFieldConditions) {
        $customFieldConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.customFieldConditions)
        $URI += "&customFieldConditions=$customFieldConditions"
    }

    if($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URI += "&fields=$fields"
    }

    if($Arguments.orderBy) {
        $orderBy = [System.Web.HttpUtility]::UrlEncode($Arguments.orderBy)
        $URI += "&orderBy=$orderBy"
    }

    $WebRequestArguments = @{
        Uri = $URI
        Method = 'GET'
    }

    # Unauthenticated requests
    # $Unauthenticated = $false
    # if ($Arguments.Unauthenticated) { $Unauthenticated = $true }
    # $WebRequestArguments.Unauthenticated = $Unauthenticated

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