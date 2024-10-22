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
        [bool]$billSeperateFlag,
        [string]$mobileGuid,
        [hashtable]$calendar,
        [hashtable]$timeZone,
        [hashtable]$customFields
    )

    $Endpoint = "/company/companies/$($parentId)/sites"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}