<#
.SYNOPSIS
    Creates an opportunity.

.DESCRIPTION
    Creates an opportunity in ConnectWise Manage. Calls POST /sales/opportunities; only the parameters you
    pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER name
    Name. Max length 100. Required by the API.

.PARAMETER expectedCloseDate
    Expected close date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.
    Required on updates.

.PARAMETER type
    Type reference, for example @{ id = 1 }.

.PARAMETER stage
    Stage reference, for example @{ id = 1 }.

.PARAMETER status
    Status reference, for example @{ id = 1 }.

.PARAMETER priority
    Priority reference, for example @{ id = 1 }.

.PARAMETER notes
    Notes.

.PARAMETER probability
    Probability reference, for example @{ id = 1 }.

.PARAMETER source
    Source. Max length 50.

.PARAMETER rating
    Rating reference, for example @{ id = 1 }.

.PARAMETER campaign
    Campaign reference, for example @{ id = 1 }.

.PARAMETER primarySalesRep
    Primary sales rep reference, for example @{ id = 1 }. Required by the API.

.PARAMETER secondarySalesRep
    Secondary sales rep reference, for example @{ id = 1 }.

.PARAMETER locationId
    Location id. An integer. Required on updates.

.PARAMETER businessUnitId
    Business unit id. An integer. Required on updates.

.PARAMETER company
    Company reference, for example @{ id = 250 }. Required by the API.

.PARAMETER contact
    Contact reference, for example @{ id = 500 }. Required by the API.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER customerPO
    Customer PO. Max length 25.

.PARAMETER pipelineChangeDate
    Pipeline change date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER dateBecameLead
    Date became lead. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER closedDate
    Closed date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER closedBy
    Closed by reference, for example @{ id = 1 }.

.PARAMETER totalSalesTax
    Total sales tax. A number.

.PARAMETER shipToCompany
    Ship to company reference, for example @{ id = 1 }.

.PARAMETER shipToContact
    Ship to contact reference, for example @{ id = 1 }.

.PARAMETER shipToSite
    Ship to site reference, for example @{ id = 1 }.

.PARAMETER billToCompany
    Bill to company reference, for example @{ id = 1 }.

.PARAMETER billToContact
    Bill to contact reference, for example @{ id = 1 }.

.PARAMETER billToSite
    Bill to site reference, for example @{ id = 1 }.

.PARAMETER billingTerms
    Billing terms reference, for example @{ id = 1 }.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER companyLocationId
    Company location id. An integer.

.PARAMETER technicalContact
    Technical contact reference, for example @{ id = 1 }.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMOpportunity -name 'Firewall refresh' -primarySalesRep @{ id = 10 } -company @{ id = 250 } -contact @{ id = 500 } -expectedCloseDate (ConvertTo-CWMTime (Get-Date).AddDays(30) -Raw)

    Creates an opportunity for company 250, expected to close in 30 days.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMOpportunity {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        [int]$id,
        [Parameter(Mandatory=$true)]
        [string]$name,
        [datetime]$expectedCloseDate,
        [hashtable]$type,
        [hashtable]$stage,
        [hashtable]$status,
        [hashtable]$priority,
        [string]$notes,
        [hashtable]$probability,
        [string]$source,
        [hashtable]$rating,
        [hashtable]$campaign,
        [Parameter(Mandatory=$true)]
        [hashtable]$primarySalesRep,
        [hashtable]$secondarySalesRep,
        [int]$locationId,
        [int]$businessUnitId,
        [Parameter(Mandatory=$true)]
        [hashtable]$company,
        [Parameter(Mandatory=$true)]
        [hashtable]$contact,
        [hashtable]$site,
        [string]$customerPO,
        [datetime]$pipelineChangeDate,
        [datetime]$dateBecameLead,
        [datetime]$closedDate,
        [hashtable]$closedBy,
        [int]$totalSalesTax,
        [hashtable]$shipToCompany,
        [hashtable]$shipToContact,
        [hashtable]$shipToSite,
        [hashtable]$billToCompany,
        [hashtable]$billToContact,
        [hashtable]$billToSite,
        [hashtable]$billingTerms,
        [hashtable]$taxCode,
        [hashtable]$currency,
        [int]$companyLocationId,
        [hashtable]$technicalContact,
        [hashtable]$_info,
        [hashtable]$customFields
    )

    $endpoint = "/sales/opportunities"

    Invoke-CWMNewMaster -Endpoint $endpoint -Arguments $PSBoundParameters
}