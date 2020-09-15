function New-CWMCallbackEntry {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Medium')]
    param(
        [int]$id,
        [ValidateLength(1,100)]
        [string]$description,
        [Parameter(Mandatory=$true)]
        [string]$url,
        [Parameter(Mandatory=$true)]
        [int]$objectId,
        [Parameter(Mandatory=$true)]
        [string]$type,
        [Parameter(Mandatory=$true)]
        [string]$level,
        [int]$memberId,
        [boolean]$inactiveFlag,
        [hashtable]$_info
    )

    $URI = "https://$($script:CWMServerConnection.Server)/v4_6_release/apis/3.0/system/callbacks"
    return Invoke-CWMNewMaster -Arguments $PsBoundParameters -URI $URI
}