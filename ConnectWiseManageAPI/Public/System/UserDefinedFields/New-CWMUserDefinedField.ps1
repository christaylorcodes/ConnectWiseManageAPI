<#
.SYNOPSIS
    Creates a user defined (custom) field.

.DESCRIPTION
    Creates a user defined (custom) field in ConnectWise Manage. Calls POST /system/userDefinedFields; only the
    parameters you pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new record.

.PARAMETER podId
    Pod id. A whole number. Required by the API.

.PARAMETER podDescription
    Pod description.

.PARAMETER caption
    Caption. Required by the API.

.PARAMETER sequenceNumber
    Sequence number. A whole number. Required by the API.

.PARAMETER screenId
    Screen id.

.PARAMETER screenDescription
    Screen description.

.PARAMETER helpText
    Help text.

.PARAMETER fieldTypeIdentifier
    Field type identifier. One of: TextArea, Button, Currency, Date, Hyperlink, IPAddress, Checkbox, Number, Percent, PhoneNumber, Text, Password. Required by the API.

.PARAMETER numberDecimals
    Number decimals. A whole number.

.PARAMETER entryTypeIdentifier
    Entry type identifier. One of: Date, EntryField, List, Option.

.PARAMETER requiredFlag
    Required flag. $true or $false.

.PARAMETER displayOnScreenFlag
    Display on screen flag. $true or $false.

.PARAMETER readOnlyFlag
    Read only flag. $true or $false.

.PARAMETER listViewFlag
    List view flag. $true or $false.

.PARAMETER buttonUrl
    Button url.

.PARAMETER options
    Options. An array of objects.

.PARAMETER businessUnitIds
    Business unit ids. An array of ids, for example @(1, 2).

.PARAMETER locationIds
    Location ids. An array of ids, for example @(1, 2).

.PARAMETER addAllBusinessUnits
    Add all business units. $true or $false.

.PARAMETER removeAllBusinessUnits
    Remove all business units. $true or $false.

.PARAMETER addAllLocations
    Add all locations. $true or $false.

.PARAMETER removeAllLocations
    Remove all locations. $true or $false.

.PARAMETER connectWiseID
    Connect wise id.

.PARAMETER displayScreenInASIO
    Display screen in asio. $true or $false.

.PARAMETER dateCreated
    Date created. Date and time as an ISO 8601 UTC string, as returned by ConvertTo-CWMTime -Raw.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMUserDefinedField -podId 1 -caption 'Contract Ref' -sequenceNumber 10 -fieldTypeIdentifier Text -entryTypeIdentifier EntryField

    Creates a text custom field on pod 1.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMUserDefinedField {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [int]$id,
        [Parameter(Mandatory = $true)]
        [int]$podId,
        [string]$podDescription,
        [Parameter(Mandatory = $true)]
        [string]$caption,
        [Parameter(Mandatory = $true)]
        [int]$sequenceNumber,
        [string]$screenId,
        [string]$screenDescription,
        [string]$helpText,
        [Parameter(Mandatory = $true)]
        [ValidateSet('TextArea', 'Button', 'Currency', 'Date', 'Hyperlink', 'IPAddress', 'Checkbox', 'Number', 'Percent', 'PhoneNumber', 'Text', 'Password')]
        [string]$fieldTypeIdentifier,
        [int]$numberDecimals,
        [ValidateSet('Date', 'EntryField', 'List', 'Option')]
        [string]$entryTypeIdentifier,
        [bool]$requiredFlag,
        [bool]$displayOnScreenFlag,
        [bool]$readOnlyFlag,
        [bool]$listViewFlag,
        [string]$buttonUrl,
        [array]$options,
        [array]$businessUnitIds,
        [array]$locationIds,
        [bool]$addAllBusinessUnits,
        [bool]$removeAllBusinessUnits,
        [bool]$addAllLocations,
        [bool]$removeAllLocations,
        [string]$connectWiseID,
        [bool]$displayScreenInASIO,
        [string]$dateCreated,
        [hashtable]$_info
    )

    $Endpoint = '/system/userDefinedFields'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
