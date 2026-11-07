<#
.SYNOPSIS
    Deletes a forecast item of an opportunity.

.DESCRIPTION
    Deletes a forecast item of an opportunity from ConnectWise Manage. Calls DELETE
    /sales/opportunities/{parentId}/forecast/{id}.

.PARAMETER parentId
    The id of the opportunity.

.PARAMETER id
    The id of the forecast item to delete.

.EXAMPLE
    Remove-CWMOpportunityForecastItem -parentId 12 -id 5

    Deletes forecast item 5 of opportunity 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMOpportunityForecastItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId,
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$parentId/forecast/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}