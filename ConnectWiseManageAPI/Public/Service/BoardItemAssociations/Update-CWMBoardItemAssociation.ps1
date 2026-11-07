<#
.SYNOPSIS
    Updates the association between a service board item and a type in ConnectWise Manage.

.DESCRIPTION
    Applies JSON Patch operations to an existing service board item association.
    Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

    This function calls the ConnectWise Manage API endpoint: PATCH /service/boards/{parentId}/items/{itemId}/associations/{typeId}

.PARAMETER parentId
    The ID of the service board.
    Alias: boardId

.PARAMETER itemId
    The ID of the board item.
    Alias: id

.PARAMETER typeId
    The ID of the service type of the association to update.

.PARAMETER Operation
    The patch operation to perform: 'add', 'replace' or 'remove'.

.PARAMETER Path
    The property to change, for example 'addAllFlag'.

.PARAMETER Value
    The new value for the property. Required for 'add' and 'replace'; not needed for 'remove'.
    Use -Value $null to set a property to null.

.PARAMETER PatchOperations
    Several patch operations to apply in one request. Each is a hashtable or PSCustomObject with
    op, path and (except for 'remove') value. 'value' is left out of 'remove' operations.

.EXAMPLE
    Update-CWMBoardItemAssociation -parentId 1 -itemId 20 -typeId 30 -Operation replace -Path 'addAllFlag' -Value $true

    Associates all sub types with item 20 and type 30 of board 1.

.EXAMPLE
    Update-CWMBoardItemAssociation 1 20 30 replace addAllFlag $true

    The same change, using positional parameters.

.EXAMPLE
    Update-CWMBoardItemAssociation -parentId 1 -itemId 20 -typeId 30 -PatchOperations @(
        @{ op = 'replace'; path = 'addAllFlag'; value = $true }
    )

    Sends the same change with -PatchOperations. Add more operations to the array to change several properties in one request.

.LINK
    https://developer.connectwise.com/manage/rest

.OUTPUTS
    PSCustomObject
    Returns the updated service board item association.
#>
function Update-CWMBoardItemAssociation {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium', DefaultParameterSetName = 'Single')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias('boardId')]
        [int]$parentId,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias('id')]
        [int]$itemId,
        [Parameter(Mandatory = $true, Position = 2)]
        [int]$typeId,
        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Single')]
        [validateset('add', 'replace', 'remove')]
        [string]$Operation,
        [Parameter(Mandatory = $true, Position = 4, ParameterSetName = 'Single')]
        [string]$Path,
        [Parameter(Position = 5, ParameterSetName = 'Single')]
        $Value,
        [Parameter(Mandatory = $true, ParameterSetName = 'Bulk')]
        [ValidateNotNullOrEmpty()]
        [object[]]$PatchOperations
    )

    $Endpoint = "/service/boards/$parentId/items/$itemId/associations/$typeId"
    Invoke-CWMUpdateMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
