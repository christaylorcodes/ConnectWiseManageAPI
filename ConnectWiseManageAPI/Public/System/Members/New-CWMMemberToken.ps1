<#
.SYNOPSIS
    Creates API keys for a member.

.DESCRIPTION
    Creates a new public and private API key pair for a member. Calls POST
    /system/members/{memberIdentifier}/tokens, sent with the x-cw-usertype: member header.

.PARAMETER memberIdentifier
    The identifier (user name) of the member, for example 'jdoe'.

.EXAMPLE
    New-CWMMemberToken -memberIdentifier 'jdoe'

    Creates an API key pair for member jdoe and returns the public key, private key and expiration.

.LINK
    https://developer.connectwise.com/manage/rest
#>
function New-CWMMemberToken {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSShouldProcess', '', Justification = 'Used by sub-function')]
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$memberIdentifier
    )
    $Skip = 'Headers'
    $Endpoint = "/system/members/$([uri]::EscapeDataString($memberIdentifier))/tokens"
    Invoke-CWMNewMaster -Arguments @{Headers = @{'x-cw-usertype' = 'member' } } -Endpoint $Endpoint -Skip $Skip
}
