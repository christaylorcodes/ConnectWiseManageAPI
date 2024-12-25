function New-CWMOpportunity {
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