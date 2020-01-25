function New-CWMDebugReport {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSShouldProcess", "")]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        $Hash = $true
    )

    if (!$CWMServerConnection) {
        $ErrorMessage = @()
        $ErrorMessage += "Not connected to a Manage server."
        $ErrorMessage += '--> $CWMServerConnection variable not found.'
        $ErrorMessage += "----> Run 'Connect-CWM' to initialize the connection before issuing other CWM cmdlets."
        Write-Error ($ErrorMessage | Out-String)
        return
    }

    $DebugOutput = @{}
    $DebugOutput.CWMServerConnection = $script:CWMServerConnection.Clone()
    $DebugOutput.CWMServerConnection.Headers = $script:CWMServerConnection.Headers.Clone()
    $DebugOutput.CWMSystemInfo = Get-CWMSystemInfo -ErrorAction SilentlyContinue
    $DebugOutput.OS = [System.Environment]::OSVersion.Version
    $DebugOutput.PowerShell = $PSVersionTable.PSVersion
    $DebugOutput.Errors = $Error[0..4]

    # Hash sensitive information so that it can be shared
    if ($Hash) {
        Function Get-StringHash([String] $String,$HashName = "MD5") {
            $StringBuilder = New-Object System.Text.StringBuilder
            [System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String)) | `
            ForEach-Object {
                [Void]$StringBuilder.Append($_.ToString("x2"))
            }
            $StringBuilder.ToString()
        }

        $DebugOutput.CWMServerConnection.Server = Get-StringHash $DebugOutput.CWMServerConnection.Server
        $DebugOutput.CWMServerConnection.Headers.Authorization = Get-StringHash $DebugOutput.CWMServerConnection.Headers.Authorization
        $DebugOutput.CWMServerConnection.Headers.ClientID = Get-StringHash $DebugOutput.CWMServerConnection.Headers.ClientID
    }
    return ($DebugOutput | ConvertTo-Json | Out-String)
}
