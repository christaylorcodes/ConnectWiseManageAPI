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

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER addressLine2
    Address line 2. At least one address field is required -- addressLine1, addressLine2, city, state, zip
    and/or country. Max length 50.

.PARAMETER country
    Country reference, for example @{ id = 1 }.

.PARAMETER faxNumber
    Fax number. Max length 30.

.PARAMETER territory
    Territory reference, for example @{ id = 1 }.

.PARAMETER market
    Market reference, for example @{ id = 1 }.

.PARAMETER accountNumber
    Account number.

.PARAMETER defaultContact
    Default contact reference, for example @{ id = 1 }.

.PARAMETER dateAcquired
    Date acquired. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER sicCode
    SIC code reference, for example @{ id = 1 }.

.PARAMETER parentCompany
    Parent company reference, for example @{ id = 1 }.

.PARAMETER annualRevenue
    Annual revenue. A number.

.PARAMETER numberOfEmployees
    Number of employees. An integer.

.PARAMETER yearEstablished
    Year established. An integer.

.PARAMETER revenueYear
    Revenue year. An integer.

.PARAMETER ownershipType
    Ownership type reference, for example @{ id = 1 }.

.PARAMETER timeZoneSetup
    Time zone setup reference, for example @{ id = 1 }.

.PARAMETER leadSource
    Lead source. Max length 50.

.PARAMETER leadFlag
    Lead flag. $true or $false.

.PARAMETER unsubscribeFlag
    Unsubscribe flag. $true or $false.

.PARAMETER calendar
    Calendar reference, for example @{ id = 1 }.

.PARAMETER userDefinedField1
    User defined field 1. Max length 50.

.PARAMETER userDefinedField2
    User defined field 2. Max length 50.

.PARAMETER userDefinedField3
    User defined field 3. Max length 50.

.PARAMETER userDefinedField4
    User defined field 4. Max length 50.

.PARAMETER userDefinedField5
    User defined field 5. Max length 50.

.PARAMETER userDefinedField6
    User defined field 6. Max length 50.

.PARAMETER userDefinedField7
    User defined field 7. Max length 50.

.PARAMETER userDefinedField8
    User defined field 8. Max length 50.

.PARAMETER userDefinedField9
    User defined field 9. Max length 50.

.PARAMETER userDefinedField10
    User defined field 10. Max length 50.

.PARAMETER vendorIdentifier
    Vendor identifier.

.PARAMETER taxIdentifier
    Tax identifier.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER billingTerms
    Billing terms reference, for example @{ id = 1 }.

.PARAMETER invoiceTemplate
    Invoice template reference, for example @{ id = 1 }.

.PARAMETER pricingSchedule
    Pricing schedule reference, for example @{ id = 1 }.

.PARAMETER companyEntityType
    Company entity type reference, for example @{ id = 1 }.

.PARAMETER billToCompany
    Bill to company reference, for example @{ id = 1 }.

.PARAMETER billingSite
    Billing site reference, for example @{ id = 1 }.

.PARAMETER billingContact
    Billing contact reference, for example @{ id = 1 }.

.PARAMETER invoiceDeliveryMethod
    Invoice delivery method reference, for example @{ id = 1 }.

.PARAMETER invoiceToEmailAddress
    Invoice to email address.

.PARAMETER invoiceCCEmailAddress
    Invoice CC email address.

.PARAMETER deletedFlag
    Deleted flag. $true or $false.

.PARAMETER dateDeleted
    Date deleted. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER deletedBy
    Deleted by.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER facebookUrl
    Facebook URL.

.PARAMETER twitterUrl
    Twitter URL.

.PARAMETER linkedInUrl
    LinkedIn URL.

.PARAMETER currency
    Currency reference, for example @{ id = 1 }.

.PARAMETER territoryManager
    Territory manager reference, for example @{ id = 1 }.

.PARAMETER resellerIdentifier
    Reseller identifier.

.PARAMETER isVendorFlag
    Is vendor flag. $true or $false.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER integratorTags
    Integrator tags. An array of strings.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

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
        [hashtable[]]$customFields
    )

    $Endpoint = '/company/companies'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
