#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0' }
# Smoke test for every Get-CWM* function: called with only its mandatory parameters (filled with dummy
# values), it must send exactly one well-formed request. This catches the cheap routing bugs in functions
# that have no hand-written test in Endpoints.Tests.ps1: a route id that silently became 0, a query string
# that starts with '&', a broken master call. Exact paths are checked by Endpoints.Tests.ps1 and
# Tools/Test-CWMApiCoverage.ps1, not here. Invoke-WebRequest is mocked.

BeforeDiscovery {
    Import-Module "$PSScriptRoot/../ConnectWiseManageAPI/ConnectWiseManageAPI.psd1" -Force
    # Functions that do not go through Invoke-CWMGetMaster with a plain list request
    $Skip = @(
        'Get-CWMChargeCode'     # wraps Get-CWMReport and post-processes report rows
        'Get-CWMTicketDocument' # downloads through Get-CWMDocument
    )
    $GetFunctions = Get-Command -Module ConnectWiseManageAPI -Verb Get |
        Where-Object CommandType -EQ 'Function' |
        Where-Object Name -NotIn $Skip |
        ForEach-Object { @{ Name = $_.Name } }
}

BeforeAll {
    . "$PSScriptRoot/Helpers/TestSetup.ps1"

    function Get-CWMDummyArgument([System.Management.Automation.CommandInfo]$Command) {
        # Values for the mandatory parameters of the default parameter set; never -OutFile or switches
        $Set = $Command.ParameterSets | Where-Object IsDefault
        if (!$Set) { $Set = $Command.ParameterSets[0] }
        $Arguments = @{}
        $Mandatory = $Set.Parameters | Where-Object {
            $_.IsMandatory -and $_.Name -ne 'OutFile' -and $_.ParameterType -ne [switch]
        }
        foreach ($Parameter in $Mandatory) {
            $Type = $Parameter.ParameterType
            $ValidSet = $Parameter.Attributes | Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] }
            $Arguments[$Parameter.Name] = if ($ValidSet) { $ValidSet.ValidValues[0] }
            elseif ($Type -in [int], [long], [int[]], [long[]]) { 7 }
            elseif ($Type -eq [datetime]) { Get-Date '2026-01-01' }
            elseif ($Type -eq [hashtable]) { @{ id = 7 } }
            else { 'dummy' }
        }
        $Arguments
    }
}

AfterAll {
    Remove-CWMTestSetup
}

Describe 'Get-CWM* smoke test' {
    BeforeEach {
        Set-CWMTestConnection
        Set-CWMTestResponse -Content '[]'
    }

    It '<Name> sends one well-formed request' -ForEach $GetFunctions {
        $Arguments = Get-CWMDummyArgument (Get-Command $Name)
        & $Name @Arguments -ErrorAction Stop | Out-Null

        $global:CWMTestRequests.Count | Should -Be 1
        $Request = $global:CWMTestRequests[0]
        # Get-CWMTicket without an id runs a POST .../search
        "$($Request.Method)" | Should -BeIn 'GET', 'Get', 'POST', 'Post'
        $Uri = "$($Request.Uri)"
        $Uri | Should -BeLike "$CWMTestBaseUri/*"
        $Path = ($Uri -split '\?')[0].Substring($CWMTestBaseUri.Length)
        $Path | Should -Not -Match '/0(/|$)' -Because 'a route id must not silently default to 0'
        $Path | Should -Not -Match '//' -Because 'path segments must not be empty'
        $Uri | Should -Not -Match '^[^?]*&' -Because 'a query string must start with ?'
    }
}
