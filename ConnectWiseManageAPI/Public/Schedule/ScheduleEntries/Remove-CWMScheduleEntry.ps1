function Remove-CWMScheduleEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('entryId')]
        [int]$id
    )

    $Endpoint = "/schedule/entries/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
