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
    $Arguments.URI += '&pageSize=999'

    do {
        $PageResult = Invoke-CWMWebRequest -Arguments $Arguments
        if (!$PageResult) { return }
        if (!$PageResult.Headers.ContainsKey('Link')) {
            return Write-Error "The $((Get-PSCallStack)[2].Command) Endpoint doesn't support 'forward-only' pagination. Please report to ConnectWise."
        }

        if ($PageResult.Headers.Link) { $NextPage = $PageResult.Headers.Link.Split(';')[0].trimstart('<').trimend('>') }
        else { $NextPage = $null }
        $Arguments.Uri = $NextPage

        $PageResult.Content | ConvertFrom-Json
    }
    while ($NextPage)
}
