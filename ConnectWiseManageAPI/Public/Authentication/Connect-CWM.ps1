<#
.SYNOPSIS
    Establishes a connection to the ConnectWise Manage API.

.DESCRIPTION
    Authenticates and establishes a connection to the ConnectWise Manage API server.
    Supports three authentication methods:
    - API Key authentication (recommended for automation)
    - Cookie-based authentication (username/password credentials)
    - Member impersonation (for API key with member-specific context)

    Connection information is stored in the script-scoped $CWMServerConnection variable
    and used by all subsequent API calls. The connection persists for the duration of
    the PowerShell session unless explicitly disconnected with Disconnect-CWM.

    The function validates the connection by retrieving system information and stores
    the API version for proper header configuration.

.PARAMETER Server
    The ConnectWise Manage server hostname.
    Examples: 'na.myconnectwise.net', 'api-aus.myconnectwise.net', 'connectwise.company.com'
    Pass only the hostname. A leading scheme (https://) or trailing path is tolerated and stripped.

.PARAMETER Company
    The ConnectWise Manage company identifier (company name/ID used during login).
    This is the company name shown on the login screen.

.PARAMETER PubKey
    The public key component of API key authentication.
    Used with -PrivateKey for API Key or Impersonation authentication methods.
    API keys can be generated in ConnectWise Manage under:
    System > Members > API Keys (or API Members)

.PARAMETER PrivateKey
    The private key component of API key authentication.
    Used with -PubKey for API Key or Impersonation authentication methods.
    Keep this value secure - treat it like a password.

.PARAMETER ClientID
    The unique identifier for your application or integration, sent in the ClientID header.
    Register your application at: https://developer.connectwise.com/ClientID
    (requires a ConnectWise Developer login)

.PARAMETER Credentials
    PSCredential object containing username and password.
    Used exclusively for Cookie authentication method.
    Create with: Get-Credential or [PSCredential]::new()

.PARAMETER MemberID
    The member identifier for impersonation authentication.
    Used with -PubKey and -PrivateKey to authenticate as a specific member.
    Useful for service accounts that need to act on behalf of specific users.

.PARAMETER Force
    Forces a new connection even if a valid cached connection exists.
    By default, if a connection is already established, it will be reused.
    Use -Force to refresh the connection or switch accounts.

.PARAMETER Version
    Specifies the API version to use (e.g., '3.0', '2019.3').
    If not specified, the function auto-detects and uses the server's current version.
    Version is used in the Accept header for API versioning.

.PARAMETER BasePath
    The base API path on the server.
    Default: 'apis/3.0'
    Only change this if using a non-standard API endpoint configuration.

.PARAMETER AllowInsecureRedirect
    Compatibility workaround for ConnectWise-hosted (cloud) instances on PowerShell 7.4 and later.

    Some ConnectWise-hosted servers answer create/update requests with an http:// Location header.
    PowerShell 7.4+ treats any such header as an insecure redirection and throws "Cannot follow an
    insecure redirection by default", typically after the server has already processed the request
    (so the record may exist even though an error was shown).

    When this switch is set, create/update/delete requests suppress that check AND stop following
    redirects entirely (-MaximumRedirection 0). A real redirect is therefore never followed, so
    requests and session cookies are never sent over plain http; instead a genuine redirect
    response is reported as an error. Read (GET) requests are unaffected.

    Has no effect on Windows PowerShell 5.1 or PowerShell 7.0-7.3, which do not perform this check.
    Can be applied to an existing connection without -Force.

.EXAMPLE
    # API Key authentication (recommended for automation)
    $Server = 'na.myconnectwise.net'
    $Company = 'MyCompany'
    $PubKey = 'abcdefgh12345678'
    $PrivateKey = 'ijklmnop87654321'
    $ClientID = 'MyPowerShellScript'

    Connect-CWM -Server $Server -Company $Company -PubKey $PubKey -PrivateKey $PrivateKey -ClientID $ClientID

    Connects using API key authentication. This is the recommended method for scripts and automation.

.EXAMPLE
    # Cookie authentication with username/password
    $Server = 'na.myconnectwise.net'
    $Company = 'MyCompany'
    $Credentials = Get-Credential
    $ClientID = 'MyPowerShellScript'

    Connect-CWM -Server $Server -Company $Company -Credentials $Credentials -ClientID $ClientID

    Connects using traditional username/password credentials stored in a PSCredential object.

.EXAMPLE
    # Member impersonation
    $Server = 'na.myconnectwise.net'
    $Company = 'MyCompany'
    $PubKey = 'abcdefgh12345678'
    $PrivateKey = 'ijklmnop87654321'
    $MemberID = 'jsmith'
    $ClientID = 'MyPowerShellScript'

    Connect-CWM -Server $Server -Company $Company -PubKey $PubKey -PrivateKey $PrivateKey -MemberID $MemberID -ClientID $ClientID

    Authenticates with API key and impersonates a specific member. Useful for service accounts
    that need to perform actions as specific users.

.EXAMPLE
    # Force reconnection with specific API version
    Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -PubKey $PubKey -PrivateKey $PrivateKey -ClientID $ClientID -Version '2019.3' -Force

    Forces a new connection even if one exists and specifies API version 2019.3.

.EXAMPLE
    # Secure credential handling
    $SecureParams = @{
        Server = 'na.myconnectwise.net'
        Company = 'MyCompany'
        PubKey = $env:CWM_PUBKEY
        PrivateKey = $env:CWM_PRIVATEKEY
        ClientID = 'MyScript'
    }
    Connect-CWM @SecureParams

    Uses environment variables to avoid hardcoding credentials in scripts.

.EXAMPLE
    Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -PubKey $Pub -PrivateKey $Priv -ClientID $ClientID -AllowInsecureRedirect

    Connects to a ConnectWise-hosted instance and enables the workaround for the PowerShell 7.4+
    "Cannot follow an insecure redirection" error on New-/Update-CWM* commands.

.NOTES
    Author: Chris Taylor

    Connection Lifecycle:
    - Connections persist for the PowerShell session duration
    - Only impersonation connections expire (when the impersonation token expires); API key and
      cookie connections are reused until Disconnect-CWM or -Force
    - Use Disconnect-CWM to explicitly clear connection
    - Use -Force to refresh an existing connection

    Security Considerations:
    - API keys are preferred over username/password for automation
    - Store credentials securely (environment variables, secure storage, key vaults)
    - Never commit credentials to source control
    - Regularly rotate API keys per security policies

    ClientID:
    - Mandatory parameter; sent as the ClientID header on every request
    - Register at: https://developer.connectwise.com/ClientID (requires a ConnectWise Developer login)

.LINK
    https://developer.connectwise.com/manage/rest

.LINK
    https://developer.connectwise.com/ClientID

.LINK
    Disconnect-CWM

.LINK
    Get-CWMSystemInfo

.OUTPUTS
    None. Connection information is stored in script-scoped variable $CWMServerConnection.

.INPUTS
    None. This function does not accept pipeline input.

#>
function Connect-CWM {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Server,
        [Parameter(Mandatory = $true)]
        [string]$Company,
        [Parameter(ParameterSetName = 'API Key', Mandatory = $True)]
        [Parameter(ParameterSetName = 'Impersonation', Mandatory = $True)]
        [string]$PubKey,
        [Parameter(ParameterSetName = 'API Key', Mandatory = $True)]
        [Parameter(ParameterSetName = 'Impersonation', Mandatory = $True)]
        [string]$PrivateKey,
        [Parameter(Mandatory = $true)]
        [string]$ClientID,
        [Parameter(ParameterSetName = 'Cookie', Mandatory = $True)]
        [pscredential]$Credentials,
        [Parameter(ParameterSetName = 'Impersonation', Mandatory = $True)]
        [string]$MemberID,
        [switch]$Force,
        [string]$Version,
        [string]$BasePath = 'apis/3.0',
        [switch]$AllowInsecureRedirect
    )

    if ($AllowInsecureRedirect -and !$script:CWMSupportsInsecureRedirect) {
        Write-Verbose 'AllowInsecureRedirect has no effect on this PowerShell version (requires 7.4+).'
    }

    if ((($script:CWMServerConnection -and !$script:CWMServerConnection.expiration) `
                -or $script:CWMServerConnection.expiration -gt $(Get-Date)) -and !$Force) {
        Write-Verbose 'Using cached Authentication information.'
        if ($PSBoundParameters.ContainsKey('AllowInsecureRedirect')) {
            $script:CWMServerConnection.AllowInsecureRedirect = [bool]$AllowInsecureRedirect
        }
        return
    }

    # Validate server
    $Server = ($Server -replace ('http.*:\/\/', '') -split '/')[0]
    try { $CompanyInfo = Invoke-RestMethod "https://$($Server)/login/companyinfo/$($Company)" -ErrorAction Stop }
    catch { Write-Error $_ -ErrorAction Stop }

    $Headers = @{
        ClientID        = $ClientID
        'Cache-Control' = 'no-cache'
    }
    $script:CWMServerConnection = @{
        Server  = $Server
        Version = $Version
        Headers = $Headers
    }

    # Impersonation. Checked before plain API key auth, which also matches when PubKey and PrivateKey are passed.
    if ($PubKey -and $PrivateKey -and $MemberID) {
        Write-Verbose "Impersonating, $MemberID"
        $ConnectionMethod = 'Impersonation'

        # The token request is authenticated with the API member's own keys
        $AuthString = "$($Company)+$($PubKey):$($PrivateKey)"
        $EncodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString))
        $Headers.Add('Authorization', "Basic $EncodedAuth")
        $Headers.Add('x-cw-usertype', 'member')
        $WebRequestArguments = @{
            Method      = 'Post'
            Uri         = "https://$($Server)/v4_6_release/apis/3.0/system/members/$($MemberID)/tokens"
            Body        = @{ memberIdentifier = $MemberID } | ConvertTo-Json
            ContentType = 'application/json; charset=utf-8'
            Headers     = $Headers
        }
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = ConvertFrom-CWMJson $Result.Content
        }
        else {
            Write-Error "Issue getting Auth Token for Impersonated user, $MemberID"
            Write-Error $Result
            return
        }

        # Create auth header for Impersonated user
        $expiration = [datetime]$Result.expiration
        $AuthString = $Company + '+' + $Result.publicKey + ':' + $Result.privateKey
        $encodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(($AuthString)));
        $Headers = @{
            Authorization   = "Basic $encodedAuth"
            ClientID        = $ClientID
            'Cache-Control' = 'no-cache'
        }
    }

    # API key
    elseif ($PubKey -and $PrivateKey) {
        Write-Verbose 'Using API Key authentication'
        $ConnectionMethod = 'Key'
        $AuthString = "$($Company)+$($PubKey):$($PrivateKey)"
        $EncodedAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString))
        $Headers.add('Authorization', "Basic $EncodedAuth")
    }

    # Cookies, yummy
    elseif ($Credentials) {
        Write-Verbose 'Using Cookie authentication'
        $ConnectionMethod = 'Cookie'
        $Body = @{
            CompanyName = $Company
            UserName    = $Credentials.UserName
            Password    = $Credentials.GetNetworkCredential().Password
        }
        $WebRequestArguments = @{
            Uri             = "https://$($Server)/v4_6_release/login/login.aspx?response=json"
            Method          = 'Post'
            Body            = $Body
            SessionVariable = 'script:CWMSession'
        }

        # Create session variable. Cookies are stored in that object
        $CookieResponse = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        $CookieResult = ConvertFrom-CWMJson $CookieResponse.Content
        if (!$CookieResult.Success) {
            Write-Error 'There was an error obtain the MemberHash'
            if ($CookieResult) { Write-Error ($CookieResult | Out-String) }
            return
        }

        # Seems cookies don't get put in session any more, add them
        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = 'companyName'
        $Cookie.Value = $Company
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = 'memberHash'
        $Cookie.Value = $CookieResult.Hash
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = 'MemberID'
        $Cookie.Value = $Credentials.UserName
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = 'MemberContext'
        $Cookie.Value = 'web'
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)
    }

    # not enough info
    else {
        Write-Error 'Valid authentication parameters not passed'
        return
    }

    # Create the Server Connection object
    $script:CWMServerConnection = @{
        Server                = $Server
        Headers               = $Headers
        Session               = $script:CWMSession
        Expiration            = $expiration
        ConnectionMethod      = $ConnectionMethod
        Version               = $Version
        Codebase              = $CompanyInfo.Codebase
        BasePath              = $BasePath
        # Set only on the final connection; login/impersonation requests above run without it
        AllowInsecureRedirect = [bool]$AllowInsecureRedirect
    }

    # Set version header info
    if ($Version) { $script:CWMServerConnection.Headers.Accept = "application/vnd.connectwise.com+json; version=$($Version)" }
    else { $script:CWMServerConnection.Headers.Accept = 'application/vnd.connectwise.com+json' }

    # Validate connection info
    Write-Verbose 'Validating authentication'
    $Info = Get-CWMSystemInfo
    if (!$Info) {
        Write-Warning 'Authentication failed. Clearing connection settings.'
        Disconnect-CWM
        return
    }

    if (!$Version) {
        [version]$Version = $Info.version.trim('v')
        $script:CWMServerConnection.Version = "$($Version.major).$($Version.minor)"
    }

    Write-Verbose 'Connection successful.'
    Write-Verbose '$CWMServerConnection, variable initialized.'
}
