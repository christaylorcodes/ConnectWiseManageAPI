<#
.SYNOPSIS
    Creates a contact.

.DESCRIPTION
    Creates a contact in ConnectWise Manage. Calls POST /company/contacts; only the parameters you pass are
    sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER firstName
    First name.

.PARAMETER lastName
    Last name.

.PARAMETER types
    Types. An array of references, for example @(@{ id = 1 }).

.PARAMETER company
    Company reference, for example @{ id = 250 }.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER addressLine1
    Address line 1.

.PARAMETER addressLine2
    Address line 2.

.PARAMETER city
    City.

.PARAMETER state
    State.

.PARAMETER zip
    Zip.

.PARAMETER country
    Country reference, for example @{ id = 1 }.

.PARAMETER relationship
    Relationship reference, for example @{ id = 1 }.

.PARAMETER department
    Department reference, for example @{ id = 1 }.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER defaultMergeContactId
    Default merge contact id. An integer.

.PARAMETER securityIdentifier
    Security identifier.

.PARAMETER managerContact
    Manager contact reference, for example @{ id = 1 }.
    Alias: managerContactId

.PARAMETER assistantContact
    Assistant contact reference, for example @{ id = 1 }.
    Alias: assistantContactId

.PARAMETER title
    Title.

.PARAMETER school
    School.

.PARAMETER nickName
    Nick name.

.PARAMETER marriedFlag
    Married flag. $true or $false.

.PARAMETER childrenFlag
    Children flag. $true or $false.

.PARAMETER significantOther
    Significant other.

.PARAMETER portalPassword
    Portal password.

.PARAMETER portalSecurityLevel
    Portal security level. An integer.

.PARAMETER disablePortalLoginFlag
    Disable portal login flag. $true or $false.

.PARAMETER unsubscribeFlag
    Unsubscribe flag. $true or $false.

.PARAMETER gender
    Gender. One of: Female, Male.

.PARAMETER birthDay
    Birth day.

.PARAMETER anniversary
    Anniversary.

.PARAMETER presence
    Presence. One of: NoAgent, Online, DoNotDisturb, Away, Offline.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER facebookUrl
    Facebook URL.

.PARAMETER twitterUrl
    Twitter URL.

.PARAMETER linkedInUrl
    LinkedIn URL.

.PARAMETER defaultBillingFlag
    Default billing flag. $true or $false.

.PARAMETER defaultFlag
    Default flag. $true or $false.

.PARAMETER communicationItems
    Communication items. An array of hashtables with the properties of the API's ContactCommunicationItem
    object.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMCompanyContact -firstName 'Ann' -lastName 'Smith' -company @{ id = 250 } -title 'Office Manager'

    Creates contact Ann Smith at company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyContact {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    [Alias('New-CWMContact')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [ValidateLength(1, 30)]
        [string]$firstName,
        [ValidateLength(1, 30)]
        [string]$lastName,
        [hashtable[]]$types,
        [hashtable]$company,
        [hashtable]$site,
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
        [ValidateLength(1, 50)]
        [string]$country,
        [hashtable]$relationship,
        [hashtable]$department,
        [bool]$inactiveFlag,
        [int]$defaultMergeContactId,
        [ValidateLength(1, 184)]
        [string]$securityIdentifier,
        # ContactReference: @{ id = N }. An int is accepted too.
        [Alias('managerContactId')]
        [object]$managerContact,
        [Alias('assistantContactId')]
        [object]$assistantContact,
        [ValidateLength(1, 100)]
        [string]$title,
        [ValidateLength(1, 50)]
        [string]$school,
        [ValidateLength(1, 30)]
        [string]$nickName,
        [bool]$marriedFlag,
        [bool]$childrenFlag,
        [ValidateLength(1, 30)]
        [string]$significantOther,
        # ValidateLength only works on strings, so the 1-15 character limit is checked here
        [ValidateScript({ $_.Length -ge 1 -and $_.Length -le 15 })]
        [SecureString]$portalPassword,
        [int]$portalSecurityLevel,
        [bool]$disablePortalLoginFlag,
        [bool]$unsubscribeFlag,
        [validateset('Male', 'Female')]
        [string]$gender,
        [string]$birthDay,
        [string]$anniversary,
        [validateset('Online', 'DoNotDisturb', 'Away', 'Offline', 'NoAgent')]
        [string]$presence,
        [GUID]$mobileGuid,
        [string]$facebookUrl,
        [string]$twitterUrl,
        [string]$linkedInUrl,
        [bool]$defaultBillingFlag,
        [bool]$defaultFlag,
        [hashtable[]]$communicationItems,
        [hashtable]$_info,
        [hashtable[]]$customFields
    )

    # Work on a copy so $PSBoundParameters is never modified
    $Arguments = @{}
    foreach ($Key in $PSBoundParameters.Keys) { $Arguments[$Key] = $PSBoundParameters[$Key] }

    # -managerContactId / -assistantContactId (old int parameters) become references: 5 -> @{ id = 5 }
    foreach ($Name in 'managerContact', 'assistantContact') {
        if ($Arguments.ContainsKey($Name) -and ($Arguments[$Name] -is [ValueType] -or $Arguments[$Name] -is [string])) {
            $Arguments[$Name] = @{ id = [int]$Arguments[$Name] }
        }
    }

    # A SecureString serializes as {"Length":N}, so the API gets the plain text. It is unwrapped only here,
    # just before the body is built, and the unmanaged BSTR copy is zeroed and freed straight away.
    if ($portalPassword) {
        $Bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($portalPassword)
        try { $Arguments.portalPassword = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($Bstr) }
        finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($Bstr) }
    }

    $Endpoint = '/company/contacts'
    Invoke-CWMNewMaster -Arguments $Arguments -Endpoint $Endpoint
}
