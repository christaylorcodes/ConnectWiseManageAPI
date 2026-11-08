<#
.SYNOPSIS
    Creates an agreement adjustment for an agreement.

.DESCRIPTION
    Creates an agreement adjustment in ConnectWise Manage. Calls POST /finance/agreements/{parentId}/adjustments; only the
    parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the agreement to add the agreement adjustment to.
    Alias: agreementId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new record.

.PARAMETER amount
    Amount. A number.

.PARAMETER description
    Description.

.PARAMETER effectiveDate
    Effective date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom field values, for example @(@{ id = 4; value = 'x' }).

.EXAMPLE
    New-CWMAgreementAdjustment -parentId 12 -amount -50 -description 'Loyalty discount' -effectiveDate (ConvertTo-CWMTime (Get-Date) -Raw)

    Adds a 50.00 reduction to agreement 12, effective now.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMAgreementAdjustment {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [int]$id,
        [double]$amount,
        [string]$description,
        [string]$effectiveDate,
        [hashtable]$_info,
        [array]$customFields
    )

    $Endpoint = "/finance/agreements/$($parentId)/adjustments"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
