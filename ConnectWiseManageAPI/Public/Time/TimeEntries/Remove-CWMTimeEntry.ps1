<#
.SYNOPSIS
    Deletes a time entry.

.DESCRIPTION
    Deletes a time entry from ConnectWise Manage. Calls DELETE /time/entries/{id}.

.PARAMETER id
    The id of the time entry to delete.
    Alias: entryId

.EXAMPLE
    Remove-CWMTimeEntry -id 5

    Deletes time entry 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMTimeEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('entryId')]
        [int]$id
    )

    $Endpoint = "/time/entries/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
