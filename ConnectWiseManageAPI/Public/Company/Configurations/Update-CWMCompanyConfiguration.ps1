function Update-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('configurationId')]
        [int]$id,
        [Parameter(Mandatory=$true)]
        [validateset('add','replace','remove')]
        [string]$Operation,
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        $Value
    )

    $Endpoint = "/company/configurations/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}