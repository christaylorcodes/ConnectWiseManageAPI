<#
.SYNOPSIS
    Removes a team member assignment from a company.

.DESCRIPTION
    Deletes a team member assignment of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/teams/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of the team member assignment to delete.
    Alias: teamId

.EXAMPLE
    Remove-CWMCompanyTeam -parentId 12 -id 5

    Deletes team member assignment 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyTeam {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('teamId')]
        [int]$id
    )
    $Endpoint = "/company/companies/$($parentId)/teams/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}