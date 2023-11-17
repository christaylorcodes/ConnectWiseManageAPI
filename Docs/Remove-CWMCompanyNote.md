---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remov-CWMTicketNote

## SYNOPSIS
Remove a note from a CW Manage company.

## SYNTAX

```
Remove-CWMTicketNote -parentId <Int32> [[-id] <Int32>] [[-id] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Remove-CWMCompanyNote -companyId $company.id -id $note.id
```

Create a new note.

## PARAMETERS

### -_info
{{ Fill _info Description }}

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

### -ParentId
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoteId
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)

Required: True
Position: 1
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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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
Author: Ben Craigs
Date: 11/16/2023

## RELATED LINKS

[https://developer.connectwise.com/products/manage/rest?a=Service&e=TicketNotes&o=CREATE](https://developer.connectwise.com/products/manage/rest?a=Service&e=TicketNotes&o=CREATE)