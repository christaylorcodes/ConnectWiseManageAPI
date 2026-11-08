# Runs the Pester 5 tests. Works on Windows PowerShell 5.1 and PowerShell 7, locally and in CI.
#   -Test      run the tests for the current PowerShell version and save the results
#   -Live      also run the live tests (tag 'Integration') against a real ConnectWise server, using the
#              settings in Tests/live.local.ps1 (copy Tests/live.example.ps1). The write tests (tag 'Write')
#              also need $env:CWMAllowWrite = 'yes': sandbox servers only.
#   -Finalize  read all saved results and fail if any test failed
# Results go to ./TestResults (gitignored), one pair of files per PowerShell version, overwritten each run.

param(
    [switch]$Finalize,
    [switch]$Test,
    [switch]$Live,
    [string]$ProjectRoot = (Split-Path $PSScriptRoot -Parent)
)

$PSVersion = $PSVersionTable.PSVersion.Major
$ResultsDir = Join-Path $ProjectRoot 'TestResults'
$TestFile = Join-Path $ResultsDir "TestResults_PS$PSVersion.xml"
New-Item -ItemType Directory -Path $ResultsDir -Force | Out-Null
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
    # Live tests need a ConnectWise server and run only with -Live; they also skip themselves when CWMServer is not set
    if ($Live) {
        $LiveSettings = Join-Path $PSScriptRoot 'live.local.ps1'
        if (Test-Path $LiveSettings) { . $LiveSettings }
        if (!$env:CWMServer) { throw "-Live needs a ConnectWise server: copy Tests/live.example.ps1 to $LiveSettings and fill it in." }
        "`tLive tests against $env:CWMServer$(if ($env:CWMAllowWrite -eq 'yes') { ', INCLUDING WRITE TESTS' })`n"
    }
    $ExcludeTag = @()
    if (!$Live) { $ExcludeTag += 'Integration' }
    if ($env:CWMAllowWrite -ne 'yes') { $ExcludeTag += 'Write' }
    $Config.Filter.ExcludeTag = $ExcludeTag

    # A file that errors during discovery, or a failing BeforeAll/AfterAll, fails no single test: count those too
    Invoke-Pester -Configuration $Config |
        Select-Object PassedCount, SkippedCount,
        @{ n = 'FailedCount'; e = { $_.FailedCount + $_.FailedBlocksCount + $_.FailedContainersCount } },
        @{ n = 'Failed'; e = {
                $_.Failed | ForEach-Object { $_.ExpandedPath }
                $_.FailedBlocks | ForEach-Object { "Block: $($_.ExpandedPath)" }
                $_.FailedContainers | ForEach-Object { "File: $($_.Item)" }
            }
        } |
        Export-Clixml -Path (Join-Path $ResultsDir "PesterResults_PS$PSVersion.xml")
}

if ($Finalize) {
    $AllFiles = Get-ChildItem -Path (Join-Path $ResultsDir 'PesterResults_PS*.xml')
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
