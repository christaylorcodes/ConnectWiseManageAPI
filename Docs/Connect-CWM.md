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
 -MemberID <String> [-Force] [-Version <String>] [<CommonParameters>]
```

### API Key
```
Connect-CWM -Server <String> -Company <String> -PubKey <String> -PrivateKey <String> -ClientID <String>
 [-Force] [-Version <String>] [<CommonParameters>]
```

### Cookie
```
Connect-CWM -Server <String> -Company <String> -ClientID <String> -Credentials <PSCredential> [-Force]
 [-Version <String>] [<CommonParameters>]
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

### -ClientID
Integration Identifier created by a user.
See [https://developer.connectwise.com/ClientID](https://developer.connectwise.com/ClientID)

```yaml
Type: String
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
Type: String
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
Type: PSCredential
Parameter Sets: Cookie
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
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MemberID
The member that you are impersonating

```yaml
Type: String
Parameter Sets: Impersonation
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
Type: String
Parameter Sets: Impersonation, API Key
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
Type: String
Parameter Sets: Impersonation, API Key
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
The URL of your ConnectWise Mange server.
Example: manage.mydomain.com

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Used to specify a version.
If not used it will use the servers current version.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Variable
$script:CWMServerConnection

## NOTES
Author: Chris Taylor Date: 10/10/2018

Author: Darren White Update Date: 8/8/2019 Purpose/Change: Added support for clientId header

Author: Chris Taylor Update Date: 9/24/2019 Purpose/Change: Added API version support and added parameter validation

## RELATED LINKS

[https://developer.connectwise.com/Manage/Developer_Guide#Authentication](https://developer.connectwise.com/Manage/Developer_Guide#Authentication)
