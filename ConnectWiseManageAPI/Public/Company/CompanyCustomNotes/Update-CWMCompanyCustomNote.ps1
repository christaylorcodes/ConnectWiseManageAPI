<#
.SYNOPSIS
    Updates a custom status note of a company in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing company custom status note.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/customStatusNotes/{id}

.PARAMETER parentId
    The ID of the company.
    Alias: companyId

.PARAMETER id
    The ID of the custom status note to update.
    Alias: noteId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'note'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyCustomNote -parentId 250 -id 7 -Operation replace -Path 'note' -Value 'Customer is on hold'

    Replaces the text of note 7 of company 250.

.EXAMPLE
    Update-CWMCompanyCustomNote 250 7 replace note 'Customer is on hold'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanyCustomNote -parentId 250 -id 7 -PatchOperations @(
        @{ op = 'replace'; path = 'note'; value = 'Customer is on hold' }
        @{ op = 'replace'; path = 'name'; value = 'On hold' }
    )

    Changes the note text and name in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated company custom status note.
#>
function Update-CWMCompanyCustomNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('companyId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('noteId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 4, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/company/companies/$($parentId)/customStatusNotes/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
