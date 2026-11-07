#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for the Update-CWM* parameter set pattern (issue #53), run over every PATCH wrapper:
#   (a) a named single operation is sent as a one-element JSON array
#   (b) positional calls bind in the same order as before the Single/Bulk conversion
#   (c) -PatchOperations sends all operations in one request
#   (d) 'remove' works without -Value; 'add'/'replace' without -Value is an error
# Invoke-WebRequest is mocked, so no ConnectWise server or network is needed.

BeforeDiscovery {
    # Route ids in their positional order BEFORE the conversion (implicit positions, declaration order).
    # Operation, Path and Value followed the ids. This table is the contract for backward compatibility,
    # so it is written out by hand instead of being read from the current command metadata.
    $script:Cases = @(
        @{ Name = 'Update-CWMAgreement'; Ids = @('id') }
        @{ Name = 'Update-CWMAgreementAddition'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMAgreementType'; Ids = @('id') }
        @{ Name = 'Update-CWMBoardItemAssociation'; Ids = @('parentId', 'itemId', 'typeId') }
        @{ Name = 'Update-CWMCallbackEntry'; Ids = @('id') }
        @{ Name = 'Update-CWMCompany'; Ids = @('id') }
        @{ Name = 'Update-CWMCompanyConfiguration'; Ids = @('id') }
        @{ Name = 'Update-CWMCompanyConfigurationTypeQuestionValue'; Ids = @('grandparentId', 'parentId', 'id') }
        @{ Name = 'Update-CWMCompanyContact'; Ids = @('id') }
        @{ Name = 'Update-CWMCompanyCustomNote'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMCompanyServiceTemplate'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMCompanySite'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMCompanyTeam'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMCompanyTypeAssociation'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMContactCommunication'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMKnowledgeBaseArticle'; Ids = @('id') }
        @{ Name = 'Update-CWMMember'; Ids = @('id') }
        @{ Name = 'Update-CWMOpportunity'; Ids = @('id') }
        @{ Name = 'Update-CWMOpportunityForecast'; Ids = @('parentId') }
        @{ Name = 'Update-CWMOpportunityForecastItem'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMProductAdjustment'; Ids = @('id') }
        @{ Name = 'Update-CWMProductCatalog'; Ids = @('id') }
        @{ Name = 'Update-CWMProductPickingShippingDetail'; Ids = @('id') }
        @{ Name = 'Update-CWMProject'; Ids = @('id') }
        @{ Name = 'Update-CWMProjectPhase'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMProjectTicket'; Ids = @('id') }
        @{ Name = 'Update-CWMPurchaseOrder'; Ids = @('id') }
        @{ Name = 'Update-CWMScheduleEntry'; Ids = @('id') }
        @{ Name = 'Update-CWMServiceTemplateResource'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMSSOConfiguration'; Ids = @('id') }
        @{ Name = 'Update-CWMTicket'; Ids = @('id') }
        @{ Name = 'Update-CWMTicketTask'; Ids = @('parentId', 'id') }
        @{ Name = 'Update-CWMTimeEntry'; Ids = @('id') }
    )
}

BeforeAll {
    Import-Module "$PSScriptRoot\..\ConnectWiseManageAPI\ConnectWiseManageAPI.psd1" -Force

    # Not PATCH wrappers: Update-CWMTimeSheet posts approve/reject/reverse/submit actions
    $script:NotPatch = @('Update-CWMTimeSheet')

    function Get-SweepIdArgument {
        param([string[]]$Ids)
        $Named = [ordered]@{}
        $Positional = New-Object System.Collections.Generic.List[object]
        for ($i = 0; $i -lt $Ids.Count; $i++) {
            $Named[$Ids[$i]] = 11 + $i
            $Positional.Add(11 + $i)
        }
        @{ Named = $Named; Positional = $Positional.ToArray() }
    }

    function Get-SweepBody {
        param($Call)
        @(ConvertFrom-Json $Call.Body | ForEach-Object { $_ })
    }
}

AfterAll {
    Remove-Variable -Name CWMUpdateSweepCalls -Scope Global -ErrorAction SilentlyContinue
    Remove-Module ConnectWiseManageAPI -Force -ErrorAction SilentlyContinue
}

Describe 'Update-CWM* sweep coverage' {
    It 'covers every exported Update-CWM* PATCH wrapper' -TestCases @{ Cases = $script:Cases } {
        param($Cases)
        $Exported = @(Get-Command -Module ConnectWiseManageAPI -Name 'Update-CWM*' -CommandType Function |
                Where-Object { $_.Name -notin $script:NotPatch } | ForEach-Object { $_.Name } | Sort-Object)
        $Exported | Should -Be @($Cases | ForEach-Object { $_.Name } | Sort-Object)
    }
}

Describe '<Name> Single/Bulk pattern' -ForEach $script:Cases {

    BeforeAll {
        InModuleScope ConnectWiseManageAPI {
            $script:CWMServerConnection = @{
                Server   = 'example.invalid'
                Codebase = 'v4_6_release'
                BasePath = 'apis/3.0'
                Headers  = @{ ClientID = 'test' }
            }
        }
        Mock Invoke-WebRequest -ModuleName ConnectWiseManageAPI {
            $global:CWMUpdateSweepCalls.Add([pscustomobject]@{ Uri = $Uri; Method = $Method; Body = $Body })
            [pscustomobject]@{ StatusCode = 200; Content = '{}'; Headers = @{} }
        }
        $script:IdArgs = Get-SweepIdArgument -Ids $Ids
    }

    BeforeEach {
        $global:CWMUpdateSweepCalls = New-Object System.Collections.Generic.List[object]
    }

    It 'has Single (default) and Bulk parameter sets with explicit positions' {
        $Command = Get-Command $Name
        $Command.DefaultParameterSet | Should -Be 'Single'
        @($Command.ParameterSets.Name | Sort-Object) | Should -Be @('Bulk', 'Single')
        $Single = $Command.ParameterSets | Where-Object Name -eq 'Single'
        $Expected = @($Ids) + @('Operation', 'Path', 'Value')
        @($Single.Parameters | Where-Object Position -ge 0 | Sort-Object Position | ForEach-Object { $_.Name }) | Should -Be $Expected
        @($Single.Parameters | Where-Object Position -ge 0 | Sort-Object Position | ForEach-Object { $_.Position }) | Should -Be @(0..($Expected.Count - 1))
        $Command.Parameters['PatchOperations'].ParameterSets.Keys | Should -Be @('Bulk')
    }

    It '(a) sends a named single operation as a one-element JSON array' {
        $Named = $script:IdArgs.Named
        & $Name @Named -Operation replace -Path summary -Value 'x' | Out-Null
        $global:CWMUpdateSweepCalls | Should -HaveCount 1
        $Call = $global:CWMUpdateSweepCalls[0]
        $Call.Method | Should -Be 'Patch'
        $Call.Body.TrimStart().Substring(0, 1) | Should -Be '['
        foreach ($IdValue in $Named.Values) { $Call.Uri | Should -Match "/$IdValue(/|$)" }
        $B = Get-SweepBody $Call
        $B | Should -HaveCount 1
        $B[0].op | Should -Be 'replace'
        $B[0].path | Should -Be 'summary'
        $B[0].value | Should -Be 'x'
    }

    It '(b) binds positional arguments in the original order' {
        $Named = $script:IdArgs.Named
        $Positional = @($script:IdArgs.Positional) + @('replace', 'summary', 'x')
        & $Name @Named -Operation replace -Path summary -Value 'x' | Out-Null
        & $Name @Positional | Out-Null
        $global:CWMUpdateSweepCalls | Should -HaveCount 2
        $global:CWMUpdateSweepCalls[1].Uri | Should -Be $global:CWMUpdateSweepCalls[0].Uri
        $B = Get-SweepBody $global:CWMUpdateSweepCalls[1]
        $B | Should -HaveCount 1
        $B[0].op | Should -Be 'replace'
        $B[0].path | Should -Be 'summary'
        $B[0].value | Should -Be 'x'
    }

    It '(c) sends -PatchOperations as one request with every operation' {
        $Named = $script:IdArgs.Named
        & $Name @Named -PatchOperations @(
            @{ op = 'replace'; path = 'summary'; value = 'A' }
            [pscustomobject]@{ op = 'replace'; path = 'status'; value = @{ id = 5 } }
        ) | Out-Null
        $global:CWMUpdateSweepCalls | Should -HaveCount 1
        $B = Get-SweepBody $global:CWMUpdateSweepCalls[0]
        $B | Should -HaveCount 2
        $B[0].path | Should -Be 'summary'
        $B[0].value | Should -Be 'A'
        $B[1].path | Should -Be 'status'
        $B[1].value.id | Should -Be 5
    }

    It '(d) sends a remove without -Value, named and positional' {
        $Named = $script:IdArgs.Named
        $Positional = @($script:IdArgs.Positional) + @('remove', 'contact')
        & $Name @Named -Operation remove -Path contact | Out-Null
        & $Name @Positional | Out-Null
        $global:CWMUpdateSweepCalls | Should -HaveCount 2
        foreach ($Call in $global:CWMUpdateSweepCalls) {
            $B = Get-SweepBody $Call
            $B | Should -HaveCount 1
            $B[0].op | Should -Be 'remove'
            $B[0].path | Should -Be 'contact'
            $B[0].PSObject.Properties['value'] | Should -BeNullOrEmpty
        }
    }

    It 'rejects add/replace without -Value but accepts an explicit -Value $null' {
        $Named = $script:IdArgs.Named
        { & $Name @Named -Operation replace -Path summary -ErrorAction Stop } | Should -Throw '*-Value is required*'
        $global:CWMUpdateSweepCalls | Should -HaveCount 0
        & $Name @Named -Operation replace -Path summary -Value $null | Out-Null
        $global:CWMUpdateSweepCalls | Should -HaveCount 1
        $global:CWMUpdateSweepCalls[0].Body | Should -Match '"value":\s*null'
    }

    It 'rejects mixing -PatchOperations with -Operation' {
        $Named = $script:IdArgs.Named
        { & $Name @Named -Operation replace -Path p -Value v -PatchOperations @(@{ op = 'replace'; path = 'p'; value = 1 }) } | Should -Throw
        $global:CWMUpdateSweepCalls | Should -HaveCount 0
    }
}
