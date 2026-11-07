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
