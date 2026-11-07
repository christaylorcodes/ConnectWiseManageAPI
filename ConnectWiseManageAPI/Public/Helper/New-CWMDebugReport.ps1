<#
.SYNOPSIS
    Creates a debug report to share when reporting a problem.

.DESCRIPTION
    Returns a JSON report with the non-secret connection settings, the module, PowerShell and OS versions,
    and the result of Get-CWMSystemInfo. The connection headers and credentials are never included. Requires
    Connect-CWM first.

.PARAMETER Hash
    Replace the server name with its MD5 hash so the report can be shared. Defaults to $true; use -Hash
    $false to show the server name.

.EXAMPLE
    New-CWMDebugReport | Set-Clipboard

    Creates the report, with the server name hashed, and copies it to the clipboard.

.LINK
    https://developer.connectwise.com/manage/rest
#>
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

    # Only non-secret connection fields. The headers (Authorization, ClientID) and the cookie session are never
    # included, not even with -Hash:$false.
    $Connection = $script:CWMServerConnection
    $DebugOutput = @{
        CWMServerConnection = @{
            Server                   = [string]$Connection.Server
            ConnectionMethod         = $Connection.ConnectionMethod
            Codebase                 = $Connection.Codebase
            BasePath                 = $Connection.BasePath
            Version                  = $Connection.Version
            'api-current-version'    = $Connection.'api-current-version'
            Expiration               = $Connection.Expiration
            AllowInsecureRedirect    = $Connection.AllowInsecureRedirect
            SupportsInsecureRedirect = $script:CWMSupportsInsecureRedirect
        }
        ModuleVersion       = (Get-Module 'ConnectWiseManageAPI').Version
        CWMSystemInfo       = $SysInfo
        OS                  = [System.Environment]::OSVersion.Version
        PowerShell          = $PSVersionTable.PSVersion
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
    }

    $DebugOutput | ConvertTo-Json -Depth 99 | Out-String
}
