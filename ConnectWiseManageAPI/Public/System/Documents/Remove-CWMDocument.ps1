<#
.SYNOPSIS
    Deletes a document.

.DESCRIPTION
    Deletes a document from ConnectWise Manage. Calls DELETE /system/documents/{id}.

.PARAMETER id
    The id of the document to delete.
    Alias: documentId

.EXAMPLE
    Remove-CWMDocument -id 5

    Deletes document 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMDocument {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('documentId')]
        [int]$id
    )
    $Endpoint = "/system/documents/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
