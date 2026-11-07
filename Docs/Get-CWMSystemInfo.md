---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Get-CWMSystemInfo

## SYNOPSIS
Gets ConnectWise Manage system information.

## SYNTAX

```
Get-CWMSystemInfo [<CommonParameters>]
```

## DESCRIPTION
Retrieves the system information of the connected ConnectWise Manage server, such as the version,
whether it is a cloud server and its time zone.
Calls GET /system/info.

## EXAMPLES

### EXAMPLE 1
```
(Get-CWMSystemInfo).version
```

Returns the version of the connected ConnectWise Manage server.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

