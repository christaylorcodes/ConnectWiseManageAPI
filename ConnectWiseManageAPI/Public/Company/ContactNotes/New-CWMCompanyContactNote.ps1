function New-CWMCompanyContactNote {
    # 2021.1
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    [Alias('New-CWMContactNote')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory=$true)]
        [string]$text,
        [hashtable]$type,
        [boolean]$flagged,
        [string]$enteredBy,
        [hashtable]$_info
    )

    $Endpoint = "/company/contacts/$($parentId)/notes"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}