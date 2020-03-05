---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Invoke-CWMPatchMaster

## SYNOPSIS
This will be basis of all Patch calls to the ConnectWise Manage API.

## SYNTAX

```
Invoke-CWMPatchMaster [[-Arguments] <Object>] [[-URI] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This will insure that all update requests are handled correctly.

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-CWMPatchMaster -Arguments $Arguments -URI $URI
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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URI
The URI of the update endpoint

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

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

## NOTES
Author: Chris Taylor
Date: 10/10/2018

## RELATED LINKS

[https://christaylor.codes](https://christaylor.codes)

