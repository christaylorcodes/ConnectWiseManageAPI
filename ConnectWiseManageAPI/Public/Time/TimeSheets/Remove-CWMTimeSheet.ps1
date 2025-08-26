function Remove-CWMTimeSheet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('timesheetId')]
        [int]$id
    )
    $Endpoint = "/time/sheets/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}