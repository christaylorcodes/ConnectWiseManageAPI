#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0' }
# Guards the export surface: every Public file defines exactly the function its file name says,
# and the manifest's FunctionsToExport lists each of them exactly once.

BeforeDiscovery {
    $ModuleRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'ConnectWiseManageAPI'
    $PublicFiles = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter *.ps1 -Recurse | ForEach-Object {
        @{ Path = $_.FullName; BaseName = $_.BaseName }
    }
}

Describe 'Module manifest exports' {
    BeforeAll {
        $RepoRoot = Split-Path $PSScriptRoot -Parent
        $ManifestPath = Join-Path $RepoRoot 'ConnectWiseManageAPI/ConnectWiseManageAPI.psd1'
        $Exports = @((Import-PowerShellDataFile -Path $ManifestPath).FunctionsToExport)
    }

    It '<BaseName>.ps1 defines a function named <BaseName>' -ForEach $PublicFiles {
        $Ast = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$null, [ref]$null)
        $Functions = $Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
        @($Functions | Where-Object { $_.Parent.Parent -eq $Ast -or $_.Parent -eq $Ast.EndBlock }).Name |
            Select-Object -First 1 | Should -BeExactly $BaseName
    }

    It 'FunctionsToExport matches the Public files exactly (run Tools/Update-CWMManifestExport.ps1)' {
        $Expected = @(Get-ChildItem -Path (Join-Path $RepoRoot 'ConnectWiseManageAPI/Public') -Filter *.ps1 -Recurse |
                Select-Object -ExpandProperty BaseName | Sort-Object -Unique)
        Compare-Object -ReferenceObject $Expected -DifferenceObject $Exports | Should -BeNullOrEmpty
        ($Exports | Group-Object | Where-Object Count -gt 1).Name | Should -BeNullOrEmpty
    }
}
