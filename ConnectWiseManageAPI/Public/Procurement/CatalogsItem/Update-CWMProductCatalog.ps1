<#
.SYNOPSIS
    Updates a product catalog item in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing product catalog item.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /procurement/catalog/{id}

.PARAMETER id
    The ID of the catalog item to update (required).
    Alias: catalogId

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The catalog item property to change, for example 'description' or 'price'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMProductCatalog -id 123 -Operation replace -Path 'price' -Value 49.99

    Replaces the price of catalog item 123.

.EXAMPLE
    Update-CWMProductCatalog 123 replace price 49.99

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMProductCatalog -id 123 -PatchOperations @(
        @{ op = 'replace'; path = 'price'; value = 49.99 }
        @{ op = 'replace'; path = 'cost'; value = 30 }
        @{ op = 'replace'; path = 'description'; value = 'Updated description' }
    )

    Changes the price, cost and description of catalog item 123 in one request.

.NOTES
    Endpoint: PATCH /procurement/catalog/{id}

    -PatchOperations implements GitHub issue #53 (several changes in one request), based on PR #82 by mdewart-Centre.

.LINK
    Get-CWMProductCatalog

.LINK
    New-CWMProductCatalog

.LINK
    https://github.com/christaylorcodes/ConnectWiseManageAPI/issues/53

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated catalog item.
#>
function Update-CWMProductCatalog {
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

    $Endpoint = "/procurement/catalog/$($id)"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
