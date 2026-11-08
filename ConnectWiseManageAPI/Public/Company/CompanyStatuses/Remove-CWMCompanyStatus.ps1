<#
.SYNOPSIS
    Deletes a company status.

.DESCRIPTION
    Deletes a company status from ConnectWise Manage. Calls DELETE /company/companies/statuses/{id}.

.PARAMETER id
    The id of the company status to delete.
    Alias: statusId

.EXAMPLE
    Remove-CWMCompanyStatus -id 5

    Deletes company status 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyStatus {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('statusId')]
        [int]$id
    )
    $Endpoint = "/company/companies/statuses/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
