---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMTicketNote

## SYNOPSIS
Add a note to a CW Manage ticket.

## SYNTAX

```
New-CWMTicketNote -parentId <Int32> [[-id] <Int32>] [[-text] <String>] [[-detailDescriptionFlag] <Boolean>]
 [[-internalAnalysisFlag] <Boolean>] [[-resolutionFlag] <Boolean>] [[-member] <Hashtable>]
 [[-contact] <Hashtable>] [[-customerUpdatedFlag] <Boolean>] [[-processNotifications] <Boolean>]
 [[-dateCreated] <String>] [[-createdBy] <String>] [[-internalFlag] <Boolean>] [[-externalFlag] <Boolean>]
 [[-_info] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add a note to a ticket.

## EXAMPLES

### EXAMPLE 1
```powershell
New-CWMTicketNote -ticketId $Ticket.id -text 'New note' -detailDescriptionFlag $true -internalFlag $false -resolutionFlag $false
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
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -contact
{{ Fill contact Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -createdBy
{{ Fill createdBy Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customerUpdatedFlag
{{ Fill customerUpdatedFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -dateCreated
{{ Fill dateCreated Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -detailDescriptionFlag
A boolean value that determines if the note should appear in the discussion tab.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -externalFlag
{{ Fill externalFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalAnalysisFlag
{{ Fill internalAnalysisFlag Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -internalFlag
A boolean value that determines if the note should appear in the internal tab.


```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -member
{{ Fill member Description }}

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

### -processNotifications
{{ Fill processNotifications Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolutionFlag
A boolean value that determines if the note should appear in the Resolution tab.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -text
{{ Fill text Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### -parentId
The ticket id to attach the internal note to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: ticketId

Required: True
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
Date: 1/21/2019

## RELATED LINKS

[https://developer.connectwise.com/products/manage/rest?a=Service&e=TicketNotes&o=CREATE](https://developer.connectwise.com/products/manage/rest?a=Service&e=TicketNotes&o=CREATE)