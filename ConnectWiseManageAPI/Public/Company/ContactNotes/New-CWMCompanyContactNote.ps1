<#
.SYNOPSIS
    Creates a contact note for a contact.

.DESCRIPTION
    Creates a contact note for a contact in ConnectWise Manage. Calls POST
    /company/contacts/{parentId}/notes; only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the contact to add the contact note to.
    Alias: contactId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER text
    Text. Required by the API.

.PARAMETER type
    Type reference, for example @{ id = 1 }.

.PARAMETER flagged
    Flagged. $true or $false.

.PARAMETER enteredBy
    Entered by.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMCompanyContactNote -parentId 500 -text 'Prefers to be contacted by email.'

    Adds a note to contact 500.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMCompanyContactNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    [Alias('New-CWMContactNote')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory=$true)]
        [string]$text,
        [hashtable]$type,
        [boolean]$flagged,
        [string]$enteredBy,
        [hashtable]$_info
    )

    $Endpoint = "/company/contacts/$($parentId)/notes"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}