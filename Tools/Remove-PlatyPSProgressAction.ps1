<#
.SYNOPSIS
    Removes the -ProgressAction common parameter that PlatyPS writes into markdown help on PowerShell 7.4+.

.DESCRIPTION
    PowerShell 7.4 added -ProgressAction as a common parameter. PlatyPS 0.14 does not know it is a common
    parameter, so running Update-MarkdownHelp / New-MarkdownHelp on PowerShell 7.4+ adds it to the SYNTAX
    block and as a "### -ProgressAction" parameter section in every file. That is noise, and wrong for
    Windows PowerShell 5.1 users. Run this after regenerating the docs, before New-ExternalHelp.

    Docs are regenerated on PowerShell 7 (the primary edition); this keeps the output edition-neutral.

.PARAMETER Path
    Folder with the markdown help files. Default: the repository's Docs folder.

.EXAMPLE
    Import-Module ./ConnectWiseManageAPI/ConnectWiseManageAPI.psd1 -Force
    Update-MarkdownHelp -Path ./Docs -UpdateInputOutput -UseFullTypeName -Force
    ./Tools/Remove-PlatyPSProgressAction.ps1
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Path = (Join-Path (Split-Path $PSScriptRoot -Parent) 'Docs')
)

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$Changed = 0

foreach ($File in Get-ChildItem -Path $Path -Filter '*.md' -File) {
    $Text = [IO.File]::ReadAllText($File.FullName)
    # SYNTAX block: " [-ProgressAction <ActionPreference>]"; PARAMETERS section: "### -ProgressAction"
    # up to the next "### " heading or "## " section
    $New = $Text -creplace ' \[-ProgressAction <ActionPreference>\]', '' -creplace '(?ms)^### -ProgressAction\r?\n.*?(?=^#{2,3} )', ''

    if ($New -ne $Text -and $PSCmdlet.ShouldProcess($File.Name, 'Remove -ProgressAction')) {
        [IO.File]::WriteAllText($File.FullName, $New, $Utf8NoBom)
        $Changed++
    }
}

Write-Verbose "Removed -ProgressAction from $Changed file(s)."
