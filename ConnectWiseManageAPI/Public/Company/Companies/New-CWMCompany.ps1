function New-CWMCompany {
    # 2021.2
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 25)]
        [string]$identifier,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 50)]
        [string]$name,
        [hashtable]$status,
        [ValidateLength(1, 50)]
        [string]$addressLine1,
        [ValidateLength(1, 50)]
        [string]$addressLine2,
        [ValidateLength(1, 50)]
        [string]$city,
        [ValidateLength(1, 50)]
        [string]$state,
        [ValidateLength(1, 12)]
        [string]$zip,
        [hashtable]$country,
        [ValidateLength(1, 30)]
        [string]$phoneNumber,
        [ValidateLength(1, 30)]
        [string]$faxNumber,
        [ValidateLength(1, 255)]
        [string]$website,
        [hashtable]$territory,
        [hashtable]$market,
        [string]$accountNumber,
        [hashtable]$defaultContact,
        [string]$dateAcquired,
        [hashtable]$sicCode,
        [hashtable]$parentCompany,
        [double]$annualRevenue,
        [int]$numberOfEmployees,
        [int]$yearEstablished,
        [int]$revenueYear,
        [hashtable]$ownershipType,
        [hashtable]$timeZoneSetup,
        [ValidateLength(1, 50)]
        [string]$leadSource,
        [boolean]$leadFlag,
        [boolean]$unsubscribeFlag,
        [hashtable]$calendar,
        [ValidateLength(1, 50)]
        [string]$userDefinedField1,
        [ValidateLength(1, 50)]
        [string]$userDefinedField2,
        [ValidateLength(1, 50)]
        [string]$userDefinedField3,
        [ValidateLength(1, 50)]
        [string]$userDefinedField4,
        [ValidateLength(1, 50)]
        [string]$userDefinedField5,
        [ValidateLength(1, 50)]
        [string]$userDefinedField6,
        [ValidateLength(1, 50)]
        [string]$userDefinedField7,
        [ValidateLength(1, 50)]
        [string]$userDefinedField8,
        [ValidateLength(1, 50)]
        [string]$userDefinedField9,
        [ValidateLength(1, 50)]
        [string]$userDefinedField10,
        [ValidateLength(1, 50)]
        [string]$vendorIdentifier,
        [string]$taxIdentifier,
        [hashtable]$taxCode,
        [hashtable]$billingTerms,
        [hashtable]$invoiceTemplate,
        [hashtable]$pricingSchedule,
        [hashtable]$companyEntityType,
        [hashtable]$billToCompany,
        [hashtable]$billingSite,
        [hashtable]$billingContact,
        [hashtable]$invoiceDeliveryMethod,
        [string]$invoiceToEmailAddress,
        [string]$invoiceCCEmailAddress,
        [boolean]$deletedFlag,
        [string]$dateDeleted,
        [string]$deletedBy,
        [string]$mobileGuid,
        [string]$facebookUrl,
        [string]$twitterUrl,
        [string]$linkedInUrl,
        [hashtable]$currency,
        [hashtable]$territoryManager,
        [string]$resellerIdentifier,
        [boolean]$isVendorFlag,
        [array]$types,
        [hashtable]$site,
        [array]$integratorTags,
        [hashtable]$_info,
        [hashtable]$customFields
    )

    $Endpoint = '/company/companies'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
