function New-CWMCompanyTeam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
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

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/companies/$id/teams"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
