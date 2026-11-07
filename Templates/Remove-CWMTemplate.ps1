function Remove-CWMTemplate {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('somethingId')]
        [int]$id
    )
    # Invoke-CWMRemoveMaster does the ShouldProcess check (-WhatIf / -Confirm)
    $Endpoint = "<Endpoint>/$($id)"
    Invoke-CWMRemoveMaster -Endpoint $Endpoint
}
