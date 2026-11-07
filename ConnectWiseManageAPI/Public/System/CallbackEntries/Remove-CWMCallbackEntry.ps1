<#
.SYNOPSIS
    Deletes a callback entry.

.DESCRIPTION
    Deletes a callback entry from ConnectWise Manage. Calls DELETE /system/callbacks/{id}.

.PARAMETER id
    The id of the callback entry to delete.
    Alias: callbackId

.EXAMPLE
    Remove-CWMCallbackEntry -id 5

    Deletes callback entry 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('callbackId')]
        [int]$id
    )

    $Endpoint = "/system/callbacks/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
