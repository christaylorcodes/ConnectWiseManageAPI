---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/ContactCommunications/paths/~1company~1contacts~1{id}~1communications/post
schema: 2.0.0
---

# New-CWMMarketingGroupCompany

## SYNOPSIS
Adds a company to a marketing group.

## SYNTAX

```
New-CWMMarketingGroupCompany [[-groupId] <Int32>] [[-id] <Int32>] [[-defaultContactFlag] <Boolean>]
 [[-allContactsFlag] <Boolean>] [[-unsubscribeFlag] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Used to add a companied contacts to a marketing group.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> New-CWMMarketingGroupCompany -groupId $Group.id -id $Company.id
```

Will add the company to the marketing manager group.

## PARAMETERS

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

### -allContactsFlag
{{ Fill allContactsFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultContactFlag
{{ Fill defaultContactFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -groupId
The ID of the marketing manager group you want to add the company contacts to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: parentId

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The id of the company you want to add contacts for.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: companyId

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -unsubscribeFlag
{{ Fill unsubscribeFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
