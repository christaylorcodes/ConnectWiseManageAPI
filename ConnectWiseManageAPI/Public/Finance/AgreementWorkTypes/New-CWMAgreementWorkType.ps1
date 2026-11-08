<#
.SYNOPSIS
    Creates an agreement work type rate for an agreement.

.DESCRIPTION
    Creates an agreement work type rate in ConnectWise Manage. Calls POST /finance/agreements/{parentId}/worktypes; only the
    parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the agreement to add the agreement work type rate to.
    Alias: agreementId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new record.

.PARAMETER workType
    Work type reference, for example @{ id = 1 }.

.PARAMETER location
    Location reference, for example @{ id = 1 }.

.PARAMETER locationId
    Location id. A whole number.

.PARAMETER rateType
    Rate type. One of: AdjAmount, Custom, Multiplier. Required by the API.

.PARAMETER billTime
    Bill time. One of: Billable, DoNotBill, NoCharge, NoDefault. Required by the API.

.PARAMETER rate
    Rate. A number.

.PARAMETER hoursMax
    Hours max. A number.

.PARAMETER hoursMin
    Hours min. A number.

.PARAMETER roundBillHours
    Round bill hours. A number.

.PARAMETER overageRate
    Overage rate. A number.

.PARAMETER overageRateType
    Overage rate type. One of: AdjAmount, Custom, Multiplier.

.PARAMETER agreementLimit
    Agreement limit. A number.

.PARAMETER site
    Site reference, for example @{ id = 1 }.

.PARAMETER effectiveDate
    Effective date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER endingDate
    Ending date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER agreement
    Agreement reference, for example @{ id = 1 }.

.PARAMETER company
    Company reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMAgreementWorkType -parentId 12 -workType @{ id = 7 } -rateType Multiplier -rate 1.5 -billTime Billable

    Bills work type 7 at 1.5 times the standard rate on agreement 12.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMAgreementWorkType {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('agreementId')]
        [int]$parentId,
        [int]$id,
        $workType,
        $location,
        [int]$locationId,
        [Parameter(Mandatory = $true)]
        [ValidateSet('AdjAmount', 'Custom', 'Multiplier')]
        [string]$rateType,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Billable', 'DoNotBill', 'NoCharge', 'NoDefault')]
        [string]$billTime,
        [double]$rate,
        [double]$hoursMax,
        [double]$hoursMin,
        [double]$roundBillHours,
        [double]$overageRate,
        [ValidateSet('AdjAmount', 'Custom', 'Multiplier')]
        [string]$overageRateType,
        [double]$agreementLimit,
        $site,
        [string]$effectiveDate,
        [string]$endingDate,
        $agreement,
        $company,
        [hashtable]$_info
    )

    $Endpoint = "/finance/agreements/$($parentId)/worktypes"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
