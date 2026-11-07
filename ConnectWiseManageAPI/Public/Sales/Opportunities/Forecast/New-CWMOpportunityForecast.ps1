<#
.SYNOPSIS
    Creates the forecast of an opportunity.

.DESCRIPTION
    Creates a forecast on an opportunity in ConnectWise Manage. Calls POST
    /sales/opportunities/{parentId}/forecast; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the opportunity to add the forecast to.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER forecastItems
    Forecast items. An array of hashtables with the properties of the API's ForecastItem object.

.PARAMETER productRevenue
    Product revenue reference, for example @{ id = 1 }.

.PARAMETER serviceRevenue
    Service revenue reference, for example @{ id = 1 }.

.PARAMETER agreementRevenue
    Agreement revenue reference, for example @{ id = 1 }.

.PARAMETER timeRevenue
    Time revenue reference, for example @{ id = 1 }.

.PARAMETER expenseRevenue
    Expense revenue reference, for example @{ id = 1 }.

.PARAMETER forecastRevenueTotals
    Forecast revenue totals reference, for example @{ id = 1 }.

.PARAMETER inclusiveRevenueTotals
    Inclusive revenue totals reference, for example @{ id = 1 }.

.PARAMETER recurringTotal
    Recurring total. A number.

.PARAMETER wonRevenue
    Won revenue reference, for example @{ id = 1 }.

.PARAMETER lostRevenue
    Lost revenue reference, for example @{ id = 1 }.

.PARAMETER openRevenue
    Open revenue reference, for example @{ id = 1 }.

.PARAMETER otherRevenue1
    Other revenue 1 reference, for example @{ id = 1 }.

.PARAMETER otherRevenue2
    Other revenue 2 reference, for example @{ id = 1 }.

.PARAMETER salesTaxRevenue
    Sales tax revenue. A number.

.PARAMETER forecastTotalWithTaxes
    Forecast total with taxes. A number.

.PARAMETER expectedProbability
    Expected probability. An integer.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER billingTerms
    Billing terms reference, for example @{ id = 1 }.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMOpportunityForecast -parentId 75 -forecastItems @(@{ forecastDescription = 'Firewall'; opportunity = @{ id = 75 }; status = @{ id = 1 }; forecastType = 'Product'; revenue = 2500 })

    Adds a product forecast item with 2500 revenue to opportunity 75.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMOpportunityForecast {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentId,
        [int]$id = 0,
        [array]$forecastItems,
        [hashtable]$productRevenue,
        [hashtable]$serviceRevenue,
        [hashtable]$agreementRevenue,
        [hashtable]$timeRevenue,
        [hashtable]$expenseRevenue,
        [hashtable]$forecastRevenueTotals,
        [hashtable]$inclusiveRevenueTotals,
        [decimal]$recurringTotal = 0,
        [hashtable]$wonRevenue,
        [hashtable]$lostRevenue,
        [hashtable]$openRevenue,
        [hashtable]$otherRevenue1,
        [hashtable]$otherRevenue2,
        [decimal]$salesTaxRevenue = 0,
        [decimal]$forecastTotalWithTaxes = 0,
        [decimal]$expectedProbability = 0,
        [hashtable]$taxCode,
        [hashtable]$billingTerms,
        [hashtable]$currency,
        [hashtable]$_info
    )

    $endpoint = "/sales/opportunities/$parentId/forecast"

    Invoke-CWMNewMaster -Arguments $PSBoundParameters -Endpoint $endpoint
}