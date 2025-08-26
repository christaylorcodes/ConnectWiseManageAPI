function New-CWMCompanyCustomNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [alias ('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $false)]
        [hashtable]$status,
        [Parameter(Mandatory = $false)]
        [string]$customNote
    )

    $Endpoint = "/company/companies/$($parentId)/customStatusNotes"
    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $Endpoint
}