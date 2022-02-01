function Disconnect-CWM {
    [CmdletBinding()]
    param()
    try {
        $null = Remove-Variable -Name CWMServerConnection -Scope script -Force -Confirm:$false -ErrorAction Stop
        if ($CWMServerConnection -or $script:CWMServerConnection) {
            Write-Error 'There was an error clearing connection information.'
        }
        else {
            Write-Verbose '$CWMServerConnection, variable removed.'
        }
    }
    catch {
        Write-Error "There was an error clearing connection information.`n$($_)"
    }
}