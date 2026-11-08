<#
.SYNOPSIS
    Creates a configuration.

.DESCRIPTION
    Creates a configuration in ConnectWise Manage. Calls POST /company/configurations; only the parameters
    you pass are sent in the request body.

.PARAMETER name
    Name. Max length 100. Required by the API.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER status
    Status reference, for example @{ id = 1 }.

.PARAMETER company
    Company reference, for example @{ id = 250 }. Required by the API.

.PARAMETER contact
    Contact reference, for example @{ id = 500 }.

.PARAMETER site
    Site reference, for example @{ id = 5 }.

.PARAMETER locationId
    Location id. An integer.

.PARAMETER businessUnitId
    Business unit id. An integer.

.PARAMETER deviceIdentifier
    Device identifier. Max length 100.

.PARAMETER serialNumber
    Serial number. Max length 250.

.PARAMETER modelNumber
    Model number. Max length 50.

.PARAMETER tagNumber
    Tag number. Max length 50.

.PARAMETER purchaseDate
    Purchase date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER installationDate
    Installation date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER installedBy
    Installed by reference, for example @{ id = 1 }.

.PARAMETER warrantyExpirationDate
    Warranty expiration date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime
    -Raw.

.PARAMETER vendorNotes
    Vendor notes.

.PARAMETER notes
    Notes.

.PARAMETER macAddress
    MAC address. Max length 25.

.PARAMETER lastLoginName
    Last login name. Max length 100.

.PARAMETER billFlag
    Bill flag. $true or $false.

.PARAMETER backupSuccesses
    Backup successes. An integer.

.PARAMETER backupIncomplete
    Backup incomplete. An integer.

.PARAMETER backupFailed
    Backup failed. An integer.

.PARAMETER backupRestores
    Backup restores. An integer.

.PARAMETER lastBackupDate
    Last backup date. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER backupServerName
    Backup server name. Max length 50.

.PARAMETER backupBillableSpaceGb
    Backup billable space GB. A number.

.PARAMETER backupProtectedDeviceList
    Backup protected device list.

.PARAMETER backupYear
    Backup year. An integer.

.PARAMETER backupMonth
    Backup month. An integer.

.PARAMETER ipAddress
    IP address. Max length 50.

.PARAMETER defaultGateway
    Default gateway. Max length 50.

.PARAMETER osType
    OS type. Max length 250.

.PARAMETER osInfo
    OS info. Max length 250.

.PARAMETER cpuSpeed
    CPU speed. Max length 100.

.PARAMETER ram
    RAM. Max length 25.

.PARAMETER localHardDrives
    Local hard drives.

.PARAMETER parentConfigurationId
    Parent configuration id. An integer.

.PARAMETER vendor
    Vendor reference, for example @{ id = 1 }.

.PARAMETER manufacturer
    Manufacturer reference, for example @{ id = 1 }.

.PARAMETER questions
    Questions. An array of hashtables with the properties of the API's ConfigurationQuestion object.

.PARAMETER activeFlag
    Active flag. $true or $false.

.PARAMETER managementLink
    Management link. Max length 1000.

.PARAMETER remoteLink
    Remote link. Max length 1000.

.PARAMETER sla
    SLA reference, for example @{ id = 1 }.

.PARAMETER mobileGuid
    Mobile GUID.
    Alias: mobilezGuid

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.PARAMETER displayVendorFlag
    Display vendor flag. $true or $false.

.PARAMETER companyLocationId
    Company location id. An integer.

.PARAMETER showRemoteFlag
    Show remote flag. $true or $false.

.PARAMETER showAutomateFlag
    Show automate flag. $true or $false.

.PARAMETER needsRenewalFlag
    Needs renewal flag. $true or $false.

.PARAMETER manufacturerPartNumber
    Manufacturer part number. Max length 50.

.PARAMETER customFields
    Custom fields. An array of custom field values, for example @(@{ id = 4; value = 'Gold' }).

.EXAMPLE
    New-CWMCompanyConfiguration -name 'ACME-DC01' -type @{ id = 1 } -company @{ id = 250 } -serialNumber 'SN12345'

    Creates a configuration of type 1 for company 250.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,100)]
        [string]$name,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [hashtable]$status,
        [Parameter(Mandatory=$true)]
        [hashtable]$company,
        [hashtable]$contact,
        [hashtable]$site,
        [int]$locationId,
        [int]$businessUnitId,
        [ValidateLength(0,100)]
        [string]$deviceIdentifier,
        [ValidateLength(0,250)]
        [string]$serialNumber,
        [ValidateLength(0,50)]
        [string]$modelNumber,
        [ValidateLength(0,50)]
        [string]$tagNumber,
        [string]$purchaseDate,
        [string]$installationDate,
        [hashtable]$installedBy,
        [string]$warrantyExpirationDate,
        [string]$vendorNotes,
        [string]$notes,
        [ValidateLength(0,25)]
        [string]$macAddress,
        [ValidateLength(0,100)]
        [string]$lastLoginName,
        [boolean]$billFlag,
        [int]$backupSuccesses,
        [int]$backupIncomplete,
        [int]$backupFailed,
        [int]$backupRestores,
        [string]$lastBackupDate,
        [ValidateLength(0,50)]
        [string]$backupServerName,
        [double]$backupBillableSpaceGb,
        [string]$backupProtectedDeviceList,
        [int]$backupYear,
        [int]$backupMonth,
        [ValidateLength(0,50)]
        [string]$ipAddress,
        [ValidateLength(0,50)]
        [string]$defaultGateway,
        [ValidateLength(0,250)]
        [string]$osType,
        [ValidateLength(0,250)]
        [string]$osInfo,
        [ValidateLength(0,100)]
        [string]$cpuSpeed,
        [ValidateLength(0,25)]
        [string]$ram,
        [string]$localHardDrives,
        [int]$parentConfigurationId,
        [hashtable]$vendor,
        [hashtable]$manufacturer,
        [array]$questions,
        [boolean]$activeFlag,
        [validatelength(0,1000)]
        [string]$managementLink,
        [validatelength(0,1000)]
        [string]$remoteLink,
        [hashtable]$sla,
        [Alias('mobilezGuid')]
        [string]$mobileGuid,
        [hashtable]$_info,
        [boolean]$displayVendorFlag,
        [int]$companyLocationId,
        [boolean]$showRemoteFlag,
        [boolean]$showAutomateFlag,
        [boolean]$needsRenewalFlag,
        [ValidateLength(0,50)]
        [string]$manufacturerPartNumber,
        [array]$customFields
    )
    $Endpoint = '/company/configurations'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}