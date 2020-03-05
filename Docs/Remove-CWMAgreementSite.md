---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMAgreementSite

## SYNOPSIS
This function will remove a site from a Manage agreement.

## SYNTAX

```
Remove-CWMAgreementSite [-AgreementID] <Int32> [-SiteID] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-CWMAgreementSite -AgreementID 123 -SiteID 123
```

## PARAMETERS

### -AgreementID
The ID of the agreement you want to remove sites from.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: 0
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteID
The ID of the site you want to remove from the agreement.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
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
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 9/19/2019

## RELATED LINKS

[https://marketplace.connectwise.com/docs/redoc/manage/finance.html#tag/AgreementSites/paths/~1finance~1agreements~1{id}~1sites~1{siteId}/delete](https://marketplace.connectwise.com/docs/redoc/manage/finance.html#tag/AgreementSites/paths/~1finance~1agreements~1{id}~1sites~1{siteId}/delete)

