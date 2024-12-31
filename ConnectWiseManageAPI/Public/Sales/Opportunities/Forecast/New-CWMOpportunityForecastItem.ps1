function New-CWMOpportunityForecastItem {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory=$true)]
        [int]$parentID,
        [int]$id = 0,
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
        [hashtable]$info
    )

    $endpoint = "/sales/opportunities/$parentId/forecast/$id"

    Invoke-CWMNewMaster -Endpoint $endpoint -Arguments $PSBoundParameters
}