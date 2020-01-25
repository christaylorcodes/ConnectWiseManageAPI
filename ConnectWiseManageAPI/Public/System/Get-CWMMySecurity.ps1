function Get-CWMMySecurity {
    [CmdletBinding()]
    param()

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/mysecurity"

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}