<#
.SYNOPSIS
    Deletes a configuration.

.DESCRIPTION
    Deletes a configuration from ConnectWise Manage. Calls DELETE /company/configurations/{id}.

.PARAMETER id
    The id of the configuration to delete.
    Alias: companyConfigurationId

.EXAMPLE
    Remove-CWMCompanyConfiguration -id 5

    Deletes configuration 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('companyConfigurationId')]
        [int]$id
    )

    $Endpoint = "/company/configurations/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
