function New-CWMCompanyConfiguration {
    # 2020.4
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [Parameter(Mandatory=$true)]
        [hashtable]$company,
        [Parameter(Mandatory=$true)]
        [string]$name,
        [hashtable]$installedby,
        [string]$modelNumber,
        [string]$serialNumber,
        [hashtable]$manufacturer,
        [array]$questions
    )

    $Endpoint = 'company/configurations'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
