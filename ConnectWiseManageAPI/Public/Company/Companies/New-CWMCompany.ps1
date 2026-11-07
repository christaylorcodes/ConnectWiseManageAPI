<#
.SYNOPSIS
    Creates a new company record in ConnectWise Manage.

.DESCRIPTION
    Creates a new company with specified properties. Only identifier and name are required.
    All other fields are optional and will use system defaults if not specified.

    This function calls the ConnectWise Manage API endpoint: POST /company/companies

.PARAMETER identifier
    The company identifier/code (required). Maximum 25 characters.
    Must be unique across all companies.

.PARAMETER name
    The company name (required). Maximum 50 characters.

.PARAMETER status
    Hashtable with status reference. Format: @{ id = 1 }

.PARAMETER addressLine1
    First line of company address. Maximum 50 characters.

.PARAMETER city
    City name. Maximum 50 characters.

.PARAMETER state
    State/province. Maximum 50 characters.

.PARAMETER zip
    Postal/ZIP code. Maximum 12 characters.

.PARAMETER phoneNumber
    Primary phone number. Maximum 30 characters.

.PARAMETER website
    Company website URL. Maximum 255 characters.

.PARAMETER types
    Array of company type hashtables. Example: @( @{id=1}, @{id=2} )
    Common types: Customer, Vendor, Partner, Prospect

.EXAMPLE
    # Minimal company creation
    $company = @{
        identifier = "ACME"
        name = "Acme Corporation"
    }
    New-CWMCompany @company

    Creates a basic company with required fields only.

.EXAMPLE
    # Company with address
    $companyParams = @{
        identifier = "ACME"
        name = "Acme Corporation"
        addressLine1 = "123 Main St"
        city = "Seattle"
        state = "WA"
        zip = "98101"
        phoneNumber = "206-555-1234"
        website = "https://acme.com"
    }
    New-CWMCompany @companyParams

    Creates a company with full address information.

.EXAMPLE
    # Company with type
    $companyParams = @{
        identifier = "NEWCUST"
        name = "New Customer LLC"
        types = @( @{id=1} )  # Customer type
        status = @{ id = 1 }  # Active status
    }
    New-CWMCompany @companyParams

    Creates a company with specific type and status.

.NOTES
    Author: Chris Taylor
    Date: 2024-01-01

    Required Fields:
    - identifier (string, max 25 chars, must be unique)
    - name (string, max 50 chars)

    Common Optional Fields:
    - status, types, territory
    - address fields (addressLine1, city, state, zip)
    - phoneNumber, faxNumber, website
    - defaultContact, parentCompany

.LINK
    https://developer.connectwise.com/manage/rest#/Companies

.LINK
    Get-CWMCompany

.LINK
    Update-CWMCompany

.LINK
    Remove-CWMCompany

#>
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
