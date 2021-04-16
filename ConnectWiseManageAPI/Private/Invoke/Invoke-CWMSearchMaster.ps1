function Invoke-CWMSearchMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    $Body = @{}
    switch ($Arguments.Keys) {
        'condition'                { $Body.conditions               = $Arguments.condition                }
    }
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

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
        Method = 'Post'
        ContentType = 'application/json; charset=utf-8' #needed for accented chars
        Body = $Body
        Headers = $script:CWMServerConnection.Headers
    }

    if ($Arguments.all) {
        $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments
    }
    else {
        if($Arguments.pageSize){$WebRequestArguments.URI += "&pageSize=$pageSize"}
        if($Arguments.page){$WebRequestArguments.URI += "&page=$page"}
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if($Result.content){
            $Result = $Result.content | ConvertFrom-Json
        }
    }
    return $Result
}