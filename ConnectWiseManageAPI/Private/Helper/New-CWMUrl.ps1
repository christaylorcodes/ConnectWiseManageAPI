function New-CWMUrl {
    param(
        [string]$Endpoint,
        [string]$URLParamaters
    )
    $URL = "https://$($script:CWMServerConnection.Server)"
    $URL = Join-Url $URL $script:CWMServerConnection.Codebase
    $URL = Join-Url $URL $script:CWMServerConnection.BasePath
    $URL = Join-Url $URL $Endpoint
    $URL += $URLParamaters
    return $URL
}