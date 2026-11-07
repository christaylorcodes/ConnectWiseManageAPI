<#
.SYNOPSIS
    Deletes an opportunity.

.DESCRIPTION
    Deletes an opportunity from ConnectWise Manage. Calls DELETE /sales/opportunities/{id}.

.PARAMETER id
    The id of the opportunity to delete.

.EXAMPLE
    Remove-CWMOpportunity -id 5

    Deletes opportunity 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMOpportunity {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$id
    )

    $endpoint = "/sales/opportunities/$id"

    Invoke-CWMRemoveMaster -Endpoint $endpoint
}