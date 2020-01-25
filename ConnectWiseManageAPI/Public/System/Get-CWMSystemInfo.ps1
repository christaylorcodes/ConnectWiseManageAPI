function Get-CWMSystemInfo {
    [CmdletBinding()]
    param()

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/info"
    #$PsBoundParameters.Unauthenticated = $true

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}