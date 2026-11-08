<#
.SYNOPSIS
    Rebuilds FunctionsToExport and AliasesToExport in the module manifest from the files in Public/.

.DESCRIPTION
    The psm1 dot-sources every Public/*.ps1 file, and PowerShell exports only the names
    listed in the psd1. This script keeps both lists in sync:
      FunctionsToExport  one entry per Public file basename, sorted, no duplicates.
      AliasesToExport    every name in a function-level [Alias()] attribute in a Public file.
    A list is only rewritten when its contents differ (order alone is not a change).
    Run it after adding, renaming or removing a public function or alias. Tests/Manifest.Tests.ps1
    and Tests/Conventions.Tests.ps1 fail in CI when the manifest is stale.

.EXAMPLE
    ./Tools/Update-CWMManifestExport.ps1 -Verbose
#>
[CmdletBinding()]
param()

$ModuleRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'ConnectWiseManageAPI'
$Manifest = Join-Path $ModuleRoot 'ConnectWiseManageAPI.psd1'
$Files = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter *.ps1 -Recurse

$Functions = $Files | Select-Object -ExpandProperty BaseName | Sort-Object -Unique

# Function-level aliases sit on the param block: function X { [CmdletBinding()][Alias('Y')] param() }
$Aliases = foreach ($File in $Files) {
    $Ast = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$null, [ref]$null)
    $Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false) |
        ForEach-Object { $_.Body.ParamBlock.Attributes } |
        Where-Object { $_.TypeName.Name -eq 'Alias' } |
        ForEach-Object { $_.PositionalArguments.Value }
}
$Aliases = @($Aliases | Sort-Object -Unique)

$Bytes = [System.IO.File]::ReadAllBytes($Manifest)
$HasBom = $Bytes.Length -ge 3 -and $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and $Bytes[2] -eq 0xBF
$Content = [System.IO.File]::ReadAllText($Manifest)
$Data = Import-PowerShellDataFile -Path $Manifest
$Updated = $Content

foreach ($Item in @(
        @{ Key = 'FunctionsToExport'; Names = $Functions }
        @{ Key = 'AliasesToExport'; Names = $Aliases }
    )) {
    if (-not (Compare-Object @($Data[$Item.Key]) @($Item.Names))) {
        Write-Verbose "$($Item.Key) is up to date."
        continue
    }
    $Pattern = "(?m)^\s*$($Item.Key)\s*=\s*@\([^)]*\)"
    if ($Updated -notmatch $Pattern) { throw "$($Item.Key) line not found in $Manifest" }
    $NewLine = "    $($Item.Key) = @(" + (($Item.Names | ForEach-Object { "'$_'" }) -join ',') + ')'
    $Updated = [regex]::Replace($Updated, $Pattern, $NewLine)
    Write-Verbose "Updated $($Item.Key): $(@($Item.Names).Count) names."
}

if ($Updated -ne $Content) {
    # Keep the manifest's existing encoding (BOM or not).
    [System.IO.File]::WriteAllText($Manifest, $Updated, (New-Object System.Text.UTF8Encoding $HasBom))
}
