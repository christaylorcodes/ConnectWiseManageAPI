<#
.SYNOPSIS
    Updates a communication item (email, phone and so on) of a contact in ConnectWise Manage.

.DESCRIPTION
    Used to update one of the communicationItems of a contact.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/contacts/{parentId}/communications/{id}

.PARAMETER parentId
    The ID of the contact you want to modify.
    Alias: contactId

.PARAMETER id
    The ID of the communication item you want to update.
    Alias: communicationId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'value'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMContactCommunication -parentId 123 -id 9 -Operation replace -Path 'value' -Value 'new@email.com'

    Replaces the value of communication item 9 of contact 123.

.EXAMPLE
    Update-CWMContactCommunication 123 9 replace value 'new@email.com'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMContactCommunication -parentId 123 -id 9 -PatchOperations @(
        @{ op = 'replace'; path = 'value'; value = 'new@email.com' }
        @{ op = 'replace'; path = 'defaultFlag'; value = $true }
    )

    Changes the value and makes it the default in one request.

.NOTES
    Endpoint: PATCH /company/contacts/{parentId}/communications/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated contact communication item.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('contactId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('communicationId')]
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

    $Endpoint = "/company/contacts/$($parentId)/communications/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
