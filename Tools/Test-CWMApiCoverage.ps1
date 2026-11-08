<#
.SYNOPSIS
    Checks the module's endpoint functions against the ConnectWise Manage OpenAPI spec.

.DESCRIPTION
    Development tool, not shipped in the module. It statically analyses every function under
    ConnectWiseManageAPI/Public with the PowerShell AST (the module is not imported and no call is made
    to a ConnectWise server), works out the HTTP method and URL template of each Invoke-CWM*Master call,
    and compares them with the paths and methods in a ConnectWise Manage OpenAPI 3 spec (manage.json).

    Method per master: Get = GET, Search = POST (to .../search), New = POST, Update = PATCH, Set = PUT,
    Remove = DELETE, Action = POST. For Invoke-CWMGetMaster the /{id} variant (function has an id
    parameter) and the /count variant (function has a count switch) are checked too.

    The report lists:
      1. Calls whose method + path is not in the spec (likely wrong or removed).
      2. Paths that match only when the literal segments are compared case-insensitively.
      3. For New/Set (POST/PUT body) calls, function parameters that are not properties of the spec's
         request-body schema, and required schema properties the function does not expose.
      4. Spec operations with no module function, summarized by tag (a backlog).
      Plus the calls whose endpoint could not be resolved statically.

    The official spec is behind the ConnectWise developer login. By default the maintained copy from
    https://github.com/covenanttechnologysolutions/connectwise-rest (generator/manage-json/manage.json)
    is downloaded to a temp file and deleted afterwards. Do not commit the spec to this repository.

.PARAMETER SpecPath
    A local manage.json, for example one exported from the ConnectWise developer portal.
    When given, nothing is downloaded.

.PARAMETER SpecUrl
    The URL the spec is downloaded from when -SpecPath is not given.

.PARAMETER ModulePath
    The module folder to analyse. Defaults to ../ConnectWiseManageAPI next to this script.

.PARAMETER OutputPath
    Optional path of a markdown report to write.

.PARAMETER PassThru
    Return the detailed result object (checks, mismatches, uncovered operations) instead of the summary.

.EXAMPLE
    ./Tools/Test-CWMApiCoverage.ps1 -OutputPath ./api-coverage.md

    Downloads the maintained spec, checks the module and writes a markdown report.

.EXAMPLE
    ./Tools/Test-CWMApiCoverage.ps1 -SpecPath C:\Temp\manage.json -PassThru | Select-Object -ExpandProperty NotInSpec

    Checks against a local spec and lists the calls whose method + path is not in it.

.NOTES
    Runs on PowerShell 7 and Windows PowerShell 5.1.
#>
[CmdletBinding()]
param(
    [string]$SpecPath,
    [string]$SpecUrl = 'https://raw.githubusercontent.com/covenanttechnologysolutions/connectwise-rest/master/generator/manage-json/manage.json',
    [string]$ModulePath,
    [string]$OutputPath,
    [switch]$PassThru
)

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'
# Set here, not as a parameter default: Windows PowerShell 5.1 leaves $PSScriptRoot empty in script param defaults
if (-not $ModulePath) { $ModulePath = Join-Path (Split-Path $PSScriptRoot -Parent) 'ConnectWiseManageAPI' }

$MasterMethod = @{
    Get    = 'GET'
    Search = 'POST'
    New    = 'POST'
    Update = 'PATCH'
    Set    = 'PUT'
    Remove = 'DELETE'
    Action = 'POST'
}
# Parameters the request body builder leaves out, or that are module-only
$NonBodyParameter = @('parentId', 'grandparentId', 'Body', 'ContentType', 'Headers') +
@([System.Management.Automation.Cmdlet]::CommonParameters) + @([System.Management.Automation.Cmdlet]::OptionalCommonParameters)

#region Spec helpers
function Get-DictKey($Dictionary) {
    # .Keys / .Count can be shadowed by a key with that name, so use the methods
    if ($Dictionary -isnot [System.Collections.IDictionary]) { return @() }
    @($Dictionary.get_Keys())
}

function Read-CWMSpec([string]$Path) {
    $Json = [System.IO.File]::ReadAllText($Path)
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        # Case-sensitive keys: the spec has paths that differ only in casing
        # Splatted: -AsHashtable does not exist on 5.1, which takes the branch below
        $AsHashtable = @{ AsHashtable = $true }
        return ($Json | ConvertFrom-Json @AsHashtable)
    }
    Add-Type -AssemblyName System.Web.Extensions
    $Serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
    $Serializer.MaxJsonLength = [int]::MaxValue
    $Serializer.RecursionLimit = 1000
    $Serializer.DeserializeObject($Json)
}

function Resolve-SpecSchema($Spec, $Schema) {
    $Guard = 0
    while ($Schema -is [System.Collections.IDictionary] -and $Guard++ -lt 20) {
        if ($Schema['$ref']) {
            $Name = ($Schema['$ref'] -split '/')[-1]
            $Schema = $Spec['components']['schemas'][$Name]
        }
        elseif ($Schema['type'] -eq 'array' -and $Schema['items']) { $Schema = $Schema['items'] }
        else { break }
    }
    $Schema
}

function Get-SpecBodySchema($Spec, $Operation) {
    $Body = $Operation['requestBody']
    if (-not $Body) { return $null }
    $Content = $Body['content']
    $Media = Get-DictKey $Content | Where-Object { $_ -like '*json*' } | Select-Object -First 1
    if (-not $Media) { $Media = Get-DictKey $Content | Select-Object -First 1 }
    if (-not $Media) { return $null }
    $Raw = $Content[$Media]['schema']
    $Name = $null
    if ($Raw -is [System.Collections.IDictionary]) {
        $Ref = $Raw['$ref']
        if (-not $Ref -and $Raw['items'] -is [System.Collections.IDictionary]) { $Ref = $Raw['items']['$ref'] }
        if ($Ref) { $Name = ($Ref -split '/')[-1] }
    }
    [pscustomobject]@{ Name = $Name; Schema = (Resolve-SpecSchema $Spec $Raw) }
}
#endregion

#region Path helpers
function ConvertTo-NormalizedPath([string]$Path) {
    # A query string (also one wrongly started with &) is not part of the path
    $Path = ($Path -split '[?&]')[0]
    $Path = $Path -replace '\\', '/' -replace '/{2,}', '/'
    if (-not $Path.StartsWith('/')) { $Path = "/$Path" }
    if ($Path.Length -gt 1) { $Path = $Path.TrimEnd('/') }
    $Path
}

function Test-Placeholder([string]$Segment) { $Segment -match '\{' }

function Compare-PathTemplate([string[]]$ModuleSegment, [string[]]$SpecSegment) {
    # Returns $null when the paths do not match, else how they matched
    if ($ModuleSegment.Count -ne $SpecSegment.Count) { return $null }
    $Loose = $false; $CaseDiff = $false
    for ($i = 0; $i -lt $ModuleSegment.Count; $i++) {
        $m = $ModuleSegment[$i]; $s = $SpecSegment[$i]
        $mp = Test-Placeholder $m; $sp = Test-Placeholder $s
        if ($mp -and $sp) { continue }
        # A module literal may fill a spec placeholder (loose), but a module placeholder never matches a
        # spec literal such as 'count' or 'search'
        if ($mp) { return $null }
        if ($sp) { $Loose = $true; continue }
        if ($m -ceq $s) { continue }
        if ($m -eq $s) { $CaseDiff = $true; continue }
        return $null
    }
    [pscustomobject]@{ Loose = $Loose; CaseDiff = $CaseDiff }
}
#endregion

#region AST helpers
function Test-AstAncestor($Ancestor, $Ast) {
    $p = $Ast
    while ($p) { if ($p -eq $Ancestor) { return $true }; $p = $p.Parent }
    $false
}

function Get-CommandArgument($CommandAst, [string]$Name) {
    $Elements = $CommandAst.CommandElements
    for ($i = 1; $i -lt $Elements.Count; $i++) {
        $e = $Elements[$i]
        if ($e -is [System.Management.Automation.Language.CommandParameterAst] -and $e.ParameterName -eq $Name) {
            if ($e.Argument) { return $e.Argument }
            if ($i + 1 -lt $Elements.Count) { return $Elements[$i + 1] }
        }
    }
    $null
}

function ConvertFrom-ExpandableText([string]$Text, [string]$SelfName, [string[]]$Prior) {
    # Turns "/a/$($parentId)/b/$id" into "/a/{parentId}/b/{id}"; $SelfName references take the prior values
    $Self = '\$(\(\s*\$' + $SelfName + '\s*\)|\{' + $SelfName + '\}|' + $SelfName + '\b)'
    $Values = @($Text)
    if ($SelfName -and $Text -match $Self) {
        if (-not $Prior) { return $null }
        $Values = foreach ($p in $Prior) { [regex]::Replace($Text, $Self, $p.Replace('$', '$$'), 'IgnoreCase') }
    }
    foreach ($v in $Values) {
        # "$([uri]::EscapeDataString($x))" (also with a [string] cast) is the escaped value of $x
        $v = $v -replace '\$\(\s*\[uri\]::EscapeDataString\(\s*(?:\[string\])?\$(?:\w+:)?(\w+)\s*\)\s*\)', '{$1}'
        $v = $v -replace '\$\(\s*\$(?:\w+:)?(\w+)\s*\)', '{$1}' -replace '\$\{(?:\w+:)?(\w+)\}', '{$1}' -replace '\$(?:\w+:)?(\w+)', '{$1}'
        if ($v -match '\$') { return $null }
        $v
    }
}

function ConvertFrom-EndpointExpression($Ast, [string]$SelfName, [string[]]$Prior) {
    # Returns the possible string values of an Endpoint expression, or $null when it cannot be resolved
    $L = 'System.Management.Automation.Language'
    switch ($Ast.GetType().FullName) {
        "$L.StringConstantExpressionAst" { return , @($Ast.Value) }
        "$L.ExpandableStringExpressionAst" {
            $r = @(ConvertFrom-ExpandableText $Ast.Value $SelfName $Prior)
            if ($r.Count -eq 0 -or $null -eq $r[0]) { return $null }
            return , $r
        }
        "$L.VariableExpressionAst" {
            if ($SelfName -and $Ast.VariablePath.UserPath -eq $SelfName -and $Prior) { return , @($Prior) }
            return $null
        }
        "$L.ParenExpressionAst" { return ConvertFrom-EndpointExpression $Ast.Pipeline.PipelineElements[0].Expression $SelfName $Prior }
        "$L.CommandExpressionAst" { return ConvertFrom-EndpointExpression $Ast.Expression $SelfName $Prior }
        "$L.PipelineAst" {
            if ($Ast.PipelineElements.Count -eq 1) { return ConvertFrom-EndpointExpression $Ast.PipelineElements[0] $SelfName $Prior }
            return $null
        }
        "$L.BinaryExpressionAst" {
            if ($Ast.Operator -ne 'Plus') { return $null }
            $Left = ConvertFrom-EndpointExpression $Ast.Left $SelfName $Prior
            $Right = ConvertFrom-EndpointExpression $Ast.Right $SelfName $Prior
            if ($null -eq $Left -or $null -eq $Right) { return $null }
            return , @(foreach ($a in $Left) { foreach ($b in $Right) { "$a$b" } })
        }
    }
    $null
}

function Get-VariableAssignment($FunctionAst, [string]$Name) {
    @($FunctionAst.FindAll({
                param($a)
                $a -is [System.Management.Automation.Language.AssignmentStatementAst] -and
                $a.Left -is [System.Management.Automation.Language.VariableExpressionAst] -and
                $a.Left.VariablePath.UserPath -eq $Name
            }, $true) | Sort-Object { $_.Extent.StartOffset })
}

function ConvertFrom-Assignment($Assignment, [string]$Name, [string[]]$Prior) {
    $Right = ConvertFrom-EndpointExpression $Assignment.Right $Name $Prior
    if ($null -eq $Right) { return $null }
    if ($Assignment.Operator -eq 'Equals') { return , $Right }
    if ($Assignment.Operator -ne 'PlusEquals' -or -not $Prior) { return $null }
    , @(foreach ($a in $Prior) { foreach ($b in $Right) { "$a$b" } })
}

function Resolve-VariableValue($FunctionAst, $CallAst, [string]$Name) {
    # Returns @{ Values = [list of @{Value; Container}]; Error } for $Name as seen by $CallAst
    $Assignments = @(Get-VariableAssignment $FunctionAst $Name | Where-Object { $_.Extent.StartOffset -lt $CallAst.Extent.StartOffset })
    if (-not $Assignments) { return @{ Values = @(); Error = "no assignment to `$$Name" } }

    $Dominating = @($Assignments | Where-Object { Test-AstAncestor $_.Parent $CallAst })
    $Current = @()
    $LastOffset = -1
    foreach ($a in $Dominating) {
        $Prior = @($Current | ForEach-Object { $_.Value })
        $v = ConvertFrom-Assignment $a $Name $Prior
        if ($null -eq $v) { return @{ Values = @(); Error = "cannot resolve: $($a.Extent.Text)" } }
        $Current = @($v | ForEach-Object { @{ Value = $_; Container = $a.Parent } })
        $LastOffset = $a.Extent.StartOffset
    }

    $Conditional = @($Assignments | Where-Object { $_.Extent.StartOffset -gt $LastOffset -and -not (Test-AstAncestor $_.Parent $CallAst) })
    if (-not $Conditional) { return @{ Values = $Current; Error = $null } }

    # The prior value survives unless an if/else chain with an else clause assigns it in every branch
    $Overwritten = $false
    $Ifs = $FunctionAst.FindAll({ param($x) $x -is [System.Management.Automation.Language.IfStatementAst] }, $true)
    foreach ($If in $Ifs) {
        if ($If.Extent.StartOffset -le $LastOffset -or $If.Extent.StartOffset -gt $CallAst.Extent.StartOffset) { continue }
        if (Test-AstAncestor $If $CallAst) { continue }
        if (-not $If.ElseClause) { continue }
        $Blocks = @($If.Clauses | ForEach-Object { $_.Item2 }) + $If.ElseClause
        $AllAssign = $true
        foreach ($b in $Blocks) {
            if (-not ($Conditional | Where-Object { Test-AstAncestor $b $_ })) { $AllAssign = $false }
        }
        if ($AllAssign) { $Overwritten = $true }
    }

    $Prior = @($Current | ForEach-Object { $_.Value })
    $Result = @()
    if (-not $Overwritten) { $Result += $Current }
    foreach ($a in $Conditional) {
        $v = ConvertFrom-Assignment $a $Name $Prior
        if ($null -eq $v) { return @{ Values = @(); Error = "cannot resolve: $($a.Extent.Text)" } }
        $Result += @($v | ForEach-Object { @{ Value = $_; Container = $a.Parent } })
    }
    @{ Values = $Result; Error = $null }
}

function Get-HashtableKey($HashtableAst) {
    @($HashtableAst.KeyValuePairs | ForEach-Object {
            if ($_.Item1 -is [System.Management.Automation.Language.StringConstantExpressionAst]) { $_.Item1.Value }
        })
}

function Resolve-BodyKey($FunctionAst, $CallAst, $ArgumentAst, $Container, [string[]]$ParameterName) {
    # Returns @{ Source; Keys } describing the body/arguments hashtable passed to a master
    if ($null -eq $ArgumentAst) { return @{ Source = 'none'; Keys = @() } }
    if ($ArgumentAst -is [System.Management.Automation.Language.HashtableAst]) {
        return @{ Source = 'hashtable'; Keys = (Get-HashtableKey $ArgumentAst) }
    }
    if ($ArgumentAst -is [System.Management.Automation.Language.VariableExpressionAst]) {
        $Var = $ArgumentAst.VariablePath.UserPath
        if ($Var -eq 'PSBoundParameters') {
            # A parameter counts as removed when the Remove() always runs before the call, or runs under
            # an if whose condition tests that parameter (if ($id) { $PSBoundParameters.Remove('id') })
            $Removed = @($FunctionAst.FindAll({
                        param($x)
                        $x -is [System.Management.Automation.Language.InvokeMemberExpressionAst] -and
                        $x.Member.Extent.Text -eq 'Remove' -and $x.Expression.Extent.Text -eq '$PSBoundParameters' -and
                        $x.Extent.StartOffset -lt $CallAst.Extent.StartOffset
                    }, $true) | ForEach-Object {
                    $Remove = $_
                    $Statement = $Remove
                    while ($Statement.Parent -and $Statement.Parent -isnot [System.Management.Automation.Language.StatementBlockAst] -and
                        $Statement.Parent -isnot [System.Management.Automation.Language.NamedBlockAst]) { $Statement = $Statement.Parent }
                    $Block = $Statement.Parent
                    foreach ($Name in @($Remove.Arguments | ForEach-Object { $_.SafeGetValue() })) {
                        $Applies = Test-AstAncestor $Block $CallAst
                        if (-not $Applies -and $Block.Parent -is [System.Management.Automation.Language.IfStatementAst]) {
                            $Clause = $Block.Parent.Clauses | Where-Object { $_.Item2 -eq $Block }
                            if ($Clause -and $Clause.Item1.Extent.Text -match "^\`$$Name$") { $Applies = $true }
                        }
                        if ($Applies) { $Name }
                    }
                })
            return @{ Source = 'PSBoundParameters'; Keys = @($ParameterName | Where-Object { $Removed -notcontains $_ }) }
        }
        $Assignments = @(Get-VariableAssignment $FunctionAst $Var | Where-Object {
                $_.Extent.StartOffset -lt $CallAst.Extent.StartOffset -and $_.Right -is [System.Management.Automation.Language.CommandExpressionAst] -and
                $_.Right.Expression -is [System.Management.Automation.Language.HashtableAst]
            })
        $Pick = $Assignments | Where-Object { $Container -and $_.Parent -eq $Container } | Select-Object -Last 1
        if (-not $Pick) { $Pick = $Assignments | Where-Object { Test-AstAncestor $_.Parent $CallAst } | Select-Object -Last 1 }
        if ($Pick) { return @{ Source = "`$$Var"; Keys = (Get-HashtableKey $Pick.Right.Expression) } }
        return @{ Source = "`$$Var (unresolved)"; Keys = $null }
    }
    @{ Source = 'unresolved'; Keys = $null }
}
#endregion

#region Load spec
$TempSpec = $null
if (-not $SpecPath) {
    $TempSpec = Join-Path ([System.IO.Path]::GetTempPath()) ("cwm-manage-{0}.json" -f [guid]::NewGuid())
    Write-Verbose "Downloading $SpecUrl to $TempSpec"
    $OldProgress = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'
    try {
        # Windows PowerShell only, as in the module's psm1: allow TLS 1.2 without touching SystemDefault (0),
        # because OR-ing Tls12 into SystemDefault would pin the process to TLS 1.2. pwsh 7 needs nothing here.
        if ($PSVersionTable.PSEdition -ne 'Core') {
            $Protocol = [Net.ServicePointManager]::SecurityProtocol
            if ([int]$Protocol -ne 0 -and -not ($Protocol -band [Net.SecurityProtocolType]::Tls12)) {
                [Net.ServicePointManager]::SecurityProtocol = $Protocol -bor [Net.SecurityProtocolType]::Tls12
            }
        }
        Invoke-WebRequest -Uri $SpecUrl -OutFile $TempSpec -UseBasicParsing
    }
    finally { $ProgressPreference = $OldProgress }
    $SpecPath = $TempSpec
}

try {
    $Spec = Read-CWMSpec $SpecPath
}
finally {
    if ($TempSpec -and (Test-Path $TempSpec)) { Remove-Item $TempSpec -Force }
}
$SpecVersion = $Spec['info']['version']
$SpecTitle = $Spec['info']['title']

$HttpMethods = 'get', 'post', 'put', 'patch', 'delete'
$SpecPaths = foreach ($Key in (Get-DictKey $Spec['paths'])) {
    $Item = $Spec['paths'][$Key]
    $Norm = ConvertTo-NormalizedPath $Key
    [pscustomobject]@{
        Key      = $Key
        Path     = $Norm
        Segments = [string[]]@($Norm.Trim('/') -split '/')
        Methods  = @(Get-DictKey $Item | Where-Object { $HttpMethods -contains $_ } | ForEach-Object { $_.ToUpper() })
        Item     = $Item
    }
}
$SpecByCount = $SpecPaths | Group-Object { $_.Segments.Count } -AsHashTable -AsString
#endregion

#region Analyse module
$Checks = New-Object System.Collections.Generic.List[object]
$Unresolved = New-Object System.Collections.Generic.List[object]
$Files = Get-ChildItem (Join-Path $ModulePath 'Public') -Recurse -Filter *.ps1 | Where-Object { $_.Directory.Name -ne 'Invoke' }

foreach ($File in $Files) {
    $Tokens = $null; $ParseErrors = $null
    $Ast = [System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref]$Tokens, [ref]$ParseErrors)
    $Functions = $Ast.FindAll({ param($x) $x -is [System.Management.Automation.Language.FunctionDefinitionAst] }, $true)
    foreach ($Function in $Functions) {
        $ParameterName = @()
        if ($Function.Body.ParamBlock) { $ParameterName = @($Function.Body.ParamBlock.Parameters | ForEach-Object { $_.Name.VariablePath.UserPath }) }
        $Calls = $Function.Body.FindAll({
                param($x)
                $x -is [System.Management.Automation.Language.CommandAst] -and $x.GetCommandName() -match '^Invoke-CWM(Get|Search|New|Update|Set|Remove|Action)Master$'
            }, $true)
        foreach ($Call in $Calls) {
            $null = $Call.GetCommandName() -match '^Invoke-CWM(\w+)Master$'
            $Master = $Matches[1]
            $Method = $MasterMethod[$Master]
            $EndpointAst = Get-CommandArgument $Call 'Endpoint'
            $ArgumentAst = Get-CommandArgument $Call 'Arguments'
            $SkipAst = Get-CommandArgument $Call 'Skip'
            $Skip = @()
            if ($SkipAst) { try { $Skip = @($SkipAst.SafeGetValue()) } catch { $Skip = @() } }

            $Values = @()
            if ($null -eq $EndpointAst) {
                $Unresolved.Add([pscustomobject]@{ Function = $Function.Name; Master = $Master; Reason = 'no -Endpoint argument' }); continue
            }
            if ($EndpointAst -is [System.Management.Automation.Language.VariableExpressionAst]) {
                $r = Resolve-VariableValue $Function $Call $EndpointAst.VariablePath.UserPath
                if ($r.Error -or -not $r.Values) {
                    $Unresolved.Add([pscustomobject]@{ Function = $Function.Name; Master = $Master; Reason = $r.Error }); continue
                }
                $Values = $r.Values
            }
            else {
                $v = ConvertFrom-EndpointExpression $EndpointAst $null $null
                if ($null -eq $v) {
                    $Unresolved.Add([pscustomobject]@{ Function = $Function.Name; Master = $Master; Reason = "cannot resolve: $($EndpointAst.Extent.Text)" }); continue
                }
                $Values = @($v | ForEach-Object { @{ Value = $_; Container = $null } })
            }

            $Seen = @{}
            foreach ($Value in $Values) {
                $Template = ConvertTo-NormalizedPath $Value.Value
                $Body = Resolve-BodyKey $Function $Call $ArgumentAst $Value.Container $ParameterName
                $Variants = @(@{ Variant = 'base'; Path = $Template })
                if ($Master -eq 'Get') {
                    $Keys = @($Body.Keys)
                    $HasIdPlaceholder = $Template -match '\{id\}'
                    if ($Keys -contains 'id' -and -not $HasIdPlaceholder) { $Variants += @{ Variant = 'id'; Path = "$Template/{id}" } }
                    if ($Keys -contains 'count' -and -not $HasIdPlaceholder) { $Variants += @{ Variant = 'count'; Path = "$Template/count" } }
                }
                foreach ($Variant in $Variants) {
                    $SeenKey = "$Method $($Variant.Path)"
                    if ($Seen[$SeenKey]) { continue }
                    $Seen[$SeenKey] = $true
                    $PathVars = @([regex]::Matches($Variant.Path, '\{(\w+)\}') | ForEach-Object { $_.Groups[1].Value })
                    $Checks.Add([pscustomobject]@{
                            Function   = $Function.Name
                            File       = $File.FullName.Substring($ModulePath.Length).TrimStart('\', '/')
                            Master     = $Master
                            Method     = $Method
                            Variant    = $Variant.Variant
                            Path       = $Variant.Path
                            BodySource = $Body.Source
                            BodyKeys   = $Body.Keys
                            Skip       = $Skip
                            PathVars   = $PathVars
                            Status     = $null
                            SpecPath   = $null
                            Detail     = $null
                        })
                }
            }
        }
    }
}
#endregion

#region Compare
$Covered = @{}
foreach ($Check in $Checks) {
    $Segments = [string[]]@($Check.Path.Trim('/') -split '/')
    $Candidates = @(foreach ($sp in @($SpecByCount[[string]$Segments.Count])) {
            if (-not $sp) { continue }
            $m = Compare-PathTemplate $Segments $sp.Segments
            if ($m) {
                [pscustomobject]@{ Spec = $sp; Loose = $m.Loose; CaseDiff = $m.CaseDiff; HasMethod = ($sp.Methods -contains $Check.Method) }
            }
        }) | Sort-Object @{ e = { $_.Loose } }, @{ e = { -not $_.HasMethod } }, @{ e = { $_.CaseDiff } }

    if (-not $Candidates) {
        $Check.Status = 'NotInSpec'; $Check.Detail = 'path not in spec'; continue
    }
    $Best = $Candidates[0]
    $Check.SpecPath = $Best.Spec.Key
    if (-not $Best.HasMethod) {
        $Check.Status = 'NotInSpec'; $Check.Detail = "method not in spec (spec has $($Best.Spec.Methods -join ', '))"; continue
    }
    $Covered["$($Best.Spec.Key)|$($Check.Method)"] = $true
    if ($Best.Loose) { $Check.Status = 'LooseMatch'; $Check.Detail = 'matched only with a placeholder against a literal segment' }
    elseif ($Best.CaseDiff) { $Check.Status = 'Casing'; $Check.Detail = 'literal segment casing differs' }
    else { $Check.Status = 'OK' }
}

# Request-body fields for POST/PUT bodies
$BodyIssues = New-Object System.Collections.Generic.List[object]
foreach ($Check in ($Checks | Where-Object { ($_.Master -eq 'New' -or $_.Master -eq 'Set') -and $_.SpecPath -and $_.Status -ne 'NotInSpec' })) {
    if ($null -eq $Check.BodyKeys) { continue }
    $Operation = $Spec['paths'][$Check.SpecPath][$Check.Method.ToLower()]
    $BodySchema = Get-SpecBodySchema $Spec $Operation
    if (-not $BodySchema -or $BodySchema.Schema -isnot [System.Collections.IDictionary]) { continue }
    $Properties = @(Get-DictKey $BodySchema.Schema['properties'])
    if ($Properties.Count -eq 0) { continue }
    $Required = @($BodySchema.Schema['required'] | Where-Object { $_ })
    $Keys = @($Check.BodyKeys | Where-Object {
            $NonBodyParameter -notcontains $_ -and $Check.Skip -notcontains $_ -and
            ($Check.BodySource -ne 'PSBoundParameters' -or $Check.PathVars -notcontains $_)
        })
    $NotInSchema = @($Keys | Where-Object { $Properties -notcontains $_ })
    $CaseOnly = @($Keys | Where-Object { $Properties -contains $_ -and -not ($Properties -ccontains $_) } |
        ForEach-Object { $k = $_; "$k->$($Properties | Where-Object { $_ -eq $k } | Select-Object -First 1)" })
    $MissingRequired = @($Required | Where-Object { $Keys -notcontains $_ })
    if ($NotInSchema -or $MissingRequired -or $CaseOnly) {
        $BodyIssues.Add([pscustomobject]@{
                Function        = $Check.Function
                Method          = $Check.Method
                Path            = $Check.Path
                Schema          = $BodySchema.Name
                NotInSchema     = $NotInSchema
                MissingRequired = $MissingRequired
                CaseOnly        = $CaseOnly
            })
    }
}

# Every spec operation by its first tag; the ones no module function covers are the backlog
$Operations = foreach ($sp in $SpecPaths) {
    foreach ($m in $sp.Methods) {
        $Tags = @($sp.Item[$m.ToLower()]['tags'])
        $Tag = if ($Tags -and $Tags[0]) { $Tags[0] } else { '(untagged)' }
        [pscustomobject]@{ Tag = $Tag; Method = $m; Path = $sp.Key; Area = ($sp.Path.Trim('/') -split '/')[0]; Covered = [bool]$Covered["$($sp.Key)|$m"] }
    }
}
$TotalOps = @($Operations).Count
$OperationsByTag = $Operations | Group-Object Tag -AsHashTable -AsString
$Uncovered = @($Operations | Where-Object { -not $_.Covered } | Select-Object Tag, Method, Path, Area)
$UncoveredByTag = $Uncovered | Group-Object Tag | ForEach-Object {
    [pscustomobject]@{ Tag = $_.Name; Area = ($_.Group | Group-Object Area | Sort-Object Count -Descending | Select-Object -First 1).Name; Uncovered = $_.Count; Total = @($OperationsByTag[$_.Name]).Count }
} | Sort-Object @{ e = { $_.Uncovered -eq $_.Total } }, @{ e = 'Uncovered'; Descending = $true }
#endregion

$FunctionsChecked = @($Checks | Select-Object -ExpandProperty Function -Unique).Count
$NotInSpec = @($Checks | Where-Object Status -eq 'NotInSpec')
$Casing = @($Checks | Where-Object Status -eq 'Casing')
$Loose = @($Checks | Where-Object Status -eq 'LooseMatch')

#region Report
if ($OutputPath) {
    $sb = New-Object System.Text.StringBuilder
    function Add-Line([string]$Text = '') { [void]$sb.AppendLine($Text) }
    function Format-Cell($Value) { ((@($Value) | Where-Object { $_ }) -join ', ') -replace '\|', '\|' }

    Add-Line "# ConnectWise Manage API coverage"
    Add-Line
    Add-Line "- Spec: **$SpecTitle**, info.version **$SpecVersion** ($(@($SpecPaths).Count) paths, $TotalOps operations)"
    Add-Line "- Module: ``$ModulePath``"
    Add-Line "- Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm') by Tools/Test-CWMApiCoverage.ps1"
    Add-Line
    Add-Line "| Measure | Count |"
    Add-Line "|---|---|"
    Add-Line "| Module functions checked | $FunctionsChecked |"
    Add-Line "| Method + path checks | $($Checks.Count) |"
    Add-Line "| Not in spec | $($NotInSpec.Count) |"
    Add-Line "| Casing mismatches | $($Casing.Count) |"
    Add-Line "| Matched only by placeholder wildcard | $($Loose.Count) |"
    Add-Line "| Request-body field mismatches (functions) | $(@($BodyIssues | Select-Object -ExpandProperty Function -Unique).Count) |"
    Add-Line "| Unresolved master calls | $($Unresolved.Count) |"
    Add-Line "| Spec operations with no module function | $(@($Uncovered).Count) of $TotalOps |"
    Add-Line

    Add-Line "## 1. Not in the spec (likely wrong or removed)"
    Add-Line
    Add-Line "Variant ``id``/``count`` = the /{id} or /count path Invoke-CWMGetMaster builds for -id or -count."
    Add-Line
    Add-Line "| Function | Method | Path | Variant | Detail |"
    Add-Line "|---|---|---|---|---|"
    foreach ($c in ($NotInSpec | Sort-Object Function, Path)) { Add-Line "| $($c.Function) | $($c.Method) | ``$($c.Path)`` | $($c.Variant) | $($c.Detail) |" }
    Add-Line

    Add-Line "## 2. Casing mismatches"
    Add-Line
    Add-Line "| Function | Method | Module path | Spec path |"
    Add-Line "|---|---|---|---|"
    foreach ($c in ($Casing | Sort-Object Function, Path)) { Add-Line "| $($c.Function) | $($c.Method) | ``$($c.Path)`` | ``$($c.SpecPath)`` |" }
    if ($Loose) {
        Add-Line
        Add-Line "### Matched only by placeholder wildcard (check these)"
        Add-Line
        Add-Line "| Function | Method | Module path | Spec path |"
        Add-Line "|---|---|---|---|"
        foreach ($c in ($Loose | Sort-Object Function, Path)) { Add-Line "| $($c.Function) | $($c.Method) | ``$($c.Path)`` | ``$($c.SpecPath)`` |" }
    }
    Add-Line

    Add-Line "## 3. Request-body fields (New/Set functions)"
    Add-Line
    Add-Line "Parameters sent in the body that are not properties of the spec's request-body schema, and required schema properties the function does not expose. Path variables, parentId/grandparentId and module-only parameters are excluded."
    Add-Line
    Add-Line "| Function | Path | Schema | Not in schema | Missing required | Casing |"
    Add-Line "|---|---|---|---|---|---|"
    foreach ($b in ($BodyIssues | Sort-Object Function)) {
        Add-Line "| $($b.Function) | ``$($b.Method) $($b.Path)`` | $($b.Schema) | $(Format-Cell $b.NotInSchema) | $(Format-Cell $b.MissingRequired) | $(Format-Cell $b.CaseOnly) |"
    }
    Add-Line

    Add-Line "## 4. Spec endpoints with no module function (backlog by tag)"
    Add-Line
    $Partial = @($UncoveredByTag | Where-Object { $_.Uncovered -lt $_.Total })
    $None = @($UncoveredByTag | Where-Object { $_.Uncovered -eq $_.Total })
    Add-Line "$(@($Uncovered).Count) of $TotalOps operations uncovered across $(@($UncoveredByTag).Count) tags. $($None.Count) tags have no module function at all."
    Add-Line
    Add-Line "Operation counts include the spec's /count, /info and /usages variants. Use -PassThru for the full list (Uncovered, UncoveredByTag)."
    Add-Line
    Add-Line "Partly covered tags, top 15 by uncovered operations ($($Partial.Count) in all):"
    Add-Line
    Add-Line "| Tag | Area | Uncovered | Total |"
    Add-Line "|---|---|---|---|"
    foreach ($t in ($Partial | Select-Object -First 15)) { Add-Line "| $($t.Tag) | $($t.Area) | $($t.Uncovered) | $($t.Total) |" }
    Add-Line
    Add-Line "Tags with no module function, by area (largest tags first):"
    Add-Line
    Add-Line "| Area | Tags | Operations | Largest tags |"
    Add-Line "|---|---|---|---|"
    foreach ($g in ($None | Group-Object Area | Sort-Object { ($_.Group | Measure-Object Uncovered -Sum).Sum } -Descending)) {
        $Largest = ($g.Group | Sort-Object @{ e = 'Uncovered'; Descending = $true }, Tag | Select-Object -First 5 | ForEach-Object { "$($_.Tag) ($($_.Uncovered))" }) -join ', '
        Add-Line "| $($g.Name) | $($g.Count) | $(($g.Group | Measure-Object Uncovered -Sum).Sum) | $Largest |"
    }
    Add-Line

    Add-Line "## Unresolved master calls"
    Add-Line
    if ($Unresolved.Count) {
        Add-Line "| Function | Master | Reason |"
        Add-Line "|---|---|---|"
        foreach ($u in $Unresolved) { Add-Line "| $($u.Function) | $($u.Master) | $(Format-Cell $u.Reason) |" }
    }
    else { Add-Line 'None.' }

    $Utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath), $sb.ToString(), $Utf8)
}
#endregion

if ($PassThru) {
    [pscustomobject]@{
        SpecTitle      = $SpecTitle
        SpecVersion    = $SpecVersion
        Checks         = $Checks.ToArray()
        NotInSpec      = $NotInSpec
        Casing         = $Casing
        LooseMatch     = $Loose
        BodyIssues     = $BodyIssues.ToArray()
        Unresolved     = $Unresolved.ToArray()
        Uncovered      = @($Uncovered)
        UncoveredByTag = @($UncoveredByTag)
    }
}
else {
    [pscustomobject]@{
        SpecVersion       = $SpecVersion
        FunctionsChecked  = $FunctionsChecked
        Checks            = $Checks.Count
        NotInSpec         = $NotInSpec.Count
        Casing            = $Casing.Count
        LooseMatch        = $Loose.Count
        BodyIssues        = $BodyIssues.Count
        Unresolved        = $Unresolved.Count
        UncoveredOps      = @($Uncovered).Count
        TotalSpecOps      = $TotalOps
        Report            = $OutputPath
    }
}
