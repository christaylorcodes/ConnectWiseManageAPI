<#
.SYNOPSIS
    Creates a product adjustment.

.DESCRIPTION
    Creates a product adjustment in ConnectWise Manage. Calls POST /procurement/adjustments; only the
    parameters you pass are sent in the request body.

.PARAMETER identifier
    Identifier. Max length 50. Required by the API.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER reason
    Reason. Max length 100.

.PARAMETER notes
    Notes.

.PARAMETER adjustmentDetails
    Adjustment details. An array of hashtables with the properties of the API's AdjustmentDetail object.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMProductAdjustment -identifier 'Q3 stock count' -type @{ id = 1 } -reason 'Cycle count'

    Creates a product adjustment of adjustment type 1.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMProductAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,50)]
        [string]$identifier,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [ValidateLength(1,100)]
        [string]$reason,
        [string]$notes,
        [hashtable]$adjustmentDetails,
        [hashtable]$_info
    )

    $Endpoint = '/procurement/adjustments'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
