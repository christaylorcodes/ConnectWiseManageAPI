#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0' }
# Enforces the conventions in CLAUDE.md for every public function, so they hold by test rather than by
# review: approved verbs, complete comment-based help, ShouldProcess on writes, Get parameters the masters
# understand, and a manifest alias list that matches the [Alias()] attributes.
# Everything here reads source files with the PowerShell parser; nothing is sent anywhere.

BeforeDiscovery {
    $ModuleRoot = Join-Path (Split-Path $PSScriptRoot -Parent) 'ConnectWiseManageAPI'
    $Functions = foreach ($File in Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter *.ps1 -Recurse) {
        $Tokens = $null
        $Ast = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$Tokens, [ref]$null)
        $Function = $Ast.Find({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false)
        if (!$Function) { continue }
        @{
            Name     = $Function.Name
            Function = $Function
            Tokens   = $Tokens
            Verb     = ($Function.Name -split '-')[0]
            IsGet    = $Function.Name -like 'Get-*'
            # Write masters do the ShouldProcess call, so their callers must declare SupportsShouldProcess
            IsWrite  = [bool]$Function.Find({
                    $args[0] -is [System.Management.Automation.Language.CommandAst] -and
                    $args[0].GetCommandName() -match '^Invoke-CWM(New|Update|Set|Remove|Action)Master$'
                }, $true)
        }
    }
}

Describe 'Public function conventions' {
    BeforeAll {
        $ApprovedVerbs = (Get-Verb).Verb
        $CommonParameters = @([System.Management.Automation.Cmdlet]::CommonParameters) +
        @([System.Management.Automation.Cmdlet]::OptionalCommonParameters) + 'ProgressAction'
        # Names Invoke-CWMGetMaster reads (CLAUDE.md "Conventions"), plus the route ids
        $GetVocabulary = 'id', 'count', 'condition', 'orderBy', 'childConditions', 'customFieldConditions',
        'page', 'pageSize', 'pageId', 'fields', 'all', 'parentId', 'grandparentId'

        function Get-ParameterName($Function) {
            @($Function.Body.ParamBlock.Parameters | ForEach-Object { $_.Name.VariablePath.UserPath })
        }
    }

    Context '<Name>' -ForEach $Functions {
        It 'uses an approved verb' {
            $Verb | Should -BeIn $ApprovedVerbs
        }

        It 'has comment-based help with a synopsis, a description, an example and every parameter' {
            $Help = $Function.GetHelpContent()
            $Help | Should -Not -BeNullOrEmpty -Because 'see Templates/FunctionDocumentation.template.ps1'
            $Help.Synopsis | Should -Not -BeNullOrEmpty
            $Help.Description | Should -Not -BeNullOrEmpty
            @($Help.Examples).Count | Should -BeGreaterThan 0
            $Documented = @($Help.Parameters.Keys)
            $Missing = Get-ParameterName $Function | Where-Object { $_ -notin $Documented -and $_ -notin $CommonParameters }
            $Missing | Should -BeNullOrEmpty -Because 'every parameter needs a .PARAMETER entry'
        }

        It 'declares SupportsShouldProcess when it calls a write master' -Skip:(!$IsWrite) {
            $Binding = $Function.Body.ParamBlock.Attributes | Where-Object { $_.TypeName.Name -eq 'CmdletBinding' }
            $Binding.NamedArguments.ArgumentName | Should -Contain 'SupportsShouldProcess'
        }

        It 'has no Get parameter the masters would silently ignore' -Skip:(!$IsGet) {
            # A parameter outside the master vocabulary must be used by the function itself (for example in
            # the endpoint path or a query string it builds); otherwise it does nothing.
            $ParamExtent = $Function.Body.ParamBlock.Extent
            $BodyExtent = $Function.Body.Extent
            $Code = ($Tokens | Where-Object {
                    $_.Kind -ne 'Comment' -and
                    $_.Extent.StartOffset -ge $BodyExtent.StartOffset -and $_.Extent.EndOffset -le $BodyExtent.EndOffset -and
                    ($_.Extent.EndOffset -le $ParamExtent.StartOffset -or $_.Extent.StartOffset -ge $ParamExtent.EndOffset)
                } | ForEach-Object { $_.Text }) -join ' '
            $Unused = Get-ParameterName $Function | Where-Object {
                $_ -notin $GetVocabulary -and $_ -notin $CommonParameters -and
                $Code -notmatch "(?i)(?<![\w-])\`$?$([regex]::Escape($_))(?!\w)"
            }
            $Unused | Should -BeNullOrEmpty
        }
    }
}

Describe 'Manifest aliases' {
    It 'AliasesToExport matches the [Alias()] attributes on public functions (run Tools/Update-CWMManifestExport.ps1)' {
        $RepoRoot = Split-Path $PSScriptRoot -Parent
        $Declared = foreach ($File in Get-ChildItem -Path (Join-Path $RepoRoot 'ConnectWiseManageAPI/Public') -Filter *.ps1 -Recurse) {
            $Ast = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$null, [ref]$null)
            $Ast.FindAll({ $args[0] -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $false) |
                ForEach-Object { $_.Body.ParamBlock.Attributes } |
                Where-Object { $_.TypeName.Name -eq 'Alias' } |
                ForEach-Object { $_.PositionalArguments.Value }
        }
        $Exported = (Import-PowerShellDataFile -Path (Join-Path $RepoRoot 'ConnectWiseManageAPI/ConnectWiseManageAPI.psd1')).AliasesToExport
        Compare-Object @($Declared | Sort-Object -Unique) @($Exported | Sort-Object -Unique) | Should -BeNullOrEmpty
    }
}
