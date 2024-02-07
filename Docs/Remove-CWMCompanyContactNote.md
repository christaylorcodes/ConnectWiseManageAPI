---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest?a=Company&e=Configurations&o=DELETE
schema: 2.0.0
---

# Remove-CWMCompanyContactNote

## SYNOPSIS
Removes a note from a contact.

## SYNTAX

```
Remove-CWMCompanyContactNote [-parentId] <Int32> [-id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a note via ID from a company contact.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Remove-CWMCompanyContactNote -parentId $Contact.id -id $Note.id
```

Removes the given note from the given contact.

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

### -id
The ID of the note you want removed.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: noteId

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
The ID of the contact you want to remove the note from.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: contactId

Required: True
Position: 0
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
