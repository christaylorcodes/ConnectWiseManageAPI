<#
.SYNOPSIS
    Builds the full URL of an API request.

.DESCRIPTION
    Joins https://, the server, the codebase and the base path of the current connection
    ($script:CWMServerConnection) with the endpoint, then appends the query string. Returns nothing when
    there is no connection. Internal helper; no API call is made.

.PARAMETER Endpoint
    The API endpoint path, for example '/service/tickets'.

.PARAMETER URLParameters
    The query string to append as is, for example '&conditions=id%3D1'.

.EXAMPLE
    New-CWMUrl -Endpoint '/service/tickets' -URLParameters '&pageSize=10'

    Returns the full URL of the tickets endpoint for the current connection, with &pageSize=10 appended.
#>function New-CWMUrl {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'No creation impact.')]
    param(
        [string]$Endpoint,
        [string]$URLParameters
    )

    if(!$script:CWMServerConnection){ return }

    $URL = "https://$($script:CWMServerConnection.Server)"
    $URL = Join-Url $URL $script:CWMServerConnection.Codebase
    $URL = Join-Url $URL $script:CWMServerConnection.BasePath
    $URL = Join-Url $URL $Endpoint
    $URL += $URLParameters
    $URL
}