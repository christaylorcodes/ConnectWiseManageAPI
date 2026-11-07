#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Guards Windows PowerShell 5.1 compatibility: module code must not use PowerShell 6+/7-only cmdlet
# parameters unless the use is feature-detected (see ConnectWiseManageAPI.psm1) and allow-listed below.
# PSScriptAnalyzer's PSUseCompatibleCommands rule cannot see splatted parameters (@Arguments), so this
# test parses every file and checks direct parameters (-Name), hashtable keys (@{ Name = ... }) and
# member assignments ($Splat.Name = ...).

BeforeDiscovery {
    # Parameters that do not exist on Windows PowerShell 5.1
    $script:Ps7OnlyParameters = @(
        'AllowInsecureRedirect'   # Invoke-WebRequest/RestMethod 7.4
        'AsHashtable'             # ConvertFrom-Json 6.0
        'DateKind'                # ConvertFrom-Json 7.5
        'EscapeHandling'          # ConvertTo-Json 6.2
        'MaximumRetryCount'       # Invoke-WebRequest 6.1 (also retries non-idempotent requests: do not use)
        'NoEnumerate'             # ConvertFrom-Json 6.0
        'Parallel'                # ForEach-Object 7.0
        'ResponseHeadersVariable' # Invoke-RestMethod 6.0
        'RetryIntervalSec'        # Invoke-WebRequest 6.1
        'SkipCertificateCheck'    # Invoke-WebRequest 6.0
        'SkipHeaderValidation'    # Invoke-WebRequest 6.0
        'SkipHttpErrorCheck'      # Invoke-WebRequest 7.0
        'SslProtocol'             # Invoke-WebRequest 6.0
        'StatusCodeVariable'      # Invoke-RestMethod 7.0
    )

    # File name -> parameters it may use, because the use is feature-detected
    $script:AllowList = @{
        'Invoke-CWMWebRequest.ps1' = @('AllowInsecureRedirect') # only when $script:CWMSupportsInsecureRedirect
        'Connect-CWM.ps1'          = @('AllowInsecureRedirect') # the module's own parameter / connection property
        'New-CWMDebugReport.ps1'   = @('AllowInsecureRedirect') # reports the connection property, not a cmdlet parameter
        'ConvertFrom-CWMJson.ps1'  = @('NoEnumerate')           # only when $script:CWMJsonSupportsNoEnumerate
    }

    $ModuleRoot = Join-Path $PSScriptRoot '../ConnectWiseManageAPI'
    # Discovery-time data must travel with each test case to be visible when the test runs
    $script:Files = @(Get-ChildItem -Path $ModuleRoot -Include '*.ps1', '*.psm1' -Recurse | ForEach-Object {
            @{ Name = $_.Name; Path = $_.FullName; Ps7Only = $Ps7OnlyParameters; Allowed = @($AllowList[$_.Name]) }
        })
}

BeforeAll {
    # Every name used as a cmdlet parameter, splat-hashtable key or splat member assignment in the code
    function Get-UsedParameterName {
        param([System.Management.Automation.Language.Ast]$Ast)
        $Ast.FindAll({ param($Node) $Node -is [System.Management.Automation.Language.CommandParameterAst] }, $true) |
            ForEach-Object { $_.ParameterName }
        $Ast.FindAll({ param($Node) $Node -is [System.Management.Automation.Language.HashtableAst] }, $true) |
            ForEach-Object { foreach ($Pair in $_.KeyValuePairs) { if ($Pair.Item1 -is [System.Management.Automation.Language.StringConstantExpressionAst]) { $Pair.Item1.Value } } }
        $Ast.FindAll({ param($Node) $Node -is [System.Management.Automation.Language.AssignmentStatementAst] -and $Node.Left -is [System.Management.Automation.Language.MemberExpressionAst] }, $true) |
            ForEach-Object { if ($_.Left.Member -is [System.Management.Automation.Language.StringConstantExpressionAst]) { $_.Left.Member.Value } }
    }
}

Describe 'No unguarded PowerShell 7-only parameters' {

    It 'detects direct, splatted and member-assigned parameters (self-test)' {
        $Code = 'Invoke-WebRequest -SkipCertificateCheck; $a = @{ SkipHttpErrorCheck = $true }; $b.NoEnumerate = $true; # -Parallel in a comment'
        $Ast = [System.Management.Automation.Language.Parser]::ParseInput($Code, [ref]$null, [ref]$null)
        $Used = @(Get-UsedParameterName $Ast)
        $Used | Should -Contain 'SkipCertificateCheck'
        $Used | Should -Contain 'SkipHttpErrorCheck'
        $Used | Should -Contain 'NoEnumerate'
        $Used | Should -Not -Contain 'Parallel'
    }

    It '<Name> only uses parameters available on Windows PowerShell 5.1' -ForEach $Files {
        $Tokens = $null
        $ParseErrors = $null
        $Ast = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$Tokens, [ref]$ParseErrors)
        $ParseErrors | Should -BeNullOrEmpty

        $Violations = @(Get-UsedParameterName $Ast | Where-Object { $Ps7Only -contains $_ -and $Allowed -notcontains $_ } | Sort-Object -Unique)
        $Violations | Should -BeNullOrEmpty -Because 'PowerShell 7-only parameters must be feature-detected in ConnectWiseManageAPI.psm1 and allow-listed in this test'
    }
}
