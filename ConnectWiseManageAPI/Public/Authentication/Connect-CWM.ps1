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
        [string]$BasePath = 'apis/3.0'
    )

    if ((($script:CWMServerConnection -and !$script:CWMServerConnection.expiration) `
                -or $script:CWMServerConnection.expiration -gt $(Get-Date)) -and !$Force) {
        Write-Verbose 'Using cached Authentication information.'
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

    # API key
    if ($PubKey -and $PrivateKey) {
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
        $CookieResult = Invoke-CWMWebRequest -Arguments $WebRequestArguments | ConvertFrom-Json
        if (!$CookieResult.Success) {
            Write-Error 'There was an error obtain the MemberHash'
            Write-Error $CookieResult
            break
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

    # Impersonation
    elseif ($PubKey -and $PrivateKey -and $MemberID) {
        Write-Verbose "Impersonating, $MemberID"
        $ConnectionMethod = 'Impersonation'

        $Headers.Add('x-cw-usertype', 'member')
        $WebRequestArguments = @{
            Method      = 'Post'
            Uri         = "https://$($Server)/v4_6_release/apis/3.0/system/members/$($MemberID)/tokens"
            Body        = @{ memberIdentifier = $MemberID }
            ContentType = 'application/json'
            Headers     = $Headers
        }
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        if ($Result.content) {
            $Result = $Result.content | ConvertFrom-Json
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

    # not enough info
    else {
        Write-Error 'Valid authentication parameters not passed'
        return
    }

    # Create the Server Connection object
    $script:CWMServerConnection = @{
        Server           = $Server
        Headers          = $Headers
        Session          = $script:CWMSession
        Expiration       = $expiration
        ConnectionMethod = $ConnectionMethod
        Version          = $Version
        Codebase         = $CompanyInfo.Codebase
        BasePath         = $BasePath
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
