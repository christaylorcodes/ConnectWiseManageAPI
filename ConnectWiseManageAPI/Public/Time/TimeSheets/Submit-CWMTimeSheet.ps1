function Submit-CWMTimeSheet {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [Alias('sheetId')]
        [int]$id
    )

    # Same request as Update-CWMTimeSheet -Submit: POST /time/sheets/{id}/submit with no body.
    # -WhatIf and -Confirm flow through to it via the inherited preference variables.
    Update-CWMTimeSheet -id $id -Submit
}
