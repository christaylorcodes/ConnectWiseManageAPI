<#
.SYNOPSIS
    Updates a purchase order in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing purchase order.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /procurement/purchaseorders/{id}

.PARAMETER id
    The ID of the purchase order to update.
    Alias: catalogId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'trackingNumber'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMPurchaseOrder -id 600 -Operation replace -Path 'trackingNumber' -Value '1Z999AA10123456784'

    Sets the tracking number of purchase order 600.

.EXAMPLE
    Update-CWMPurchaseOrder 600 replace trackingNumber '1Z999AA10123456784'

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMPurchaseOrder -id 600 -PatchOperations @(
        @{ op = 'replace'; path = 'trackingNumber'; value = '1Z999AA10123456784' }
        @{ op = 'replace'; path = 'status'; value = @{ id = 2 } }
    )

    Sets the tracking number and status of purchase order 600 in one request.

.NOTES
    Endpoint: PATCH /procurement/purchaseorders/{id}

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated purchase order.

.INPUTS
    None. This function does not accept pipeline input.
#>
function Update-CWMPurchaseOrder {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('catalogId')]
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

    $Endpoint = "/procurement/purchaseorders/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
