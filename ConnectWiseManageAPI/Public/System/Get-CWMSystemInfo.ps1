function Get-CWMSystemInfo {
    [CmdletBinding()]
    param()

    $Endpoint = '/system/info'

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}