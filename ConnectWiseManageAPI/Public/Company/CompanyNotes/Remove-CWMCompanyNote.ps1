<#
.SYNOPSIS
    Deletes a note of a company.

.DESCRIPTION
    Deletes a note of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/notes/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: companyId

.PARAMETER id
    The id of the note to delete.
    Alias: noteId

.EXAMPLE
    Remove-CWMCompanyNote -parentId 12 -id 5

    Deletes note 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [Alias('noteId')]
        [int]$id
    )

    $Endpoint = "/company/companies/$($parentId)/notes/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}