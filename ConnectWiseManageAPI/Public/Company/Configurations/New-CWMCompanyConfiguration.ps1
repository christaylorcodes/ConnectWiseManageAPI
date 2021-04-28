function New-CWMCompanyConfiguration {
    # 2020.4
    # ^ add a comment for what version of the api you used to create function
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

    # If there are parameters that should not be included in the body. grandparentId & parentId already skipped.
    $Skip = @()

    $Endpoint = 'company/configurations'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}