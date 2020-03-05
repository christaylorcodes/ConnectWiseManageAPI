---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMDocument

## SYNOPSIS
This function will list documents associated with a record.

## SYNTAX

```
Get-CWMDocument [[-RecordType] <Object>] [[-RecordID] <Int32>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-pageID] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```powershell
Get-CWMDocuments -RecordType Ticket -RecordID 1836414
```

Will return documents associated with a the ticket 1936414

## PARAMETERS

### -RecordID
The ID of a RecordType specified

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecordType
The type of document you are looking for.
Agreement, Company, Configuration, Contact, Expense, HTMLTemplate, Opportunity, Project, PurchaseOrder, Rma, SalesOrder, Ticket, ServiceTemplate, ToolbarIcon, Meeting, MeetingNote, ProductSetup, ProjectTemplateTicket, WordTemplate, Member, PhaseStatus, ProjectStatus, TicketStatus

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: Agreement, Company, Configuration, Contact, Expense, HTMLTemplate, Opportunity, Project, PurchaseOrder, Rma, SalesOrder, Ticket, ServiceTemplate, ToolbarIcon, Meeting, MeetingNote, ProductSetup, ProjectTemplateTicket, WordTemplate, Member, PhaseStatus, ProjectStatus, TicketStatus

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
Used in pagination to cycle through results

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageID
Used in pagination to request a page by id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
Number of results returned per page (Defaults to 25)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor Date: 8/22/2018

## RELATED LINKS

[https://developer.connectwise.com/manage/rest?a=System&e=Documents&o=GET](https://developer.connectwise.com/manage/rest?a=System&e=Documents&o=GET)

