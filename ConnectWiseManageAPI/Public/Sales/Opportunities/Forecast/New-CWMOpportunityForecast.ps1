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