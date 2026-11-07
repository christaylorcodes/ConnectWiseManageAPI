# Runs the Pester 5 tests. Works on Windows PowerShell 5.1 and PowerShell 7, locally and in CI.
#   -Test      run the tests for the current PowerShell version and save the results
#   -Finalize  read all saved results and fail if any test failed

param(
    [switch]$Finalize,
    [switch]$Test,
    [string]$ProjectRoot = (Split-Path $PSScriptRoot -Parent)
)

$Timestamp = Get-Date -UFormat '%Y%m%d-%H%M%S'
$PSVersion = $PSVersionTable.PSVersion.Major
$TestFile = Join-Path $ProjectRoot "TestResults_PS$PSVersion`_$TimeStamp.xml"
Set-Location $ProjectRoot

if ($Test) {
    "`n`tSTATUS: Testing with PowerShell $PSVersion`n"

    # Windows PowerShell ships Pester 3.4; make sure Pester 5 is the one loaded
    Import-Module Pester -MinimumVersion 5.0 -Force

    $Config = New-PesterConfiguration
    $Config.Run.Path = Join-Path $ProjectRoot 'Tests'
    $Config.Run.PassThru = $true
    $Config.TestResult.Enabled = $true
    $Config.TestResult.OutputFormat = 'NUnitXml'
    $Config.TestResult.OutputPath = $TestFile
    # Live tests need a ConnectWise server; they also skip themselves when CWMServer is not set
    if (!$env:CWMServer) { $Config.Filter.ExcludeTag = 'Integration' }

    Invoke-Pester -Configuration $Config |
        Select-Object PassedCount, FailedCount, SkippedCount, @{ n = 'Failed'; e = { $_.Failed | ForEach-Object { $_.ExpandedPath } } } |
        Export-Clixml -Path (Join-Path $ProjectRoot "PesterResults_PS$PSVersion`_$Timestamp.xml")
}

if ($Finalize) {
    $AllFiles = Get-ChildItem -Path (Join-Path $ProjectRoot 'PesterResults_PS*.xml')
    "`n`tSTATUS: Finalizing results`n"
    "COLLATING FILES:`n$($AllFiles.FullName | Out-String)"

    $Results = @($AllFiles | Import-Clixml)
    $FailedCount = ($Results | Measure-Object -Property FailedCount -Sum).Sum

    if ($FailedCount -gt 0) {
        "FAILED TESTS SUMMARY:`n"
        $Results.Failed | Sort-Object | ForEach-Object { "  $_" }
        throw "$FailedCount tests failed."
    }
}
