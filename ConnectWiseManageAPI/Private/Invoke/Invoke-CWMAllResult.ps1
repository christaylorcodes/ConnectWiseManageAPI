function Invoke-CWMAllResult {
    [CmdletBinding()]
    param(
        $Arguments
    )

    # Update header for new pagination-type
    $Arguments.Headers += @{
        'pagination-type' = 'forward-only'
    }

    # Up the pagesize to max
    $Arguments.URI += "&pageSize=999"

    # First request
    $PageResult = Invoke-CWMWebRequest -Arguments $Arguments
    if(!$PageResult){return}
    if(!$PageResult.Headers.ContainsKey('Link')){
        Write-Error "The $((Get-PSCallStack)[2].Command) Endpoint doesn't support 'forward-only' pagination. Please report to ConnectWise."
        return
    }

    $Collection = @()
    $Collection += $PageResult.Content | ConvertFrom-Json
    $Link = $PageResult.Headers.Link;
    if ($Link) {
        $NextPage = $PageResult.Headers.Link.Split(';')[0].trimstart('<').trimend('>')
    }
    else {
        $NextPage = $null
    }

    # Loop through all results
    while ($NextPage) {
        $Arguments.Uri = $NextPage
        $PageResult = Invoke-CWMWebRequest -Arguments $Arguments
        if (!$PageResult){return}
        $Collection += $PageResult.Content | ConvertFrom-Json
        $Link = $PageResult.Headers.Link;
        if ($Link) {
            $NextPage = $PageResult.Headers.Link.Split(';')[0].trimstart('<').trimend('>')
        }
        else {
            $NextPage = $null
        }
    }
    return $Collection
}
