#Requires -Modules ConnectWiseManageAPI
<#
.SYNOPSIS
    Sets the contact on each configuration to the contact matching the device's last logged-in user.

.DESCRIPTION
    Retrieves every configuration of the given type (default 'Managed Workstation') and, for each one,
    tries to find the company contact that corresponds to the configuration's lastLoginName.

    The last login name is normalized first: a 'DOMAIN\' prefix and an '@upn.suffix' are removed.
    Excluded accounts (default 'codeblue' and 'administrator') and empty names are skipped.

    Matching is exact (case-insensitive) and is done only against contacts of the configuration's company:
      1. EmailLocalPart - the part before '@' of any of the contact's email addresses equals the user name.
      2. Name rules, used only when no email matches:
           first.last / 'first last'    - first name and last name both equal
           firstlast                    - first name + last name concatenated
           first initial + last name    - e.g. jsmith
           first name + last initial    - e.g. johns
           first name only              - e.g. john
    If more than one contact matches at the same step the configuration is skipped as ambiguous.

    Contacts are indexed by company id up front, so each configuration is only compared against the
    contacts of its own company.

    One object is written to the pipeline per configuration describing what was decided
    (Updated, WouldUpdate, Unchanged or Skipped) and why.

    Prerequisite: run Connect-CWM before this script. The script does not connect or install anything.

.PARAMETER ConfigurationType
    Name of the configuration type to process. Default: 'Managed Workstation'.

.PARAMETER ExcludeUser
    User names (after the domain prefix is removed) that are never matched to a contact.
    Default: 'codeblue', 'administrator'.

.PARAMETER IncludeInactiveContacts
    Also consider contacts marked inactive. By default only active contacts are used.

.EXAMPLE
    Connect-CWM @CWMConnectionInfo
    .\Set-CWMConfigurationLastUser.ps1 -WhatIf -Verbose

    Shows which configurations would be updated without changing anything.

.EXAMPLE
    .\Set-CWMConfigurationLastUser.ps1 -ExcludeUser 'administrator','admin','svc_backup' |
        Where-Object Action -eq 'Skipped' | Format-Table

    Updates configurations and lists the ones that were skipped, with the reason.

.EXAMPLE
    .\Set-CWMConfigurationLastUser.ps1 -ConfigurationType 'Managed Server' -Confirm

    Processes a different configuration type and asks before each update.

.NOTES
    Based on a contribution by epiphanyplx in PR #79
    Requires an existing ConnectWise Manage session (Connect-CWM).
    API endpoints: GET /company/configurations, GET /company/contacts, PATCH /company/configurations/{id}
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [ValidateNotNullOrEmpty()]
    [string]$ConfigurationType = 'Managed Workstation',

    [AllowEmptyCollection()]
    [string[]]$ExcludeUser = @('codeblue', 'administrator'),

    [switch]$IncludeInactiveContacts
)

function Get-NormalizedUserName {
    param([string]$LoginName)
    if ([string]::IsNullOrWhiteSpace($LoginName)) { return $null }
    $Name = $LoginName.Trim()
    if ($Name -like '*\*') { $Name = $Name.Split('\')[-1] }
    if ($Name -like '*@*') { $Name = $Name.Split('@')[0] }
    $Name.Trim()
}

function Get-ContactEmailLocalPart {
    param($Contact)
    foreach ($Item in @($Contact.communicationItems)) {
        if ($null -eq $Item) { continue }
        $Value = [string]$Item.value
        if ($Value -like '*@*') { $Value.Split('@')[0].Trim() }
    }
}

function Test-ContactNameMatch {
    # Returns the name of the rule that matched, or $null.
    param(
        [string]$User,
        $Contact
    )
    $First = ([string]$Contact.firstName).Trim()
    $Last = ([string]$Contact.lastName).Trim()
    if (-not $First) { return $null }

    if ($User -match '^([^.\s]+)[.\s]+([^.\s]+)$') {
        if ($Matches[1] -eq $First -and $Matches[2] -eq $Last) { return 'FirstLast' }
        return $null
    }
    if ($Last) {
        if ($User -eq "$First$Last") { return 'FirstLast' }
        if ($User -eq "$($First.Substring(0, 1))$Last") { return 'FirstInitialLastName' }
        if ($User -eq "$First$($Last.Substring(0, 1))") { return 'FirstNameLastInitial' }
    }
    if ($User -eq $First) { return 'FirstName' }
    $null
}

function ConvertTo-Decision {
    param($Config, $User, $Action, $Reason, $Contact, $Rule)
    [PSCustomObject]@{
        ConfigurationId   = $Config.id
        ConfigurationName = $Config.name
        Company           = $Config.company.name
        LastLoginName     = $Config.lastLoginName
        User              = $User
        Action            = $Action
        Reason            = $Reason
        MatchRule         = $Rule
        ContactId         = if ($Contact) { $Contact.id } else { $null }
        ContactName       = if ($Contact) { "$($Contact.firstName) $($Contact.lastName)".Trim() } else { $null }
    }
}

$TypeName = $ConfigurationType -replace "'", "''"
$ConfigParams = @{
    condition = "type/name='$TypeName'"
    fields    = @('id', 'name', 'company', 'contact', 'lastLoginName')
    all       = $true
}
Write-Verbose "Retrieving configurations of type '$ConfigurationType'."
$Configs = @(Get-CWMCompanyConfiguration @ConfigParams)
Write-Verbose "Found $($Configs.Count) configuration(s)."
if ($Configs.Count -eq 0) { return }

$ContactParams = @{
    fields = @('id', 'firstName', 'lastName', 'company', 'communicationItems')
    all    = $true
}
if (-not $IncludeInactiveContacts) { $ContactParams.condition = 'inactiveFlag=false' }
Write-Verbose 'Retrieving contacts.'
$ContactsByCompany = @{}
foreach ($Contact in @(Get-CWMCompanyContact @ContactParams)) {
    if ($null -eq $Contact.company) { continue }
    $Key = [string]$Contact.company.id
    if (-not $ContactsByCompany.ContainsKey($Key)) {
        $ContactsByCompany[$Key] = New-Object System.Collections.Generic.List[object]
    }
    $ContactsByCompany[$Key].Add($Contact)
}
Write-Verbose "Indexed contacts for $($ContactsByCompany.Count) compan(y/ies)."

foreach ($Config in $Configs) {
    $User = Get-NormalizedUserName $Config.lastLoginName
    if (-not $User) {
        Write-Verbose "Skipping '$($Config.name)': no last login name."
        ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason 'No last login name'
        continue
    }
    if ($ExcludeUser -contains $User) {
        Write-Verbose "Skipping '$($Config.name)': user '$User' is excluded."
        ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason 'Excluded user'
        continue
    }

    $CompanyContacts = $ContactsByCompany[[string]$Config.company.id]
    if (-not $CompanyContacts) {
        Write-Verbose "Skipping '$($Config.name)': company '$($Config.company.name)' has no contacts."
        ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason 'Company has no contacts'
        continue
    }

    # Step 1: exact email local-part match.
    $Rule = 'EmailLocalPart'
    $Candidates = @($CompanyContacts | Where-Object { @(Get-ContactEmailLocalPart $_) -contains $User })

    # Step 2: name rules, only if no email matched.
    if ($Candidates.Count -eq 0) {
        $Rule = $null
        $Candidates = @(foreach ($Contact in $CompanyContacts) {
                $NameRule = Test-ContactNameMatch -User $User -Contact $Contact
                if ($NameRule) { $Rule = $NameRule; $Contact }
            })
    }

    if ($Candidates.Count -eq 0) {
        Write-Verbose "Skipping '$($Config.name)': no contact matches '$User'."
        ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason 'No matching contact'
        continue
    }
    if ($Candidates.Count -gt 1) {
        $Ids = ($Candidates | ForEach-Object { $_.id }) -join ', '
        Write-Warning "Skipping '$($Config.name)' ($($Config.company.name)): '$User' matches $($Candidates.Count) contacts ($Ids)."
        ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason "Ambiguous: $($Candidates.Count) contacts match ($Ids)" -Contact $null -Rule $Rule
        continue
    }

    $Match = $Candidates[0]
    if ($Config.contact -and $Config.contact.id -eq $Match.id) {
        Write-Verbose "'$($Config.name)' already assigned to contact $($Match.id)."
        ConvertTo-Decision -Config $Config -User $User -Action 'Unchanged' -Reason 'Contact already set' -Contact $Match -Rule $Rule
        continue
    }

    $Target = "Configuration '$($Config.name)' ($($Config.id)) for $($Config.company.name)"
    $Change = "Set contact to $($Match.firstName) $($Match.lastName) ($($Match.id)) via $Rule"
    if ($PSCmdlet.ShouldProcess($Target, $Change)) {
        try {
            $null = Update-CWMCompanyConfiguration -id $Config.id -Operation replace -Path 'contact/id' -Value $Match.id -Confirm:$false -ErrorAction Stop
            ConvertTo-Decision -Config $Config -User $User -Action 'Updated' -Reason 'Matched' -Contact $Match -Rule $Rule
        }
        catch {
            Write-Warning "Failed to update $Target`: $_"
            ConvertTo-Decision -Config $Config -User $User -Action 'Skipped' -Reason "Update failed: $_" -Contact $Match -Rule $Rule
        }
    }
    else {
        ConvertTo-Decision -Config $Config -User $User -Action 'WouldUpdate' -Reason 'WhatIf or declined' -Contact $Match -Rule $Rule
    }
}
