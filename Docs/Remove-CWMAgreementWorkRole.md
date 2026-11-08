---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Remove-CWMAgreementWorkRole

## SYNOPSIS
Deletes an agreement work role rate of an agreement.

## SYNTAX

```
Remove-CWMAgreementWorkRole [-parentId] <Int32> [-id] <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an agreement work role rate from ConnectWise Manage.
Calls DELETE /finance/agreements/{parentId}/workroles/{id}.

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMAgreementWorkRole -parentId 12 -id 5
```

Deletes agreement work role rate 5 of agreement 12.

## PARAMETERS

### -parentId
The id of the agreement.
Alias: agreementId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: agreementId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id of the agreement work role rate to delete.
Alias: agreementWorkRoleId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: agreementWorkRoleId

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

