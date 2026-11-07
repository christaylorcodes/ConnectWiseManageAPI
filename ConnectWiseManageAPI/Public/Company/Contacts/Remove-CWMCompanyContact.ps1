<#
.SYNOPSIS
    Deletes a contact.

.DESCRIPTION
    Deletes a contact from ConnectWise Manage. Calls DELETE /company/contacts/{id}.

.PARAMETER id
    The id of the contact to delete.
    Alias: contactId

.EXAMPLE
    Remove-CWMCompanyContact -id 5

    Deletes contact 5.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyContact {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    [Alias('Remove-CWMContact')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$id
    )

    $Endpoint = "/company/contacts/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}