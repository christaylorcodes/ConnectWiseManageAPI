<#
.SYNOPSIS
    Gets ConnectWise Manage system information.

.DESCRIPTION
    Retrieves the system information of the connected ConnectWise Manage server, such as the version,
    whether it is a cloud server and its time zone. Calls GET /system/info.

.EXAMPLE
    (Get-CWMSystemInfo).version

    Returns the version of the connected ConnectWise Manage server.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Get-CWMSystemInfo {
    [CmdletBinding()]
    param()

    $Endpoint = '/system/info'

    Invoke-CWMGetMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}