<#
.SYNOPSIS
    Creates a forecast item for an opportunity.

.DESCRIPTION
    Creates a forecast item on an opportunity in ConnectWise Manage. Calls POST
    /sales/opportunities/{parentId}/forecast/{id}; only the parameters you pass are sent in the request
    body.

.PARAMETER parentId
    The id of the opportunity to add the forecast item to.
    Alias: opportunityId

.PARAMETER id
    The {id} of the path POST /sales/opportunities/{parentId}/forecast/{id} (forecastId in the spec). It is
    also sent as id in the request body.

.PARAMETER forecastDescription
    Forecast description. Max length 50.

.PARAMETER opportunity
    Opportunity reference, for example @{ id = 75 }. Required by the API.

.PARAMETER quantity
    Quantity. A number.

.PARAMETER status
    Status reference, for example @{ id = 1 }. Required by the API.

.PARAMETER catalogItem
    Catalog item reference, for example @{ id = 1 }.

.PARAMETER productDescription
    Product description.

.PARAMETER productClass
    Product class.

.PARAMETER revenue
    Revenue. A number.

.PARAMETER cost
    Cost. A number.

.PARAMETER margin
    Margin. A number.

.PARAMETER percentage
    Percentage. An integer.

.PARAMETER includeFlag
    Include flag. $true or $false.

.PARAMETER quoteWerksDocNo
    Quote werks doc no. Max length 20.

.PARAMETER quoteWerksDocName
    Quote werks doc name. Max length 255.

.PARAMETER quoteWerksQuantity
    Quote werks quantity. An integer.

.PARAMETER forecastType
    Forecast type. One of: Other1, Other2, Agreement, Product, Service. Required by the API.

.PARAMETER linkFlag
    Link flag. $true or $false.

.PARAMETER recurringRevenue
    Recurring revenue. A number.

.PARAMETER recurringCost
    Recurring cost. A number.

.PARAMETER recurringDateStart
    Recurring date start. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER recurringDateEnd
    Recurring date end. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER billCycle
    Bill cycle reference, for example @{ id = 1 }.

.PARAMETER cycleBasis
    Cycle basis.

.PARAMETER cycles
    Cycles. An integer.

.PARAMETER recurringFlag
    Recurring flag. $true or $false.

.PARAMETER sequenceNumber
    Sequence number. A number.

.PARAMETER subNumber
    Sub number. An integer.

.PARAMETER taxableFlag
    Taxable flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.
    Alias: info

.EXAMPLE
    New-CWMOpportunityForecastItem -parentId 75 -id 1 -opportunity @{ id = 75 } -status @{ id = 1 } -forecastType 'Service' -revenue 1200

    Creates a service forecast item with 1200 revenue on opportunity 75.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMOpportunityForecastItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('opportunityId')]
        [int]$parentId,
        [Parameter(Mandatory = $true)]
        [int]$id,
        [string]$forecastDescription,
        [Parameter(Mandatory=$true)]
        [hashtable]$opportunity,
        [int]$quantity,
        [Parameter(Mandatory=$true)]
        [hashtable]$status,
        [hashtable]$catalogItem,
        [string]$productDescription,
        [string]$productClass,
        [decimal]$revenue,
        [decimal]$cost,
        [decimal]$margin,
        [decimal]$percentage,
        [bool]$includeFlag,
        [string]$quoteWerksDocNo,
        [string]$quoteWerksDocName,
        [int]$quoteWerksQuantity,
        [Parameter(Mandatory=$true)]
        [string]$forecastType,
        [bool]$linkFlag,
        [decimal]$recurringRevenue,
        [decimal]$recurringCost,
        [string]$recurringDateStart,
        [string]$recurringDateEnd,
        [hashtable]$billCycle,
        [string]$cycleBasis,
        [int]$cycles,
        [bool]$recurringFlag,
        [int]$sequenceNumber,
        [int]$subNumber,
        [bool]$taxableFlag,
        [Alias('info')]
        [hashtable]$_info
    )

    $Endpoint = "/sales/opportunities/$($parentId)/forecast/$($id)"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}