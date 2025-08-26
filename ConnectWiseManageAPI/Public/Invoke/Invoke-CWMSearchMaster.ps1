function Invoke-CWMSearchMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    $Body = @{}
    switch ($Arguments.Keys) {
        'condition' { $Body.conditions = $Arguments.condition }
        'childConditions' { $Body.childConditions = $Arguments.childConditions }
        'customFieldConditions' { $Body.customFieldConditions = $Arguments.customFieldConditions }
        'orderBy' { $Body.orderBy = $Arguments.orderBy }
    }
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    if ($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URLParameters += "&fields=$fields"
    }

    $URI = New-CWMUrl -Endpoint $Endpoint -URLParameters $URLParameters

    $WebRequestArguments = @{
        Uri         = $URI
        Method      = 'Post'
        ContentType = 'application/json; charset=utf-8' #needed for accented chars
        Body        = $Body
        Headers     = $script:CWMServerConnection.Headers
    }

    if ($Arguments.all) {
        $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments
    }
    else {
        if ($Arguments.pageSize) { $WebRequestArguments.URI += "&pageSize=$pageSize" }
        if ($Arguments.page) { $WebRequestArguments.URI += "&page=$page" }
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
        }
    }

    $Result | Write-Output
}