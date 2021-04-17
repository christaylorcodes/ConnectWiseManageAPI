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
        [string]$payloadVersion,
        [boolean]$inactiveFlag,
        [boolean]$isSoapCallbackFlag,
        [boolean]$isSelfSuppressedFlag,
        [hashtable]$_info
    )

    $Endpoint = '/system/callbacks'
    Invoke-CWMNewMaster -Arguments $PsBoundParameters -Endpoint $Endpoint
}