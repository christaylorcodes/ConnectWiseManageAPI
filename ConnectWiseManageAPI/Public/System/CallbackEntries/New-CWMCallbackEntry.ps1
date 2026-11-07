<#
.SYNOPSIS
    Creates a callback entry.

.DESCRIPTION
    Creates a callback entry in ConnectWise Manage. Calls POST /system/callbacks; only the parameters you
    pass are sent in the request body.

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER description
    Description. Max length 100.

.PARAMETER url
    URL. Required by the API.

.PARAMETER objectId
    Object id. An integer. Required by the API.

.PARAMETER type
    Type. Required by the API.

.PARAMETER level
    Level. Required by the API.

.PARAMETER memberId
    Member id. An integer.

.PARAMETER payloadVersion
    Payload version.

.PARAMETER inactiveFlag
    Inactive flag. $true or $false.

.PARAMETER isSoapCallbackFlag
    Is SOAP callback flag. $true or $false.

.PARAMETER isSelfSuppressedFlag
    Is self suppressed flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMCallbackEntry -url 'https://example.com/cw/ticket-hook' -objectId 1 -type 'ticket' -level 'owner' -description 'Ticket webhook'

    Registers a callback URL for ticket events.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [ValidateLength(1,100)]
        [string]$description,
        [Parameter(Mandatory=$true)]
        [string]$url,
        [Parameter(Mandatory=$true)]
        [int]$objectId,
        [Parameter(Mandatory=$true)]
        [string]$type,
        [Parameter(Mandatory=$true)]
        [string]$level,
        [int]$memberId,
        [string]$payloadVersion,
        [boolean]$inactiveFlag,
        [boolean]$isSoapCallbackFlag,
        [boolean]$isSelfSuppressedFlag,
        [hashtable]$_info
    )

    $Endpoint = '/system/callbacks'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}