function New-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('contactId')]
        [int]$parentId,
        [int]$id,
        [Parameter(Mandatory=$true)]
        [hashtable]$type,
        [Parameter(Mandatory=$true)]
        [ValidateLength(1,250)]
        [string]$value,
        [ValidateLength(1,15)]
        [string]$extension,
        [boolean]$defaultFlag,
        [guid]$mobileGuid,
        [hashtable]$_info
    )

    $Endpoint = "/company/contacts/$($parentId)/communications"
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}
