function Get-CWMSystemInfo {
    [CmdletBinding()]
    param()

    $Endpoint = '/system/info'

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}