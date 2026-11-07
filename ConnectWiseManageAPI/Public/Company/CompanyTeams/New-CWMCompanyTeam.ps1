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

    # -locationId / -businessUnitId (old int parameters) become references: 5 -> @{ id = 5 }
    foreach ($Name in 'location', 'department') {
        if ($PSBoundParameters.ContainsKey($Name) -and ($PSBoundParameters[$Name] -is [ValueType] -or $PSBoundParameters[$Name] -is [string])) {
            $PSBoundParameters[$Name] = @{ id = [int]$PSBoundParameters[$Name] }
        }
    }

    $Endpoint = "/company/companies/$($parentId)/teams"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
