<#
.SYNOPSIS
    Establishes a connection to the ConnectWise Manage API.

.DESCRIPTION
    Authenticates and establishes a connection to the ConnectWise Manage API server.
    Supports three authentication methods:
    - API Key authentication (recommended for automation)
    - Cookie-based authentication (username/password credentials)
    - Member impersonation (API keys plus -MemberID: every request is made as that member)

    Connection information is stored in the script-scoped $CWMServerConnection variable
    and used by all subsequent API calls. The connection persists for the duration of
    the PowerShell session unless explicitly disconnected with Disconnect-CWM.

    The connection is only stored once it has been validated. If any step fails (server lookup,
    impersonation token, cookie login or validation), nothing from the failed attempt is kept. A previous
    connection to the same server and company stays in place (so a transient failure during -Force does
    not disconnect you); a previous connection to a different server or company is cleared, and other
    commands fail until Connect-CWM succeeds.

    The function validates the connection by retrieving system information. The server's current
    API version is read from that response and sent in the Accept header of every later request
    (application/vnd.connectwise.com+json; version=X.Y), so the module always uses the latest API
    the server offers. The API version cannot be chosen.

.PARAMETER Server
    The ConnectWise Manage server hostname.
    Examples: 'na.myconnectwise.net', 'api-aus.myconnectwise.net', 'connectwise.company.com'
    Pass only the hostname, optionally with a port ('cw.company.com:8443'). A leading scheme (https://)
    and everything from the first '/' on are stripped, so a URL pasted from the browser
    ('https://na.myconnectwise.net/v4_6_release/ConnectWise.aspx?locale=en_US#startscreen') works.
    Requests always use https.
    A host part with user info, a query, a fragment or a backslash (the characters '@', '?', '#' or '\'
    before the first '/') is rejected.

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
    The identifier of the member to impersonate, e.g. 'jsmith'.
    Used with -PubKey and -PrivateKey. Connect-CWM uses the API keys to request a token for this member
    (POST /system/members/{MemberID}/tokens) and then sends EVERY request as that member: records are
    created and changed in the member's name, and the member's security roles decide what is allowed.
    The connection expires when the token expires; Connect-CWM then connects again.
    If the token cannot be issued, Connect-CWM fails and no connection is stored.

    Changed in 0.5.0: version 0.4.16 accepted -MemberID but silently connected with the API key
    instead, so requests ran as the API member. Scripts that pass -MemberID now really act as that member.

.PARAMETER Force
    Forces a new connection even if a valid cached connection exists.
    By default, a connection to the same server and company, with the same sign-in method (API key,
    impersonation of the same member, or cookie), is reused without contacting the server. A different
    server, company, sign-in method or impersonated member always connects again, with or without -Force.
    Use -Force to refresh the connection or to switch API keys or credentials on the same server and company.

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
    # Force reconnection
    Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -PubKey $PubKey -PrivateKey $PrivateKey -ClientID $ClientID -Force

    Forces a new connection even if one exists, for example to switch accounts.

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
    - A cached connection is reused only for the same server, company, sign-in method and impersonated
      member; connecting to another tenant replaces it
    - Cookie-session cookies are marked Secure, so they are only sent over https
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
        [string]$BasePath = 'apis/3.0',
        [switch]$AllowInsecureRedirect
    )

    if ($AllowInsecureRedirect -and !$script:CWMSupportsInsecureRedirect) {
        Write-Verbose 'AllowInsecureRedirect has no effect on this PowerShell version (requires 7.4+).'
    }

    # Validate server: a host name with an optional port. A leading http(s):// and everything from the first '/'
    # on (path, query, fragment of a pasted URL) are stripped, as in 0.4.16. In the remaining authority, anything
    # that could change which host the credentials are sent to (user info, query, fragment, '\') is rejected.
    $ServerInput = $Server
    $Server = (($Server.Trim() -replace '^https?://', '') -split '/')[0]
    $ServerUri = $null
    if ($Server -match '[@#?\\\s]' -or $Server -notmatch '^[A-Za-z0-9_]([A-Za-z0-9_.-]*[A-Za-z0-9_])?(:\d{1,5})?$' -or
        ![uri]::TryCreate("https://$Server", [System.UriKind]::Absolute, [ref]$ServerUri) -or
        $ServerUri.UserInfo -or $ServerUri.PathAndQuery -ne '/' -or $ServerUri.Fragment) {
        Write-Error "Invalid -Server '$ServerInput'. Pass the host name of the ConnectWise Manage server, e.g. 'na.myconnectwise.net' or 'cw.company.com:8443'." -ErrorAction Stop
    }

    if ($MemberID) { $ConnectionMethod = 'Impersonation' }
    elseif ($Credentials) { $ConnectionMethod = 'Cookie' }
    else { $ConnectionMethod = 'Key' }

    # Reuse the cached connection only for the same server, company and sign-in method (and impersonated member).
    # Anything else connects again, as if -Force was passed.
    $Cached = $script:CWMServerConnection
    $CachedIsValid = $Cached -and (!$Cached.Expiration -or $Cached.Expiration -gt $(Get-Date))
    $CachedIsSameIdentity = $Cached -and $Cached.Server -eq $Server -and $Cached.Company -eq $Company -and
        $Cached.ConnectionMethod -eq $ConnectionMethod -and "$($Cached.MemberID)" -eq "$MemberID"
    if ($CachedIsValid -and !$Force) {
        if ($CachedIsSameIdentity) {
            Write-Verbose 'Using cached Authentication information.'
            if ($PSBoundParameters.ContainsKey('AllowInsecureRedirect')) {
                $Cached.AllowInsecureRedirect = [bool]$AllowInsecureRedirect
            }
            return
        }
        Write-Verbose 'The cached connection is for a different server, company or sign-in method. Connecting again.'
    }

    $EscapedCompany = [uri]::EscapeDataString($Company)
    $Connected = $false
    # A failed reconnect as the same identity (same server, company, sign-in method and member; e.g. -Force
    # hitting a transient error) keeps the previous, unexpired connection. Any other failed connect clears it,
    # so callers never silently continue under a different identity or tenant.
    $Previous = $null
    $PreviousSession = $null
    if ($CachedIsValid -and $CachedIsSameIdentity) {
        $Previous = $Cached
        $PreviousSession = $script:CWMSession
    }
    try {
        # The previous connection is replaced. On any failure the finally block puts back the previous
        # same-tenant connection (or nothing), so a partly built connection is never left behind.
        $script:CWMServerConnection = $null
        $script:CWMSession = $null

        # Codebase discovery runs before there is a connection, so it calls Invoke-RestMethod directly
        $CompanyInfoArguments = @{
            Uri             = "https://$($Server)/login/companyinfo/$($EscapedCompany)"
            Headers         = @{ ClientID = $ClientID }
            UserAgent       = $script:CWMUserAgent
            UseBasicParsing = $true
            ErrorAction     = 'Stop'
        }
        try { $CompanyInfo = Invoke-RestMethod @CompanyInfoArguments }
        catch { Write-Error $_ -ErrorAction Stop }
        # Every URL is built on the codebase; without it the company was not found on this server
        if (!$CompanyInfo.Codebase) {
            Write-Error "The server did not return a codebase for company '$Company'. Check -Server and -Company." -ErrorAction Stop
        }

        $Headers = @{
            ClientID        = $ClientID
            'Cache-Control' = 'no-cache'
        }
        $Connection = @{
            Server           = $Server
            Company          = $Company
            Headers          = $Headers
            Session          = $null
            Expiration       = $null
            ConnectionMethod = $ConnectionMethod
            Codebase         = $CompanyInfo.Codebase
            BasePath         = $BasePath
        }
        # The login and impersonation requests below go through Invoke-CWMWebRequest, which needs a connection
        $script:CWMServerConnection = $Connection

        # Impersonation. Checked before plain API key auth, which also matches when PubKey and PrivateKey are passed.
        if ($ConnectionMethod -eq 'Impersonation') {
            Write-Verbose "Impersonating, $MemberID"
            $Connection.MemberID = $MemberID

            # The token request is authenticated with the API member's own keys
            $TokenHeaders = $Headers.Clone()
            $TokenHeaders.Authorization = ConvertTo-CWMBasicAuth -Company $Company -PublicKey $PubKey -PrivateKey $PrivateKey
            $TokenHeaders.'x-cw-usertype' = 'member'
            $WebRequestArguments = @{
                Method      = 'Post'
                # The server's codebase and the connection's base path, like every other request
                Uri         = New-CWMUrl -Endpoint "/system/members/$([uri]::EscapeDataString($MemberID))/tokens"
                Body        = @{ memberIdentifier = $MemberID } | ConvertTo-Json
                ContentType = 'application/json; charset=utf-8'
                Headers     = $TokenHeaders
            }
            $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
            if ($Result.content) { $Result = ConvertFrom-CWMJson $Result.Content }
            if (!$Result.publicKey -or !$Result.privateKey) {
                Write-Error "Issue getting Auth Token for Impersonated user, $MemberID"
                return
            }

            # Create auth header for Impersonated user
            if ($Result.expiration) { $Connection.Expiration = [datetime]$Result.expiration }
            $Headers.Authorization = ConvertTo-CWMBasicAuth -Company $Company -PublicKey $Result.publicKey -PrivateKey $Result.privateKey
        }

        # API key
        elseif ($ConnectionMethod -eq 'Key') {
            Write-Verbose 'Using API Key authentication'
            $Headers.Authorization = ConvertTo-CWMBasicAuth -Company $Company -PublicKey $PubKey -PrivateKey $PrivateKey
        }

        # Cookies, yummy
        else {
            Write-Verbose 'Using Cookie authentication'
            $Body = @{
                CompanyName = $Company
                UserName    = $Credentials.UserName
                Password    = $Credentials.GetNetworkCredential().Password
            }
            # The login response's cookies are stored in this session
            $Session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            $WebRequestArguments = @{
                Uri        = (Join-Url (Join-Url "https://$($Server)" $Connection.Codebase) 'login/login.aspx?response=json')
                Method     = 'Post'
                Body       = $Body
                WebSession = $Session
            }

            $CookieResponse = Invoke-CWMWebRequest -Arguments $WebRequestArguments
            $CookieResult = $null
            if ($CookieResponse.Content) { $CookieResult = ConvertFrom-CWMJson $CookieResponse.Content }
            if (!$CookieResult.Success) {
                Write-Error 'There was an error obtain the MemberHash'
                if ($CookieResult) { Write-Error ($CookieResult | Out-String) }
                return
            }

            # Seems cookies don't get put in session any more, add them. Secure: only ever sent over https.
            $Cookies = [ordered]@{
                companyName   = $Company
                memberHash    = $CookieResult.Hash
                MemberID      = $Credentials.UserName
                MemberContext = 'web'
            }
            foreach ($Name in $Cookies.Keys) {
                $Cookie = New-Object System.Net.Cookie
                $Cookie.Name = $Name
                $Cookie.Value = $Cookies[$Name]
                $Cookie.Domain = $ServerUri.Host
                $Cookie.Secure = $true
                $Session.Cookies.Add($Cookie)
            }
            $Connection.Session = $Session
        }

        # Set only now; the login/impersonation requests above run without it
        $Connection.AllowInsecureRedirect = [bool]$AllowInsecureRedirect
        # No version yet: it is read from the system info below
        $Connection.Headers.Accept = 'application/vnd.connectwise.com+json'

        Write-Verbose 'Validating authentication'
        $Info = Get-CWMSystemInfo
        if (!$Info) {
            Write-Warning 'Authentication failed. The new connection was not stored.'
            return
        }

        # Always use the server's current API version
        [version]$ServerVersion = $Info.version.trim('v')
        $Connection.Version = "$($ServerVersion.Major).$($ServerVersion.Minor)"
        $Connection.Headers.Accept = "application/vnd.connectwise.com+json; version=$($Connection.Version)"

        $script:CWMSession = $Connection.Session
        $Connected = $true
    }
    finally {
        if (!$Connected) {
            $script:CWMServerConnection = $Previous
            $script:CWMSession = $PreviousSession
        }
    }

    Write-Verbose 'Connection successful.'
    Write-Verbose '$CWMServerConnection, variable initialized.'
}