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
