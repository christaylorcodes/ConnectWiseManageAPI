function Update-CWMSSOConfiguration {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [int]$id,
        [Parameter(Mandatory = $true)]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [Parameter(Mandatory = $true)]
        $Value
    )

    if ($PSCmdlet.ShouldProcess($Path, 'Update SSO Configuration')) {
        $Endpoint = "/system/ssoConfigurations/$($id)"
        Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
    }
}