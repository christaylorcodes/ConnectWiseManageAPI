function Submit-CWMTimeSheet {
    [CmdletBinding()]
    param(
        [int]$ID
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/time/sheets/$($ID)/submit"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
