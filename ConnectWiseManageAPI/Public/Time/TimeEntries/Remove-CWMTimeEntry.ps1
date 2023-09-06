function Remove-CWMTimeEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', 
        Justification = 'Confirm will be managed by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('entryId')]
        [int]$id
    )

    $Endpoint = "/time/entries/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}