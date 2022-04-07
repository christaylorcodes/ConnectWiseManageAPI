function New-CWMDebugReport {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'No impact')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        $Hash = $true
    )

    if (!$script:CWMServerConnection) {
        $ErrorMessage = @()
        $ErrorMessage += 'Not connected to a Manage server.'
        $ErrorMessage += '--> $CWMServerConnection variable not found.'
        $ErrorMessage += "----> Run 'Connect-CWM' to initialize the connection before issuing other CWM cmdlets."
        Write-Error ($ErrorMessage | Out-String)
        return
    }

    try { $SysInfo = Get-CWMSystemInfo -ErrorAction Stop }
    catch { $SysInfo = 'error' }

    $DebugOutput = @{
        CWMServerConnection = @{
            Server                = $script:CWMServerConnection.Clone()
            Headers               = $script:CWMServerConnection.Headers.Clone()
            'api-current-version' = $script:CWMServerConnection.'api-current-version'
        }
        ModuleVersion       = (Get-Module 'ConnectWiseManageAPI').Version
        CWMSystemInfo       = $SysInfo
        OS                  = [System.Environment]::OSVersion.Version
        PowerShell          = $PSVersionTable.PSVersion
        Errors              = $Error[0..4]
    }

    # Hash sensitive information so that it can be shared
    if ($Hash) {
        Function Get-StringHash([String]$String, $HashName = 'MD5') {
            $StringBuilder = New-Object System.Text.StringBuilder
            [System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String)) | `
                    ForEach-Object {
                    [Void]$StringBuilder.Append($_.ToString('x2'))
                }
            $StringBuilder.ToString()
        }

        $DebugOutput.CWMServerConnection.Server = Get-StringHash $DebugOutput.CWMServerConnection.Server
        $DebugOutput.CWMServerConnection.Headers.Authorization = Get-StringHash $DebugOutput.CWMServerConnection.Headers.Authorization
        $DebugOutput.CWMServerConnection.Headers.ClientID = Get-StringHash $DebugOutput.CWMServerConnection.Headers.ClientID
    }

    $DebugOutput | ConvertTo-Json -Depth 99 | Out-String
}
