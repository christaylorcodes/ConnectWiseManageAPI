<#
.SYNOPSIS
    Finds, and optionally deletes, records left behind by the live write tests (Tests/Live.Write.Tests.ps1).

.DESCRIPTION
    Development tool, not shipped in the module. The write tests name everything they create with a 'PSTEST'
    prefix and delete it again; if a run is interrupted, records can be left on the server. This lists:
      - companies whose identifier starts with the prefix
      - tickets whose summary starts with it
      - contacts whose last name starts with it
    Nothing is deleted unless -Remove is given. Tickets and contacts are deleted before their companies.

    Connect first with Connect-CWM (the same API member the tests use).

.PARAMETER Prefix
    The prefix to look for. Defaults to 'PSTEST'.

.PARAMETER Remove
    Delete the records found (each one still asks for confirmation unless -Confirm:$false is passed).

.EXAMPLE
    ./Tools/Remove-CWMTestData.ps1

    Lists leftover test records without changing anything.

.EXAMPLE
    ./Tools/Remove-CWMTestData.ps1 -Remove -Confirm:$false

    Deletes every leftover test record.

.NOTES
    Runs on PowerShell 7 and Windows PowerShell 5.1.
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [ValidatePattern('^PSTEST')]
    [string]$Prefix = 'PSTEST',
    [switch]$Remove
)

if (!(Get-Module ConnectWiseManageAPI)) { throw 'Import the module and run Connect-CWM first.' }

$Found = @(
    Get-CWMTicket -condition "summary like '$Prefix*'" -all -ErrorAction Stop |
        ForEach-Object { [pscustomobject]@{ Type = 'Ticket'; Id = $_.id; Name = $_.summary; Order = 1 } }
    Get-CWMCompanyContact -condition "lastName like '$Prefix*'" -all -ErrorAction Stop |
        ForEach-Object { [pscustomobject]@{ Type = 'Contact'; Id = $_.id; Name = "$($_.firstName) $($_.lastName)"; Order = 2 } }
    Get-CWMCompany -condition "identifier like '$Prefix*'" -all -ErrorAction Stop |
        ForEach-Object { [pscustomobject]@{ Type = 'Company'; Id = $_.id; Name = "$($_.identifier) $($_.name)"; Order = 3 } }
) | Sort-Object Order, Id

if (!$Remove) { return $Found | Select-Object Type, Id, Name }

$Commands = @{ Ticket = 'Remove-CWMTicket'; Contact = 'Remove-CWMCompanyContact'; Company = 'Remove-CWMCompany' }
foreach ($Item in $Found) {
    if ($PSCmdlet.ShouldProcess("$($Item.Type) $($Item.Id) '$($Item.Name)'", 'Delete')) {
        & $Commands[$Item.Type] -id $Item.Id -Confirm:$false
    }
}
