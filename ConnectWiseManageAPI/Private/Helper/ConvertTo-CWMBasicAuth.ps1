function ConvertTo-CWMBasicAuth {
    # Returns the Authorization header value for a ConnectWise Manage API key pair:
    # 'Basic ' + base64("{Company}+{PublicKey}:{PrivateKey}"). Used by Connect-CWM for API key and impersonation auth.
    [CmdletBinding()]
    [OutputType([string])]
    param(
        [string]$Company,
        [string]$PublicKey,
        [string]$PrivateKey
    )

    $AuthString = "$Company+$($PublicKey):$PrivateKey"
    'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString))
}
