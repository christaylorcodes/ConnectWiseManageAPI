function New-CWMTicketConfiguration {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
    	[int]$TicketID,
        [string]$deviceIdentifier
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/service/tickets/$TicketID/configurations"

    $Skip = @('TicketID')
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI -Skip $Skip
}