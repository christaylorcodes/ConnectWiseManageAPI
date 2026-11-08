---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Connect-CWM

## SYNOPSIS
Establishes a connection to the ConnectWise Manage API.

## SYNTAX

### Impersonation
```
Connect-CWM -Server <String> -Company <String> -PubKey <String> -PrivateKey <String> -ClientID <String>
 -MemberID <String> [-Force] [-BasePath <String>] [-AllowInsecureRedirect]
 [<CommonParameters>]
```

### API Key
```
Connect-CWM -Server <String> -Company <String> -PubKey <String> -PrivateKey <String> -ClientID <String>
 [-Force] [-BasePath <String>] [-AllowInsecureRedirect]
 [<CommonParameters>]
```

### Cookie
```
Connect-CWM -Server <String> -Company <String> -ClientID <String> -Credentials <PSCredential> [-Force]
 [-BasePath <String>] [-AllowInsecureRedirect] [<CommonParameters>]
```

## DESCRIPTION
Authenticates and establishes a connection to the ConnectWise Manage API server.
Supports three authentication methods:
- API Key authentication (recommended for automation)
- Cookie-based authentication (username/password credentials)
- Member impersonation (API keys plus -MemberID: every request is made as that member)

Connection information is stored in the script-scoped $CWMServerConnection variable
and used by all subsequent API calls.
The connection persists for the duration of
the PowerShell session unless explicitly disconnected with Disconnect-CWM.

The connection is only stored once it has been validated.
If any step fails (server lookup,
impersonation token, cookie login or validation), nothing from the failed attempt is kept.
A previous
connection to the same server and company stays in place (so a transient failure during -Force does
not disconnect you); a previous connection to a different server or company is cleared, and other
commands fail until Connect-CWM succeeds.

The function validates the connection by retrieving system information.
The server's current
API version is read from that response and sent in the Accept header of every later request
(application/vnd.connectwise.com+json; version=X.Y), so the module always uses the latest API
the server offers.
The API version cannot be chosen.

## EXAMPLES

### EXAMPLE 1
```
# API Key authentication (recommended for automation)
$Server = 'na.myconnectwise.net'
$Company = 'MyCompany'
$PubKey = 'abcdefgh12345678'
$PrivateKey = 'ijklmnop87654321'
$ClientID = 'MyPowerShellScript'
```

Connect-CWM -Server $Server -Company $Company -PubKey $PubKey -PrivateKey $PrivateKey -ClientID $ClientID

Connects using API key authentication.
This is the recommended method for scripts and automation.

### EXAMPLE 2
```
# Cookie authentication with username/password
$Server = 'na.myconnectwise.net'
$Company = 'MyCompany'
$Credentials = Get-Credential
$ClientID = 'MyPowerShellScript'
```

Connect-CWM -Server $Server -Company $Company -Credentials $Credentials -ClientID $ClientID

Connects using traditional username/password credentials stored in a PSCredential object.

### EXAMPLE 3
```
# Member impersonation
$Server = 'na.myconnectwise.net'
$Company = 'MyCompany'
$PubKey = 'abcdefgh12345678'
$PrivateKey = 'ijklmnop87654321'
$MemberID = 'jsmith'
$ClientID = 'MyPowerShellScript'
```

Connect-CWM -Server $Server -Company $Company -PubKey $PubKey -PrivateKey $PrivateKey -MemberID $MemberID -ClientID $ClientID

Authenticates with API key and impersonates a specific member.
Useful for service accounts
that need to perform actions as specific users.

### EXAMPLE 4
```
# Force reconnection
Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -PubKey $PubKey -PrivateKey $PrivateKey -ClientID $ClientID -Force
```

Forces a new connection even if one exists, for example to switch accounts.

### EXAMPLE 5
```
# Secure credential handling
$SecureParams = @{
    Server = 'na.myconnectwise.net'
    Company = 'MyCompany'
    PubKey = $env:CWM_PUBKEY
    PrivateKey = $env:CWM_PRIVATEKEY
    ClientID = 'MyScript'
}
Connect-CWM @SecureParams
```

Uses environment variables to avoid hardcoding credentials in scripts.

### EXAMPLE 6
```
Connect-CWM -Server 'na.myconnectwise.net' -Company 'MyCompany' -PubKey $Pub -PrivateKey $Priv -ClientID $ClientID -AllowInsecureRedirect
```

Connects to a ConnectWise-hosted instance and enables the workaround for the PowerShell 7.4+
"Cannot follow an insecure redirection" error on New-/Update-CWM* commands.

## PARAMETERS

### -Server
The ConnectWise Manage server hostname.
Examples: 'na.myconnectwise.net', 'api-aus.myconnectwise.net', 'connectwise.company.com'
Pass only the hostname, optionally with a port ('cw.company.com:8443').
A leading scheme (https://)
and everything from the first '/' on are stripped, so a URL pasted from the browser
('https://na.myconnectwise.net/v4_6_release/ConnectWise.aspx?locale=en_US#startscreen') works.
Requests always use https.
A host part with user info, a query, a fragment or a backslash (the characters '@', '?', '#' or '\'
before the first '/') is rejected.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Company
The ConnectWise Manage company identifier (company name/ID used during login).
This is the company name shown on the login screen.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PubKey
The public key component of API key authentication.
Used with -PrivateKey for API Key or Impersonation authentication methods.
API keys can be generated in ConnectWise Manage under:
System \> Members \> API Keys (or API Members)

```yaml
Type: System.String
Parameter Sets: Impersonation, API Key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrivateKey
The private key component of API key authentication.
Used with -PubKey for API Key or Impersonation authentication methods.
Keep this value secure - treat it like a password.

```yaml
Type: System.String
Parameter Sets: Impersonation, API Key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientID
The unique identifier for your application or integration, sent in the ClientID header.
Register your application at: https://developer.connectwise.com/ClientID
(requires a ConnectWise Developer login)

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credentials
PSCredential object containing username and password.
Used exclusively for Cookie authentication method.
Create with: Get-Credential or \[PSCredential\]::new()

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: Cookie
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberID
The identifier of the member to impersonate, e.g.
'jsmith'.
Used with -PubKey and -PrivateKey.
Connect-CWM uses the API keys to request a token for this member
(POST /system/members/{MemberID}/tokens) and then sends EVERY request as that member: records are
created and changed in the member's name, and the member's security roles decide what is allowed.
The connection expires when the token expires; Connect-CWM then connects again.
If the token cannot be issued, Connect-CWM fails and no connection is stored.

Changed in 0.5.0: version 0.4.16 accepted -MemberID but silently connected with the API key
instead, so requests ran as the API member.
Scripts that pass -MemberID now really act as that member.

```yaml
Type: System.String
Parameter Sets: Impersonation
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces a new connection even if a valid cached connection exists.
By default, a connection to the same server and company, with the same sign-in method (API key,
impersonation of the same member, or cookie), is reused without contacting the server.
A different
server, company, sign-in method or impersonated member always connects again, with or without -Force.
Use -Force to refresh the connection or to switch API keys or credentials on the same server and company.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -BasePath
The base API path on the server.
Default: 'apis/3.0'
Only change this if using a non-standard API endpoint configuration.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Apis/3.0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowInsecureRedirect
Compatibility workaround for ConnectWise-hosted (cloud) instances on PowerShell 7.4 and later.

Some ConnectWise-hosted servers answer create/update requests with an http:// Location header.
PowerShell 7.4+ treats any such header as an insecure redirection and throws "Cannot follow an
insecure redirection by default", typically after the server has already processed the request
(so the record may exist even though an error was shown).

When this switch is set, create/update/delete requests suppress that check AND stop following
redirects entirely (-MaximumRedirection 0).
A real redirect is therefore never followed, so
requests and session cookies are never sent over plain http; instead a genuine redirect
response is reported as an error.
Read (GET) requests are unaffected.

Has no effect on Windows PowerShell 5.1 or PowerShell 7.0-7.3, which do not perform this check.
Can be applied to an existing connection without -Force.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. This function does not accept pipeline input.
## OUTPUTS

### None. Connection information is stored in script-scoped variable $CWMServerConnection.
## NOTES
Author: Chris Taylor

Connection Lifecycle:
- Connections persist for the PowerShell session duration
- Only impersonation connections expire (when the impersonation token expires); API key and
  cookie connections are reused until Disconnect-CWM or -Force
- A cached connection is reused only for the same server, company, sign-in method, impersonated member,
  ClientID and BasePath; connecting to another tenant replaces it
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

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

[https://developer.connectwise.com/ClientID](https://developer.connectwise.com/ClientID)

[Disconnect-CWM]()

[Get-CWMSystemInfo]()

