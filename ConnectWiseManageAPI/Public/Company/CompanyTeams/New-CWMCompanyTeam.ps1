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
        [int]$locationId,
        [int]$businessUnitId,
        [hashtable]$contact,
        [hashtable]$member,
        [boolean]$accountManagerFlag,
        [boolean]$techFlag,
        [boolean]$salesFlag,
        [hashtable]$_info
    )

    $Endpoint = "/company/companies/$($parentId)/teams"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
