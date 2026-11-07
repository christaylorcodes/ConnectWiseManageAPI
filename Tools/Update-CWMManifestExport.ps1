<#
.SYNOPSIS
    Rebuilds FunctionsToExport in the module manifest from the files in Public/.

.DESCRIPTION
    The psm1 dot-sources every Public/*.ps1 file, and PowerShell exports only the names
    listed in the psd1. This script keeps that list in sync: one entry per Public file
    basename, sorted, no duplicates. Run it after adding, renaming or removing a public
    function. Use -Check in CI to fail when the manifest is stale.

.EXAMPLE
    ./Tools/Update-CWMManifestExport.ps1

.EXAMPLE
    ./Tools/Update-CWMManifestExport.ps1 -Check
#>
[CmdletBinding()]
param(
    [switch]$Check
)

$ModuleRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'ConnectWiseManageAPI'
$Manifest = Join-Path $ModuleRoot 'ConnectWiseManageAPI.psd1'

$Names = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter *.ps1 -Recurse |
    Select-Object -ExpandProperty BaseName |
    Sort-Object -Unique

$NewLine = "    FunctionsToExport = @('" + ($Names -join "','") + "')"

$Bytes = [System.IO.File]::ReadAllBytes($Manifest)
$HasBom = $Bytes.Length -ge 3 -and $Bytes[0] -eq 0xEF -and $Bytes[1] -eq 0xBB -and $Bytes[2] -eq 0xBF
$Content = [System.IO.File]::ReadAllText($Manifest)
$Pattern = '(?m)^\s*FunctionsToExport\s*=\s*@\([^)]*\)'
if ($Content -notmatch $Pattern) { throw "FunctionsToExport line not found in $Manifest" }
$Updated = [regex]::Replace($Content, $Pattern, $NewLine)

if ($Check) {
    if ($Updated -ne $Content) { throw 'FunctionsToExport is out of date. Run ./Tools/Update-CWMManifestExport.ps1' }
    Write-Verbose 'FunctionsToExport is up to date.'
    return
}

if ($Updated -ne $Content) {
    # Keep the manifest's existing encoding (BOM or not).
    [System.IO.File]::WriteAllText($Manifest, $Updated, (New-Object System.Text.UTF8Encoding $HasBom))
    Write-Verbose "Updated FunctionsToExport: $($Names.Count) functions."
}
