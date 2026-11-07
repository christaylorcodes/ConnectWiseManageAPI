<#
.SYNOPSIS
    Deletes a time sheet.

.DESCRIPTION
    Deletes a time sheet from ConnectWise Manage. Calls DELETE /time/sheets/{id}.

.PARAMETER id
    The id of the time sheet to delete.
    Alias: timesheetId

.EXAMPLE
    Remove-CWMTimeSheet -id 5

    Deletes time sheet 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMTimeSheet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('timesheetId')]
        [int]$id
    )
    $Endpoint = "/time/sheets/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}