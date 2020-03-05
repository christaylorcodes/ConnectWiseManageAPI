---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMCompanyTypeAssociation

## SYNOPSIS
This function will remove a type from a company.

## SYNTAX

```
Remove-CWMCompanyTypeAssociation [-CompanyID] <Int32> [-TypeAssociationID] <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-CWMCompanyConfiguration -CompanyConfigurationID 123
```

## PARAMETERS

### -CompanyID
The ID of the company configuration that you want to delete.

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

### -TypeAssociationID
The ID of the company configuration that you want to delete.

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
Author: Chris Taylor Date: 7/3/2017

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=DELETE](https://developer.connectwise.com/Products/Manage/REST?a=Company&e=CompanyCompanyTypeAssociations&o=DELETE)

