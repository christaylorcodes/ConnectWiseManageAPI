<#
.SYNOPSIS
    Creates an agreement work role rate for an agreement.

.DESCRIPTION
    Creates an agreement work role rate in ConnectWise Manage. Calls POST /finance/agreements/{parentId}/workroles; only the
    parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the agreement to add the agreement work role rate to.
    Alias: agreementId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new record.

.PARAMETER workRole
    Work role reference, for example @{ id = 1 }.

.PARAMETER locationId
    Location id. A whole number.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER rateType
    Rate type. One of: AdjAmount, Custom, Multiplier. Required by the API.

.PARAMETER rate
    Rate. A number.

.PARAMETER limitTo
    Limit to. A number.

.PARAMETER effectiveDate
    Effective date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER endingDate
    Ending date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER agreement
    Agreement reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMAgreementWorkRole -parentId 12 -workRole @{ id = 3 } -rateType Custom -rate 95

    Bills work role 3 at a custom rate of 95 on agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMAgreementWorkRole {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [int]$id,
        $workRole,
        [int]$locationId,
        $location,
        [Parameter(Mandatory = $true)]
        [ValidateSet('AdjAmount', 'Custom', 'Multiplier')]
        [string]$rateType,
        [float]$rate,
        [float]$limitTo,
        [string]$effectiveDate,
        [string]$endingDate,
        $agreement,
        [hashtable]$_info
    )

    $Endpoint = "/finance/agreements/$($parentId)/workroles"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
