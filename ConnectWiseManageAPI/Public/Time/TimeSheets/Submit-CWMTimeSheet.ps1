<#
.SYNOPSIS
    Submits a time sheet for approval.

.DESCRIPTION
    Submits a time sheet. Calls POST /time/sheets/{id}/submit with no body, the same request as
    Update-CWMTimeSheet -Submit.

.PARAMETER id
    The id of the time sheet to submit.
    Alias: sheetId

.EXAMPLE
    Submit-CWMTimeSheet -id 88

    Submits time sheet 88.

.LINK
    Update-CWMTimeSheet

.LINK
    https://developer.connectwise.com/manage/rest
#>
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
