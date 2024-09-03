function New-CWMCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $false)]
        [string]$addressLine1,
        [Parameter(Mandatory = $false)]
        [string]$addressLine2,
        [Parameter(Mandatory = $false)]
        [string]$city,
        [Parameter(Mandatory = $false)]
        [hashtable]$stateReference,
        [Parameter(Mandatory = $false)]
        [string]$zip,
        [Parameter(Mandatory = $false)]
        [hashtable]$country,
        [Parameter(Mandatory = $false)]
        [string]$phoneNumber,
        [Parameter(Mandatory = $false)]
        [hashtable]$entityType
    )

    $Endpoint = "/company/companies/$id/sites"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}