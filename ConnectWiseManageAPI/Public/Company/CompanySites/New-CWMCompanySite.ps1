<#
.SYNOPSIS
    Creates a site for a company.

.DESCRIPTION
    Creates a site for a company in ConnectWise Manage. Calls POST /company/companies/{parentId}/sites; only
    the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the company to add the site to.
    Alias: companyId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER name
    Name. Max length 156. Required by the API.

.PARAMETER addressLine1
    Address line 1. Max length 50.

.PARAMETER addressLine2
    Address line 2. Max length 50.

.PARAMETER city
    City. Max length 50.

.PARAMETER stateReference
    State reference reference, for example @{ id = 1 }.

.PARAMETER zip
    Zip. Max length 12.

.PARAMETER country
    Country reference, for example @{ id = 1 }.

.PARAMETER phoneNumber
    Phone number. Max length 30.

.PARAMETER phoneNumberExt
    Phone number ext. Max length 30.

.PARAMETER faxNumber
    Fax number. Max length 30.

.PARAMETER taxCode
    Tax code reference, for example @{ id = 1 }.

.PARAMETER entityType
    Entity type reference, for example @{ id = 1 }.

.PARAMETER expenseReimbursement
    Expense reimbursement. A number.

.PARAMETER primaryAddressFlag
    Primary address flag. $true or $false.

.PARAMETER defaultShippingFlag
    Default shipping flag. $true or $false.

.PARAMETER defaultBillingFlag
    Default billing flag. $true or $false.

.PARAMETER defaultMailingFlag
    Default mailing flag. $true or $false.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER billSeparateFlag
    Bill separate flag. $true or $false.
    Alias: billSeperateFlag

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER calendar
    Calendar reference, for example @{ id = 1 }.

.PARAMETER timeZone
    Time zone reference, for example @{ id = 1 }.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMCompanySite -parentId 250 -name 'Branch Office' -addressLine1 '100 Main St' -city 'Tampa' -zip '33602'

    Adds a site named Branch Office to company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanySite {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('companyId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory = $true)]
        [string]$name,
        [string]$addressLine1,
        [string]$addressLine2,
        [string]$city,
        [hashtable]$stateReference,
        [string]$zip,
        [hashtable]$country,
        [string]$phoneNumber,
        [string]$phoneNumberExt,
        [string]$faxNumber,
        [hashtable]$taxCode,
        [hashtable]$entityType,
        [double]$expenseReimbursement,
        [bool]$primaryAddressFlag,
        [bool]$defaultShippingFlag,
        [bool]$defaultBillingFlag,
        [bool]$defaultMailingFlag,
        [bool]$inactiveFlag,
        [Alias('billSeperateFlag')]
        [bool]$billSeparateFlag,
        [string]$mobileGuid,
        [hashtable]$calendar,
        [hashtable]$timeZone,
        [hashtable]$customFields
    )

    $Endpoint = "/company/companies/$($parentId)/sites"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}