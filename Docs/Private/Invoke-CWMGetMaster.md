---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Invoke-CWMGetMaster

## SYNOPSIS
This will be basis of all get calls to the ConnectWise Manage API.

## SYNTAX

```
Invoke-CWMGetMaster [[-Arguments] <Object>] [[-URI] <String>] [<CommonParameters>]
```

## DESCRIPTION
This will insure that all GET requests are handled correctly.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-CWMGetMaster -Arguments $Arguments -URI $URI
```

## PARAMETERS

### -Arguments
A hash table of parameters

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

### -URI
The URI of the GET endpoint

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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

Author: Chris Taylor
Update Date: 9/26/2019
Purpose/Change: changed orderBy support, improved url query string creation

## RELATED LINKS

[https://developer.connectwise.com/Manage/Developer_Guide#Authentication](https://developer.connectwise.com/Manage/Developer_Guide#Authentication)

