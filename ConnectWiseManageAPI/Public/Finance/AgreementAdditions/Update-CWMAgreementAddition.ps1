<#
.SYNOPSIS
    Updates an addition to an agreement in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing agreement addition.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /finance/agreements/{parentId}/additions/{id}

.PARAMETER parentId
    The ID of the agreement.
    Alias: agreementId

.PARAMETER id
    The ID of the addition to update.
    Alias: additionId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'quantity'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMAgreementAddition -parentId 300 -id 25 -Operation replace -Path 'quantity' -Value 10

    Sets the quantity of addition 25 of agreement 300 to 10.

.EXAMPLE
    Update-CWMAgreementAddition 300 25 replace quantity 10

    The same change, using positional parameters.

.EXAMPLE
    $

    U

.EXAMPLE
    C

    h

.EXAMPLE
    Update-CWMAgreementAddition -parentId 300 -id 25 -PatchOperations @(
        @{ op = 'replace'; path = 'quantity'; value = 10 }
        @{ op = 'replace'; path = 'unitPrice'; value = 12.5 }
    )

    Changes the quantity and unit price of addition 25 in one request.

.NOTES
    Endpoint: PATCH /finance/agreements/{parentId}/additions/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated agreement addition.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMAgreementAddition {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('agreementId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('additionId')]
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

    $Endpoint = "/finance/agreements/$($parentId)/additions/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
