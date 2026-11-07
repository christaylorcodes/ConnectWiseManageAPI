<#
.SYNOPSIS
    Creates an item for a service board.

.DESCRIPTION
    Creates an item for a service board in ConnectWise Manage. Calls POST /service/boards/{parentId}/items;
    only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the service board to add the item to.
    Alias: boardId

.PARAMETER name
    Name. Max length 50. Required by the API.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.EXAMPLE
    New-CWMBoardItem -parentId 1 -name 'Hardware'

    Adds an item named Hardware to service board 1.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMBoardItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('boardId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [string]$name,
        [bool]$inactiveFlag
    )

    $Endpoint = "/service/boards/$($parentId)/items"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}