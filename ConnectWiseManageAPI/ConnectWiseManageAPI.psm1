#Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue -Recurse )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Recurse )

#Dot source the files
foreach ($import in @($Public + $Private)) {
    Try {
        . $import.fullName
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullName): $_"
    }
}

# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
# Set variables visible to the module and its functions only
Add-Type -AssemblyName System.Web

# Invoke-WebRequest gained -AllowInsecureRedirect in PowerShell 7.4. Checked once here so tests can override it.
# Used by Connect-CWM -AllowInsecureRedirect / Invoke-CWMWebRequest.
$script:CWMSupportsInsecureRedirect = (Get-Command Invoke-WebRequest).Parameters.ContainsKey('AllowInsecureRedirect')

# Sent on every request so ConnectWise can identify the module's traffic
$CWMModuleVersion = $ExecutionContext.SessionState.Module.Version
if (!$CWMModuleVersion -or "$CWMModuleVersion" -eq '0.0') { $CWMModuleVersion = 'dev' }
$script:CWMUserAgent = "ConnectWiseManageAPI/$CWMModuleVersion PowerShell/$($PSVersionTable.PSVersion)"
Remove-Variable CWMModuleVersion

# ConvertFrom-Json gained -NoEnumerate in PowerShell 6.0. Used by ConvertFrom-CWMJson to make array output identical on 5.1 and 7.
$script:CWMJsonSupportsNoEnumerate = (Get-Command ConvertFrom-Json).Parameters.ContainsKey('NoEnumerate')

# Windows PowerShell (.NET Framework) only: make sure TLS 1.2 is allowed, which ConnectWise requires.
# Leave SystemDefault (0, .NET 4.7+) alone: it lets the OS negotiate TLS 1.2/1.3, and OR-ing Tls12 into it
# would pin the whole process to TLS 1.2. This setting is process-wide, so it is only ever widened, never replaced.
if ($PSVersionTable.PSEdition -ne 'Core') {
    try {
        $CWMTls12 = [Net.SecurityProtocolType]::Tls12
        $CWMProtocol = [Net.ServicePointManager]::SecurityProtocol
        if ([int]$CWMProtocol -ne 0 -and -not ($CWMProtocol -band $CWMTls12)) {
            [Net.ServicePointManager]::SecurityProtocol = $CWMProtocol -bor $CWMTls12
        }
    }
    catch { Write-Verbose "Unable to check the TLS settings: $_" }
    Remove-Variable CWMTls12, CWMProtocol -ErrorAction SilentlyContinue
}

Export-ModuleMember -Function $Public.Basename -Alias *