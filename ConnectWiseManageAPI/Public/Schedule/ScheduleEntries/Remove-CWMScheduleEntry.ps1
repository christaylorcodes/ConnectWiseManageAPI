<#
.SYNOPSIS
    Deletes a schedule entry.

.DESCRIPTION
    Deletes a schedule entry from ConnectWise Manage. Calls DELETE /schedule/entries/{id}.

.PARAMETER id
    The id of the schedule entry to delete.
    Alias: entryId

.EXAMPLE
    Remove-CWMScheduleEntry -id 5

    Deletes schedule entry 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('entryId')]
        [int]$id
    )

    $Endpoint = "/schedule/entries/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
