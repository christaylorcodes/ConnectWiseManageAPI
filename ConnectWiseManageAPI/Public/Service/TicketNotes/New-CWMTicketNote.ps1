function New-CWMTicketNote {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [int]$ticketId,
        [string]$text,
        [boolean]$detailDescriptionFlag,
        [boolean]$internalAnalysisFlag,
        [boolean]$resolutionFlag,
        $member,
        $contact,
        [boolean]$customerUpdatedFlag,
        [boolean]$processNotifications,
        [string]$dateCreated,
        [string]$createdBy,
        [boolean]$internalFlag,
        [boolean]$externalFlag,
        $_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$ticketId/notes"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
