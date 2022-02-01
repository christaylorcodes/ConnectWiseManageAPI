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
