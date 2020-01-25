function Invoke-CWMSearchMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$URI
    )

    $Body = @{}
    switch ($Arguments.Keys) {
        'condition'                { $Body.conditions               = $Arguments.condition                }
        'orderBy'                  { $Body.orderBy                  = $Arguments.orderBy                  }
        'childconditions'          { $Body.childconditions          = $Arguments.childconditions          }
        'customfieldconditions'    { $Body.customfieldconditions    = $Arguments.customfieldconditions    }
    }
    $Body = ConvertTo-Json $Body -Depth 100
    Write-Verbose $Body

    $WebRequestArguments = @{
        Uri = $URI
        Method = 'Post'
        ContentType = 'application/json'
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