<#
.SYNOPSIS
    Updates an opportunity in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing opportunity.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /sales/opportunities/{id}

.PARAMETER id
    The ID of the opportunity to update.
    Alias: opportunityID

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'name'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMOpportunity -id 900 -Operation replace -Path 'name' -Value 'Firewall refresh'

    Renames opportunity 900.

.EXAMPLE
    Update-CWMOpportunity 900 replace name 'Firewall refresh'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMOpportunity -id 900 -PatchOperations @(
        @{ op = 'replace'; path = 'name'; value = 'Firewall refresh' }
        @{ op = 'replace'; path = 'status'; value = @{ id = 2 } }
    )

    Changes the name and status of opportunity 900 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated opportunity.
#>
function Update-CWMOpportunity {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('opportunityID')]
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

    $Endpoint = "/sales/opportunities/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
