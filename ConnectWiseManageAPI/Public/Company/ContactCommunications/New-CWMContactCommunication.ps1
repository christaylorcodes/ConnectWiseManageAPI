<#
.SYNOPSIS
    Adds a communication item (phone number, email address, ...) to a contact.

.DESCRIPTION
    Creates a communication item for a contact in ConnectWise Manage. Calls POST
    /company/contacts/{parentId}/communications; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the contact to add the communication item to.
    Alias: contactId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER type
    Type reference, for example @{ id = 1 }. Required by the API.

.PARAMETER value
    Value. Max length 250. Required by the API.

.PARAMETER extension
    Extension. Max length 15.

.PARAMETER defaultFlag
    Default flag. $true or $false.

.PARAMETER mobileGuid
    Mobile GUID.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMContactCommunication -parentId 500 -type @{ id = 1 } -value 'ann.smith@example.com' -defaultFlag $true

    Adds a communication item of communication type 1 to contact 500 and makes it the default.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,250)]
        [string]$value,
        [ValidateLength(1,15)]
        [string]$extension,
        [boolean]$defaultFlag,
        [guid]$mobileGuid,
        [hashtable]$_info
    )

    $Endpoint = "/company/contacts/$($parentId)/communications"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
