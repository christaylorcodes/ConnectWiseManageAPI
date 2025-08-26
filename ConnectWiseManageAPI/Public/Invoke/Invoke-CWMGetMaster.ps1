function Invoke-CWMGetMaster {
    [CmdletBinding()]
    param (
        $Arguments,
        [string]$Endpoint
    )

    if ($Arguments.id) { $Endpoint = Join-Url $Endpoint $id }

    if ($Arguments.count.IsPresent) { $Endpoint = Join-Url $Endpoint '/count' }

    if ($Arguments.condition) {
        $condition = [System.Web.HttpUtility]::UrlEncode($Arguments.condition)
        $URLParameters += "&conditions=$condition"
    }

    if ($Arguments.childConditions) {
        $childConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.childConditions)
        $URLParameters += "&childConditions=$childConditions"
    }

    if ($Arguments.customFieldConditions) {
        $customFieldConditions = [System.Web.HttpUtility]::UrlEncode($Arguments.customFieldConditions)
        $URLParameters += "&customFieldConditions=$customFieldConditions"
    }

    if ($Arguments.Fields) {
        $fields = [System.Web.HttpUtility]::UrlEncode($($Arguments.Fields -join ','))
        $URLParameters += "&fields=$fields"
    }

    if ($Arguments.orderBy) {
        $orderBy = [System.Web.HttpUtility]::UrlEncode($Arguments.orderBy)
        $URLParameters += "&orderBy=$orderBy"
    }

    $URI = New-CWMUrl -Endpoint $Endpoint -URLParameters $URLParameters

    $WebRequestArguments = @{
        Uri    = $URI
        Method = 'GET'
    }

    if ($Arguments.all -and !$Arguments.count.IsPresent) { $Result = Invoke-CWMAllResult -Arguments $WebRequestArguments }
    else {
        if ($Arguments.pageSize) { $WebRequestArguments.URI += "&pageSize=$pageSize" }
        if ($Arguments.page) { $WebRequestArguments.URI += "&page=$page" }

        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            try { $Result = $Result.content | ConvertFrom-Json }
            catch {
                Write-Error 'There was an issue converting the results from JSON.'
                $_
            }
        }
    }

    if ($Arguments.count.IsPresent -and $Result.PSObject.Properties.count) { $Result = $Result.count }

    $Result | Write-Output
}
