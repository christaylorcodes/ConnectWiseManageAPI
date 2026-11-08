<#
.SYNOPSIS
    Assigns a team member to a company.

.DESCRIPTION
    Creates a team member assignment for a company in ConnectWise Manage. Calls POST
    /company/companies/{parentId}/teams; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the company to add the team member assignment to.
    Alias: companyId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER company
    Company reference, for example @{ id = 250 }.

.PARAMETER teamRole
    Team role reference, for example @{ id = 1 }. Required by the API.

.PARAMETER location
    Location reference, for example @{ id = 1 }.
    Alias: locationId

.PARAMETER department
    Department reference, for example @{ id = 1 }.
    Alias: businessUnitId

.PARAMETER contact
    Contact reference, for example @{ id = 500 }.

.PARAMETER member
    Member reference, for example @{ id = 10 }.

.PARAMETER accountManagerFlag
    Account manager flag. $true or $false.

.PARAMETER techFlag
    Tech flag. $true or $false.

.PARAMETER salesFlag
    Sales flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMCompanyTeam -parentId 250 -teamRole @{ id = 1 } -member @{ id = 10 } -accountManagerFlag $true

    Adds member 10 to the team of company 250 with team role 1, as account manager.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyTeam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('companyId')]
        [int]$parentId,
        [int]$id,
        [hashtable]$company,
        [Parameter(Mandatory=$true)]
        [hashtable]$teamRole,
        # A SystemLocationReference / SystemDepartmentReference: @{ id = N }. An int is accepted too.
        [Alias('locationId')]
        [object]$location,
        [Alias('businessUnitId')]
        [object]$department,
        [hashtable]$contact,
        [hashtable]$member,
        [boolean]$accountManagerFlag,
        [boolean]$techFlag,
        [boolean]$salesFlag,
        [hashtable]$_info
    )

    # Work on a copy so $PSBoundParameters is never modified
    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }

    # -locationId / -businessUnitId (old int parameters) become references: 5 -> @{ id = 5 }
    foreach ($Name in 'location', 'department') {
        if ($Arguments.ContainsKey($Name) -and ($Arguments[$Name] -is [ValueType] -or $Arguments[$Name] -is [string])) {
            $Arguments[$Name] = @{ id = [int]$Arguments[$Name] }
        }
    }

    $Endpoint = "/company/companies/$($parentId)/teams"
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint $Endpoint
}
