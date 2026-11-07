---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMProjectTicketAllNote

## SYNOPSIS
Retrieves all notes on a project ticket in ConnectWise Manage.

## SYNTAX

```
Get-CWMProjectTicketAllNote [-parentId] <Int32> [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets the combined notes list for a project ticket from the allNotes endpoint.
This is the project-ticket counterpart of Get-CWMTicketAllNote.
Supports filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /project/tickets/{parentId}/allNotes

## EXAMPLES

### EXAMPLE 1
```
Get-CWMProjectTicketAllNote -parentId 9876 -all
```

Retrieves all notes on project ticket 9876.

### EXAMPLE 2
```
Get-CWMProjectTicketAllNote -ticketId 9876 -orderBy "id desc" -pageSize 10
```

Retrieves the ten most recent notes on project ticket 9876.

## PARAMETERS

### -parentId
The ID of the project ticket whose notes to retrieve (required).
Alias: ticketId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ticketId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching notes.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -condition
Filter notes using ConnectWise Manage condition syntax.
Format: "field operator value"
Example: "text contains 'reboot'"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -orderBy
Sort results by specified field and direction.
Format: "fieldName asc" or "fieldName desc"
Example: "id desc"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -childConditions
Filter results based on child record criteria.
Uses same condition syntax as -condition parameter.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customFieldConditions
Filter results based on custom field values.
Format: "caption='FieldName' and value='FieldValue'"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -page
The page number to retrieve (used with -pageSize for pagination).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pageSize
Number of records to return per page.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Specify which fields to return in the response.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Retrieve all matching notes by automatically handling pagination.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

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

### PSCustomObject or PSCustomObject[]
### Returns note objects, or an integer if -count is specified.
## NOTES
Endpoint: GET /project/tickets/{parentId}/allNotes

The API publishes only the list form and GET /project/tickets/{parentId}/allNotes/count
(used by -count); there is no /allNotes/{id}, so there is no -id parameter.

Originally proposed by jadamwilson in PR #77

## RELATED LINKS

[Get-CWMProjectTicket]()

[Get-CWMTicketAllNote]()

[https://developer.connectwise.com/manage/rest#/ProjectTicketNotes](https://developer.connectwise.com/manage/rest#/ProjectTicketNotes)

