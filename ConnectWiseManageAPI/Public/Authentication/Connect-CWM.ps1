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
        [Parameter(ParameterSetName = 'Integrator')]
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

    # API key
    if($PubKey -and $PrivateKey){
        Write-Verbose "Using API Key authentication"
        $ConnectionMethod = 'Key'
        $AuthString  = "$($Company)+$($PubKey):$($PrivateKey)"
        $EncodedAuth  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString));
        $Headers = @{
            Authorization = "Basic $EncodedAuth"
            ClientID = $ClientID
            'Cache-Control'= 'no-cache'
        }
    }

    # Cookies, yummy
    elseif($Credentials){
        Write-Verbose "Using Cookie authentication"
        $ConnectionMethod = 'Cookie'
        $script:CWMServerConnection = @{}
        $Headers = @{ ClientID = $ClientID }
        $Body = @{
            CompanyName = $Company
            UserName = $Credentials.UserName
            Password = $Credentials.GetNetworkCredential().Password
        }
        $URI = "https://$($Server)/v4_6_release//login/login.aspx?response=json"
        $WebRequestArguments = @{
            Uri = $Uri
            Method = 'Post'
            Body = $Body
            SessionVariable = 'script:CWMSession'
        }
        # Create session variable. Cookies are stored in that object
        $null = Invoke-CWMWebRequest -Arguments $WebRequestArguments
    }

    # Integrator account w/ w/o member id
    elseif($IntegratorUser -and $IntegratorPass){
        Write-Verbose "Using Integrator authentication"
        $ConnectionMethod = 'Integrator'
        if(!$DontWarn){
            Write-Warning "Please move to a different authentication method."
            Write-Warning "Use the -Don'tWarn switch to suppress this message."
            Write-Warning "https://developer.connectwise.com/Products/Manage/Developer_Guide#Authentication"
        }

        $AuthString  = $Company + '+' + $IntegratorUser + ':' + $IntegratorPass
        $encodedAuth  = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($AuthString))
        $Headers = @{
            Authorization = "Basic $encodedAuth"
            ClientID = $ClientID
            'x-CW-usertype' = "integrator"
            'Cache-Control'= 'no-cache'
        }

        if ($MemberID) {
            Write-Verbose "Impersonating user, $MemberID"
            $ConnectionMethod = 'Impersonation'
            $URL = "https://$($Server)/v4_6_release/apis/3.0/system/members/$($MemberID)/tokens"
            $Body = @{
                memberIdentifier = $MemberID
            }
            $URI = "https://$($Server)/v4_6_release//login/login.aspx?response=json"
            $WebRequestArguments = @{
                Method = 'Post'
                Uri = $URL
                Body = $Body
                ContentType = 'application/json'
            }
            $Result = Invoke-CWMWebRequest -Arguments $WebRequestArguments
            if($Result.content){
                $Result = $Result.content | ConvertFrom-Json
            }
            else {
                Write-Error "Issue getting Auth Token for impersonated user, $MemberID"
                return
            }

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
        Session = $CWMSession
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
