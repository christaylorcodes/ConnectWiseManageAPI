<#
.SYNOPSIS
    Deletes the forecast of an opportunity.

.DESCRIPTION
    Deletes the forecast of an opportunity from ConnectWise Manage. Calls DELETE
    /sales/opportunities/{parentId}/forecast.

.PARAMETER parentId
    The id of the opportunity.
    Alias: opportunityId

.EXAMPLE
    Remove-CWMOpportunityForecast -parentId 12

    Deletes the forecast of opportunity 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMOpportunityForecast {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityId')]
        [int]$parentId
    )

    $Endpoint = "/sales/opportunities/$($parentId)/forecast"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}