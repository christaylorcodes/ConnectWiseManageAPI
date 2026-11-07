---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMOpportunityNote

## SYNOPSIS
Retrieves the notes on a sales opportunity in ConnectWise Manage.

## SYNTAX

```
Get-CWMOpportunityNote [-parentId] <Int32> [[-id] <Int32>] [-count] [[-condition] <String>]
 [[-orderBy] <String>] [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets the notes attached to a sales opportunity.
Supports direct note ID lookup, filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /sales/opportunities/{parentId}/notes

## EXAMPLES

### EXAMPLE 1
```
Get-CWMOpportunityNote -parentId 500 -all
```

Retrieves every note on opportunity 500.

### EXAMPLE 2
```
Get-CWMOpportunityNote -opportunityId 500 -condition "text contains 'pricing'"
```

Retrieves notes on opportunity 500 that mention pricing.

### EXAMPLE 3
```
Get-CWMOpportunityNote -parentId 500 -id 12
```

Retrieves note 12 on opportunity 500.

## PARAMETERS

### -parentId
The ID of the opportunity whose notes to retrieve (required).
Alias: opportunityId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: opportunityId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of a specific note on the opportunity.
When specified, returns only that note (GET /sales/opportunities/{parentId}/notes/{id}).
Alias: noteId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: noteId

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching notes (GET /sales/opportunities/{parentId}/notes/count).

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
Example: "text contains 'pricing'"

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

### -orderBy
Sort results by specified field and direction.
Format: "fieldName asc" or "fieldName desc"
Example: "id desc"

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

### -childConditions
Filter results based on child record criteria.
Uses same condition syntax as -condition parameter.

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

### -customFieldConditions
Filter results based on custom field values.
Format: "caption='FieldName' and value='FieldValue'"

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 7
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
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -fields
Specify which fields to return in the response.
Example: @('id', 'text')

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
### Returns opportunity note objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /sales/opportunities/{parentId}/notes
- GET /sales/opportunities/{parentId}/notes/{id}
- GET /sales/opportunities/{parentId}/notes/count

Originally proposed by jadamwilson in PR #77

## RELATED LINKS

[Get-CWMOpportunity]()

[https://developer.connectwise.com/manage/rest#/OpportunityNotes](https://developer.connectwise.com/manage/rest#/OpportunityNotes)

