function Connect-CWM {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Server,
        [Parameter(Mandatory=$true)]
        [string]$Company,
        [Parameter(ParameterSetName = 'API Key', Mandatory = $True)]
        [string]$PubKey,
        [Parameter(ParameterSetName = 'API Key', Mandatory = $True)]
        [string]$PrivateKey,
        [Parameter(Mandatory=$true)]
        [string]$ClientID,
        [Parameter(ParameterSetName = 'Cookie', Mandatory = $True)]
        [pscredential]$Credentials,
        [Parameter(ParameterSetName = 'Integrator', Mandatory = $True)]
        [string]$IntegratorUser,
        [Parameter(ParameterSetName = 'Integrator', Mandatory = $True)]
        [string]$IntegratorPass,
        [Parameter(ParameterSetName = 'Integrator', Mandatory = $True)]
        [string]$MemberID,
        [switch]$Force,
        [Parameter(ParameterSetName = 'Integrator')]
        [switch]$DontWarn,
        [string]$Version
    )

    if ((($script:CWMServerConnection -and !$script:CWMServerConnection.expiration) `
    -or $script:CWMServerConnection.expiration -gt $(Get-Date)) -and !$Force) {
        Write-Verbose "Using cached Authentication information."
        return
    }

    # Validate server
    $Server = ($Server -replace("http.*:\/\/",'') -split '/')[0]
    
    $Headers = @{ 
        ClientID = $ClientID 
        'Cache-Control' = 'no-cache'
    }
    $script:CWMServerConnection = @{
        Server = $Server
        ConnectionMethod = $ConnectionMethod
        Version = $Version
        Headers = $Headers
    }

    # API key
    if($PubKey -and $PrivateKey){
        Write-Verbose "Using API Key authentication"
        $ConnectionMethod = 'Key'
        $AuthString  = "$($Company)+$($PubKey):$($PrivateKey)"
        $EncodedAuth  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString));
        $Headers = @{
            Authorization = "Basic $EncodedAuth"
            ClientID = $ClientID
            'Cache-Control' = 'no-cache'
        }
    }

    # Cookies, yummy
    elseif($Credentials){
        Write-Verbose "Using Cookie authentication"
        $ConnectionMethod = 'Cookie'
        $Body = @{
            CompanyName = $Company
            UserName = $Credentials.UserName
            Password = $Credentials.GetNetworkCredential().Password
        }
        $WebRequestArguments = @{
            Uri = "https://$($Server)/v4_6_release/login/login.aspx?response=json"
            Method = 'Post'
            Body = $Body
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
        $Cookie.Name = "companyName" 
        $Cookie.Value = $Company
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = "memberHash"
        $Cookie.Value = $CookieResult.Hash
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = "MemberID"
        $Cookie.Value = $Credentials.UserName
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)

        $Cookie = New-Object System.Net.Cookie
        $Cookie.Name = "MemberContext"
        $Cookie.Value = 'web'
        $Cookie.Domain = $Server
        $script:CWMSession.Cookies.Add($Cookie)
    }

    # Integrator account w/ member
    elseif($IntegratorUser -and $IntegratorPass -and $MemberID){
        Write-Verbose "Using Integrator authentication and impersonating, $MemberID"
        $ConnectionMethod = 'Impersonation'

        if(!$DontWarn){
            Write-Warning "Please move to a different authentication method."
            Write-Warning "Use the -Don'tWarn switch to suppress this message."
            Write-Warning "https://developer.connectwise.com/Products/Manage/Developer_Guide#Authentication"
        }

        $AuthString  = $Company + '+' + $IntegratorUser + ':' + $IntegratorPass
        $encodedAuth  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString))
        $Headers = @{
            Authentication = "Basic $encodedAuth"
            'x-cw-usertype' = 'integrator'
        }
        $WebRequestArguments = @{
            Method = 'Post'
            Uri = "https://$($Server)/v4_6_release/apis/3.0/system/members/$($MemberID)/tokens"
            Body = @{ memberIdentifier = $MemberID }
            ContentType = 'application/json'
            Headers = $Headers
        }
        Write-Verbose "WebRequestArguments: $($WebRequestArguments | ConvertTo-Json)"
        $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
        Write-Verbose "Result: $Result"
        if($Result.content){
            $Result = $Result.content | ConvertFrom-Json
        }
        else {
            Write-Error "Issue getting Auth Token for Impersonated user, $MemberID"
            Write-Error $Result
            return
        }
        Write-Verbose "Integrator results $Result"
        # Create auth header for Impersonated user
        $expiration = [datetime]$Result.expiration
        $AuthString  = $Company + '+' + $Result.publicKey + ':' + $Result.privateKey
        $encodedAuth  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(($AuthString)));
        $Headers = @{
            Authorization = "Basic $encodedAuth"
            ClientID = $ClientID
            'Cache-Control'= 'no-cache'
        }
    }

    # not enough info
    else {
        Write-Error "Valid authentication parameters not passed"
        return
    }

    # Create the Server Connection object
    $script:CWMServerConnection = @{
        Server = $Server
        Headers = $Headers
        Session = $script:CWMSession
        Expiration = $expiration
        ConnectionMethod = $ConnectionMethod
        Version = $Version
    }

    # Set version header info
    if ($Version) {
        $script:CWMServerConnection.Headers.Accept = "application/vnd.connectwise.com+json; version=$($Version)"
    } else {
        $script:CWMServerConnection.Headers.Accept = "application/vnd.connectwise.com+json"
    }

    # Validate connection info
    Write-Verbose 'Validating authentication'
    Write-Verbose "Session: $($script:CWMServerConnection.Session)"
    $Info = Get-CWMSystemInfo
    if(!$Info) {
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
