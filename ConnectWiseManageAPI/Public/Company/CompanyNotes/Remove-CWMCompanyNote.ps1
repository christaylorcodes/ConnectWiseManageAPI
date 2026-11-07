<#
.SYNOPSIS
    Deletes a note of a company.

.DESCRIPTION
    Deletes a note of a company from ConnectWise Manage. Calls DELETE
    /company/companies/{parentId}/notes/{id}.

.PARAMETER parentId
    The id of the company.
    Alias: CompanyID

.PARAMETER NoteId
    The id of the note to delete.

.EXAMPLE
    Remove-CWMCompanyNote -parentId 12 -NoteId 5

    Deletes note 5 of company 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function Remove-CWMCompanyNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('CompanyID')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$NoteId
    )

    $Endpoint = "/company/companies/$ParentID/notes/$NoteId"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}