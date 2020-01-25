function Disconnect-CWM {
    [CmdletBinding()]
    param()
    $null = Remove-Variable -Name CWMServerConnection -Scope script -Force -Confirm:$false -ErrorAction SilentlyContinue
    if($CWMServerConnection -or $script:CWMServerConnection) {
        Write-Error "There was an error clearing connection information.`n$($Error[0])"
    } else {
        Write-Verbose '$CWMServerConnection, variable removed.'
    }
}