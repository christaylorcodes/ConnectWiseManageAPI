---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Invoke-CWMWebRequest

## SYNOPSIS
This function is used to handle all web requests to the ConnectWise Manage API.

## SYNTAX

```
Invoke-CWMWebRequest [[-Arguments] <Object>] [[-MaxRetry] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This function is used to manage error handling with web requests.
It will also handle retries of failed attempts.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Arguments
A splat object of web request parameters

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxRetry
The maximum number of retry attempts

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor
Date: 10/10/2018

## RELATED LINKS

[https://christaylor.codes](https://christaylor.codes)

