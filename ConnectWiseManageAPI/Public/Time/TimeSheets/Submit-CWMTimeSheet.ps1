function Submit-CWMTimeSheet {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('sheetId')]
        [int]$id
    )

    $Endpoint = "/time/sheets/$($id)/submit"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
