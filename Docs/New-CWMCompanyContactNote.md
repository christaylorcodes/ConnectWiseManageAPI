---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/ConfigurationTypeQuestionValues/paths/~1company~1configurations~1types~1{configurationTypeId:int}~1questions~1{questionId:int}~1values/post
schema: 2.0.0
---

# New-CWMCompanyContactNote

## SYNOPSIS
This function will create a note on the given contact.

## SYNTAX

```
New-CWMCompanyContactNote [-parentId] <Int32> [[-id] <Int32>] [-text] <String> [[-type] <Hashtable>]
 [[-flagged] <Boolean>] [[-enteredBy] <String>] [[-_info] <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This function will create a note on the given contact.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> New-CWMCompanyContactNote -parentId $Contact.id -text 'This guy rocks!'
```

Will add a note to the given contact.

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

### -_info
Used to give a non-default value for the _info field.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -enteredBy
Used to give a non-default value for the enteredBy field.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -flagged
Used to flag the note.

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

### -id
Dont use.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -parentId
The ID of the contact you want the note associated with.

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

### -text
The text you want in the note.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
Set a type for the note.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
