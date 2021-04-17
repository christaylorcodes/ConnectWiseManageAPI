function Remove-CWMContact {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$id
    )

    $Endpoint = "/company/contacts/$($id)"
    Invoke-CWMDeleteMaster -Endpoint $Endpoint
}