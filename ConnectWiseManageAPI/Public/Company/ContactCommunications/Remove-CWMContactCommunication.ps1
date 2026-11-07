<#
.SYNOPSIS
    Deletes a communication item of a contact.

.DESCRIPTION
    Deletes a communication item of a contact from ConnectWise Manage. Calls DELETE
    /company/contacts/{parentId}/communications/{id}.

.PARAMETER parentId
    The id of the contact.
    Alias: contactId

.PARAMETER id
    The id of the communication item to delete.
    Alias: communicationId

.EXAMPLE
    Remove-CWMContactCommunication -parentId 12 -id 5

    Deletes communication item 5 of contact 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('contactId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('communicationId')]
        [int]$id
    )
    $Endpoint = "/company/contacts/$($parentId)/communications/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
