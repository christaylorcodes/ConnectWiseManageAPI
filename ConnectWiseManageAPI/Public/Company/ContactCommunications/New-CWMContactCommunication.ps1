function New-CWMContactCommunication {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$true)]
        [int]$id,
        [int]$contactId,
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

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/company/contacts/$($id)/communications"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}
