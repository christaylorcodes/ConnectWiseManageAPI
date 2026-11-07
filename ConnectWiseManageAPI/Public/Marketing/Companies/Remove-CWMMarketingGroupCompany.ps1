<#
.SYNOPSIS
    Removes a company from a marketing group.

.DESCRIPTION
    Removes a company from a marketing group in ConnectWise Manage. Calls DELETE
    /marketing/groups/{parentId}/companies/{id}.

.PARAMETER parentId
    The id of the marketing group.
    Alias: groupId

.PARAMETER id
    The id of the company to remove from the marketing group.
    Alias: companyId

.EXAMPLE
    Remove-CWMMarketingGroupCompany -parentId 12 -id 5

    Deletes company 5 of marketing group 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMMarketingGroupCompany {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('groupId')]
        [int]$parentId,
        [Alias('companyId')]
        [Parameter(Mandatory = $true)]
        [int]$id
    )

    $Endpoint = "/marketing/groups/$($parentId)/companies/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
