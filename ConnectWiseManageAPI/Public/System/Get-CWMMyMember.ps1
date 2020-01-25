function Get-CWMMyMember {
    [CmdletBinding()]
    param(
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/mymembers"

    return Invoke-CWMGetMaster -Arguments $PsBoundParameters -URI $URI
}
