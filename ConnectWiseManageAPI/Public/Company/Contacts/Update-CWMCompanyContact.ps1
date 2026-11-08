<#
.SYNOPSIS
    Updates a contact in ConnectWise Manage.

.DESCRIPTION
    You can perform one or more of the PATCH operations on a contact.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /company/contacts/{id}

.PARAMETER id
    The ID of the contact you want to update.
    Alias: contactId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'title'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMCompanyContact -id 456 -Operation replace -Path 'title' -Value 'Janitor'

    Replaces the title of contact 456.

.EXAMPLE
    Update-CWMCompanyContact 456 replace title 'Janitor'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMCompanyContact -id 456 -PatchOperations @(
        @{ op = 'replace'; path = 'firstName'; value = 'Jane' }
        @{ op = 'replace'; path = 'title'; value = 'Office Manager' }
    )

    Changes the first name and title of contact 456 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated contact.
#>
function Update-CWMCompanyContact {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    [Alias('Update-CWMContact')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('contactId')]
        [int]$id,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 3, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/company/contacts/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
