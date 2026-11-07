<#
.SYNOPSIS
    Updates a picking and shipping detail of a product in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing product picking and shipping detail.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /procurement/products/{parentId}/pickingShippingDetails/{id}

.PARAMETER parentId
    The ID of the product.
    Alias: productId

.PARAMETER id
    The ID of the picking and shipping detail to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'pickedQuantity'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMProductPickingShippingDetail -parentId 12 -id 77 -Operation replace -Path 'pickedQuantity' -Value 2

    Sets the picked quantity of detail 77 of product 12 to 2.

.EXAMPLE
    Update-CWMProductPickingShippingDetail 12 77 replace pickedQuantity 2

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMProductPickingShippingDetail -parentId 12 -id 77 -PatchOperations @(
        @{ op = 'replace'; path = 'pickedQuantity'; value = 2 }
        @{ op = 'replace'; path = 'shippedQuantity'; value = 2 }
    )

    Changes the picked and shipped quantity of detail 77 in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated product picking and shipping detail.
#>
function Update-CWMProductPickingShippingDetail {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('productId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
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

    $Endpoint = "/procurement/products/$($parentId)/pickingShippingDetails/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
