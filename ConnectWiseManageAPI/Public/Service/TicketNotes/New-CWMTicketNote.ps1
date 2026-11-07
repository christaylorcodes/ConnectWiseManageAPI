<#
.SYNOPSIS
    Creates a note for a service ticket.

.DESCRIPTION
    Creates a note for a service ticket in ConnectWise Manage. Calls POST /service/tickets/{parentId}/notes;
    only the parameters you pass are sent in the request body.

.PARAMETER parentId
    The id of the service ticket to add the note to.
    Alias: ticketId

.PARAMETER id
    The id property of the request body. Usually left unset; ConnectWise Manage assigns the id of a new
    record.

.PARAMETER text
    Text.

.PARAMETER detailDescriptionFlag
    Detail description flag. $true or $false.

.PARAMETER internalAnalysisFlag
    Internal analysis flag. $true or $false.

.PARAMETER resolutionFlag
    Resolution flag. $true or $false.

.PARAMETER member
    Member reference, for example @{ id = 10 }.

.PARAMETER contact
    Contact reference, for example @{ id = 500 }.

.PARAMETER customerUpdatedFlag
    Customer updated flag. $true or $false.

.PARAMETER processNotifications
    Process notifications. $true or $false.

.PARAMETER dateCreated
    Date created.

.PARAMETER createdBy
    Created by.

.PARAMETER internalFlag
    Internal flag. $true or $false.

.PARAMETER externalFlag
    External flag. $true or $false.

.PARAMETER _info
    The _info metadata of the record, as returned by the API. Usually left unset.

.EXAMPLE
    New-CWMTicketNote -parentId 1234 -text 'Rebooted the server; the issue is resolved.' -resolutionFlag $true

    Adds a resolution note to service ticket 1234.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMTicketNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('ticketId')]
        [int]$parentId,
        [int]$id,
        [string]$text,
        [boolean]$detailDescriptionFlag,
        [boolean]$internalAnalysisFlag,
        [boolean]$resolutionFlag,
        [hashtable]$member,
        [hashtable]$contact,
        [boolean]$customerUpdatedFlag,
        [boolean]$processNotifications,
        [string]$dateCreated,
        [string]$createdBy,
        [boolean]$internalFlag,
        [boolean]$externalFlag,
        [hashtable]$_info
    )

    $Endpoint = "/service/tickets/$($parentId)/notes"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
