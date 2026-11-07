#Requires -Modules @{ ModuleName = 'Pester'; ModuleVersion = '5.0.0' }
# Offline tests for the Update-CWM* parameter set pattern (issue #53), run over every PATCH wrapper:
#   (a) a named single operation is sent as a one-element JSON array
#   (b) positional calls bind in the same order as before the Single/Bulk conversion
#   (c) -PatchOperations sends all operations in one request
#   (d) 'remove' works without -Value; 'add'/'replace' without -Value is an error
# The exact URL of each wrapper is checked in Endpoints.Tests.ps1 only where it was in doubt.
# Invoke-WebRequest is mocked.

BeforeDiscovery {
    # Route ids in their positional order BEFORE the conversion (implicit positions, declaration order).
    # Operation, Path and Value followed the ids. This table is the contract for backward compatibility,
    # so it is written out by hand instead of being read from the current command metadata.
    $Cases = @(
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
        # Deliberate exception: was @('id'), but the URL held a literal '{parentId}' so the function never
        # worked. The bug fix added a mandatory parentId (alias productId) in front of id.
        @{ Name = 'Update-CWMProductPickingShippingDetail'; Ids = @('parentId', 'id') }
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
    . "$PSScriptRoot/Helpers/TestSetup.ps1"

    function Get-RequestBody {
        param($Request)
        @(ConvertFrom-Json $Request.Body | ForEach-Object { $_ })
    }
}

AfterAll {
    Remove-CWMTestSetup
}

Describe 'Update-CWM* coverage' {
    It 'covers every exported Update-CWM* PATCH wrapper' -TestCases @{ Cases = $Cases } {
        param($Cases)
        # Update-CWMTimeSheet is not a PATCH wrapper: it posts approve/reject/reverse/submit actions
        $Exported = @(Get-Command -Module ConnectWiseManageAPI -Name 'Update-CWM*' -CommandType Function |
                Where-Object Name -ne 'Update-CWMTimeSheet' | ForEach-Object { $_.Name } | Sort-Object)
        $Exported | Should -Be @($Cases | ForEach-Object { $_.Name } | Sort-Object)
    }
}

Describe '<Name> Single/Bulk pattern' -ForEach $Cases {

    BeforeAll {
        Set-CWMTestConnection
        # Ids 11, 12, 13... by position
        $Named = [ordered]@{}
        for ($i = 0; $i -lt $Ids.Count; $i++) { $Named[$Ids[$i]] = 11 + $i }
        $Positional = @($Named.Values)
    }

    BeforeEach {
        Set-CWMTestResponse
    }

    It 'has Single (default) and Bulk parameter sets with explicit positions' {
        $Command = Get-Command $Name
        $Command.DefaultParameterSet | Should -Be 'Single'
        @($Command.ParameterSets.Name | Sort-Object) | Should -Be @('Bulk', 'Single')
        $Single = $Command.ParameterSets | Where-Object Name -eq 'Single'
        $Expected = @($Ids) + @('Operation', 'Path', 'Value')
        $ByPosition = @($Single.Parameters | Where-Object Position -ge 0 | Sort-Object Position)
        @($ByPosition | ForEach-Object { $_.Name }) | Should -Be $Expected
        @($ByPosition | ForEach-Object { $_.Position }) | Should -Be @(0..($Expected.Count - 1))
        $Command.Parameters['PatchOperations'].ParameterSets.Keys | Should -Be @('Bulk')
    }

    It '(a) sends a named single operation as a one-element JSON array' {
        & $Name @Named -Operation replace -Path summary -Value 'x' | Out-Null
        $global:CWMTestRequests | Should -HaveCount 1
        $Request = $global:CWMTestRequests[0]
        $Request.Method | Should -Be 'Patch'
        $Request.Body.TrimStart().Substring(0, 1) | Should -Be '['
        foreach ($IdValue in $Named.Values) { $Request.Uri | Should -Match "/$IdValue(/|$)" }
        $B = Get-RequestBody $Request
        $B | Should -HaveCount 1
        $B[0].op | Should -Be 'replace'
        $B[0].path | Should -Be 'summary'
        $B[0].value | Should -Be 'x'
    }

    It '(b) binds positional arguments in the original order' {
        $Arguments = $Positional + @('replace', 'summary', 'x')
        & $Name @Named -Operation replace -Path summary -Value 'x' | Out-Null
        & $Name @Arguments | Out-Null
        $global:CWMTestRequests | Should -HaveCount 2
        $global:CWMTestRequests[1].Uri | Should -Be $global:CWMTestRequests[0].Uri
        $global:CWMTestRequests[1].Body | Should -Be $global:CWMTestRequests[0].Body
    }

    It '(c) sends -PatchOperations as one request with every operation' {
        & $Name @Named -PatchOperations @(
            @{ op = 'replace'; path = 'summary'; value = 'A' }
            [pscustomobject]@{ op = 'replace'; path = 'status'; value = @{ id = 5 } }
        ) | Out-Null
        $global:CWMTestRequests | Should -HaveCount 1
        $B = Get-RequestBody $global:CWMTestRequests[0]
        $B | Should -HaveCount 2
        $B[0].path | Should -Be 'summary'
        $B[0].value | Should -Be 'A'
        $B[1].path | Should -Be 'status'
        $B[1].value.id | Should -Be 5
    }

    It '(d) sends a remove without -Value, named and positional' {
        $Arguments = $Positional + @('remove', 'contact')
        & $Name @Named -Operation remove -Path contact | Out-Null
        & $Name @Arguments | Out-Null
        $global:CWMTestRequests | Should -HaveCount 2
        foreach ($Request in $global:CWMTestRequests) {
            $B = Get-RequestBody $Request
            $B | Should -HaveCount 1
            $B[0].op | Should -Be 'remove'
            $B[0].path | Should -Be 'contact'
            $B[0].PSObject.Properties['value'] | Should -BeNullOrEmpty
        }
    }

    It 'rejects add/replace without -Value but accepts an explicit -Value $null' {
        { & $Name @Named -Operation replace -Path summary -ErrorAction Stop } | Should -Throw '*-Value is required*'
        $global:CWMTestRequests | Should -HaveCount 0
        & $Name @Named -Operation replace -Path summary -Value $null | Out-Null
        $global:CWMTestRequests | Should -HaveCount 1
        $global:CWMTestRequests[0].Body | Should -Match '"value":\s*null'
    }

    It 'rejects mixing -PatchOperations with -Operation' {
        { & $Name @Named -Operation replace -Path p -Value v -PatchOperations @(@{ op = 'replace'; path = 'p'; value = 1 }) } | Should -Throw
        $global:CWMTestRequests | Should -HaveCount 0
    }
}
