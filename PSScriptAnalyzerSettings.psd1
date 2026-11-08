# PSScriptAnalyzer compatibility gate: module code must run on Windows PowerShell 5.1 AND PowerShell 7.
#   Invoke-ScriptAnalyzer -Path ./ConnectWiseManageAPI -Recurse -Settings ./PSScriptAnalyzerSettings.psd1
#
# Notes:
# - PSScriptAnalyzer ships no 7.1+ compatibility profiles; the 7.0 profiles are the closest available, so
#   commands/types new in 7.1+ are not caught here. Tests/Compatibility.Lint.Tests.ps1 covers the 7-only
#   parameters this module could plausibly reach for, including splatted ones (which these rules cannot see).
# - Features that only exist in PowerShell 7 must be feature-detected in ConnectWiseManageAPI.psm1
#   (see $script:CWMSupportsInsecureRedirect) and listed in the lint test's allow-list.
@{
    IncludeRules = @(
        'PSUseCompatibleSyntax'
        'PSUseCompatibleCommands'
        'PSUseCompatibleTypes'
    )

    Rules        = @{
        PSUseCompatibleSyntax   = @{
            Enable         = $true
            TargetVersions = @('5.1', '7.0')
        }
        PSUseCompatibleCommands = @{
            Enable         = $true
            TargetProfiles = @(
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework' # Windows PowerShell 5.1
                'win-4_x64_10.0.18362.0_7.0.0_x64_3.1.2_core'                         # PowerShell 7.0, Windows
                'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core'                               # PowerShell 7.0, Linux
            )
        }
        PSUseCompatibleTypes    = @{
            Enable         = $true
            # Not loaded by default on 5.1, but ConnectWiseManageAPI.psm1 loads it (Add-Type -AssemblyName System.Web)
            IgnoreTypes    = @('System.Web.HttpUtility')
            TargetProfiles = @(
                'win-48_x64_10.0.17763.0_5.1.17763.316_x64_4.0.30319.42000_framework'
                'win-4_x64_10.0.18362.0_7.0.0_x64_3.1.2_core'
                'ubuntu_x64_18.04_7.0.0_x64_3.1.2_core'
            )
        }
    }
}
