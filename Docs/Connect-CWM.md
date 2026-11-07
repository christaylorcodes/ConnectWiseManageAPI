---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Connect-CWM

## SYNOPSIS
This command is used to authenticate with the Manage server.

## SYNTAX

### Impersonation
```
Connect-CWM -Server <String> -Company <String> -PubKey <String> -PrivateKey <String> -ClientID <String>
 -MemberID <String> [-Force] [-Version <String>] [-BasePath <String>] [-AllowInsecureRedirect]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### API Key
```
Connect-CWM -Server <String> -Company <String> -PubKey <String> -PrivateKey <String> -ClientID <String>
 [-Force] [-Version <String>] [-BasePath <String>] [-AllowInsecureRedirect]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Cookie
```
Connect-CWM -Server <String> -Company <String> -ClientID <String> -Credentials <PSCredential> [-Force]
 [-Version <String>] [-BasePath <String>] [-AllowInsecureRedirect] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
This will create a script variable that contains all needed connection and authorization information.
All other commands from the module will call this variable to get connection information.

## EXAMPLES

### API Key
```powershell
$Connection = @{
    Server = $Server
    Company = $Company
    PubKey = $PubKey
    PrivateKey = $PrivateKey
    ClientID = $ClientID
}
Connect-CWM @Connection
```

In this example we are connecting with an API Key.

Using an API Key is the preferred authentication method.

### Impersonate

```powershell
$Connection = @{
    Server = $Server
    Company = $Company
    PubKey = $PubKey
    PrivateKey = $PrivateKey
    MemberID = $MemberID
    ClientID = $ClientID
}
Connect-CWM @Connection
```

In this example we are connecting with an API key and impersonating another user. $MemberID

### Credentials

```powershell
$Connection = @{
    Server = $Server
    Company = $Company
    Credentials = $Credentials
    ClientID = $ClientID
}
Connect-CWM @Connection
```

In this example we are connecting with a cookie, using user credentials.

This method will not work on accounts with MFA enabled. All your accounts are MFA enabled, right?

This method is going to be removed in future versions. Please move to a different authentication method.

[https://developer.connectwise.com/Products/Manage/Developer_Guide#Authentication](https://developer.connectwise.com/Products/Manage/Developer_Guide#Authentication)

### Force Version

```powershell
$Connection = @{
    Server = $Server
    Company = $Company
    PubKey = $PubKey
    PrivateKey = $PrivateKey
    ClientID = $ClientID
}
Connect-CWM @Connection -Force -Version '3.0.0'
```

In this example we are telling it to ignore any cached connection info and return v3.0.0 objects.

## PARAMETERS

### -Server
The URL of your ConnectWise Mange server.
Example: manage.mydomain.com

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
The login company.

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
Public API key created by a user docs: My Account

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
Private API key created by a user docs: My Account

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
Integration Identifier created by a user.
See [https://developer.connectwise.com/ClientID](https://developer.connectwise.com/ClientID)

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
Manage username and password as a PSCredential object \[pscredential\]. This method will not work on accounts with MFA enabled. All your accounts are MFA enabled, right?

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
The member that you are impersonating

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
Ignore cached information and recreate

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

### -Version
Used to specify a version.
If not used it will use the servers current version.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BasePath
{{ Fill BasePath Description }}

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowInsecureRedirect
Compatibility workaround for ConnectWise-hosted (cloud) instances on PowerShell 7.4 and later.

Some ConnectWise-hosted servers answer create/update requests with an http:// Location header.
PowerShell 7.4+ treats any such header as an insecure redirection and throws "Cannot follow an
insecure redirection by default", even though the request already succeeded on the server.

When this switch is set, create/update/delete requests suppress that check AND stop following
redirects entirely (-MaximumRedirection 0). A real redirect is therefore never followed, so
requests and session cookies are never sent over plain http; instead a genuine redirect
response is reported as an error. Read (GET) requests are unaffected.

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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: System.Management.Automation.ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
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
Author: Chris Taylor Date: 10/10/2018

Author: Darren White Update Date: 8/8/2019 Purpose/Change: Added support for clientId header

Author: Chris Taylor Update Date: 9/24/2019 Purpose/Change: Added API version support and added parameter validation

## RELATED LINKS

[https://developer.connectwise.com/Manage/Developer_Guide#Authentication](https://developer.connectwise.com/Manage/Developer_Guide#Authentication)
