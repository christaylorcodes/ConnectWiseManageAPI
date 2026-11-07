<#
.SYNOPSIS
    Deletes a contact note of a contact.

.DESCRIPTION
    Deletes a contact note of a contact from ConnectWise Manage. Calls DELETE
    /company/contacts/{parentId}/notes/{id}.

.PARAMETER parentId
    The id of the contact.
    Alias: contactId

.PARAMETER id
    The id of the contact note to delete.
    Alias: noteId

.EXAMPLE
    Remove-CWMCompanyContactNote -parentId 12 -id 5

    Deletes contact note 5 of contact 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyContactNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias('Remove-CWMContactNote')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('contactId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('noteId')]
        [int]$id
    )
    $Endpoint = "/company/contacts/$($parentId)/notes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
