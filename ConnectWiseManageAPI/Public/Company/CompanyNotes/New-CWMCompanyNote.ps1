function New-CWMCompanyNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$id,
        [Parameter(Mandatory = $false)]
        [bool]$flagged,
        [Parameter(Mandatory = $false)]
        [string]$text
    )

    $Endpoint = "/company/companies/$id/notes"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}