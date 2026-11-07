---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Tickets
schema: 2.0.0
---

# Get-CWMTicket

## SYNOPSIS
Retrieves service tickets from ConnectWise Manage.

## SYNTAX

```
Get-CWMTicket [[-id] <Int32>] [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets service ticket information from ConnectWise Manage using either direct ID lookup
or advanced search capabilities.
Supports filtering, pagination, field selection, and
custom field queries.

This function automatically selects the appropriate API endpoint:
- Uses /service/tickets for direct ID lookup or count requests
- Uses /service/tickets/search for filtered queries

This function calls the ConnectWise Manage API endpoint: /service/tickets

## EXAMPLES

### EXAMPLE 1
```
Get-CWMTicket -id 12345
```

Retrieves the ticket with ID 12345.

### EXAMPLE 2
```
Get-CWMTicket -condition "status/name='Open'" -all
```

Retrieves all open tickets across all pages.

### EXAMPLE 3
```
Get-CWMTicket -condition "company/id=250 and status/name='Open'" -orderBy "id desc"
```

Gets all open tickets for company ID 250, sorted by ticket ID descending.

### EXAMPLE 4
```
Get-CWMTicket -condition "board/id=1" -fields @('id', 'summary', 'status', 'priority') -all
```

Retrieves all tickets on board 1, returning only specific fields.

### EXAMPLE 5
```
Get-CWMTicket -condition "summary contains 'email'" -pageSize 50 -page 1
```

Gets the first 50 tickets with 'email' in the summary.

### EXAMPLE 6
```
$ticketCount = Get-CWMTicket -condition "status/name='New'" -count
Write-Host "There are $ticketCount new tickets"
```

Gets the count of all tickets with status 'New'.

### EXAMPLE 7
```
[2024-01-01T00:00:00Z]" -all
```

Gets all tickets created after January 1, 2024.

### EXAMPLE 8
```
Get-CWMTicket -customFieldConditions "caption='Priority Level' and value='Critical'" -all
```

Gets all tickets where the custom field 'Priority Level' equals 'Critical'.

### EXAMPLE 9
```
# Get all tickets for multiple statuses
Get-CWMTicket -condition "status/name in ('Open','In Progress','Waiting')" -all
```

Retrieves tickets with any of the specified statuses.

## PARAMETERS

### -id
The unique identifier for a specific ticket.
When specified, returns only the ticket with this ID.
Alias: ticketId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: ticketId

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching tickets instead of ticket data.
Useful for checking result set size before retrieving full data.

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
Filter tickets using ConnectWise Manage condition syntax.
Format: "field operator value"
Operators: =, !=, \<, \>, \<=, \>=, contains, like, in
Multiple conditions can be combined with 'and' or 'or'

Examples:
- "status/name='Open'"
- "summary contains 'password reset'"
- "company/id=123 and priority/id\>=3"
- "board/id=1 and status/name='In Progress'"

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
Examples: "id desc", "dateEntered asc", "summary asc"

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
Example: "contact/id=456"

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
Example: "caption='Environment' and value='Production'"

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
Default: 1

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
If not specified, the API's default page size is used.
The module does not enforce a maximum;
the API applies its own limit.

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
Reduces response size and improves performance by only returning needed fields.
Example: @('id', 'summary', 'status', 'company', 'board')

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
Retrieve all matching tickets by automatically handling pagination.
Makes multiple API calls if necessary to retrieve all records.
Use with caution on large datasets.

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
### Returns ticket objects with properties like id, summary, status, company, board, etc.
### Or returns an integer if -count is specified.
## NOTES
Author: Chris Taylor

Endpoint Selection:
- Direct ID lookup uses GET /service/tickets/{id}; count uses GET /service/tickets/count
- All other queries use POST /service/tickets/search

Performance Tips:
- Use -fields to request only needed data
- Use -count to check result size before retrieving full data
- Be cautious with -all on large datasets
- Use specific conditions to narrow results

Common Filters:
- By status: "status/name='Open'"
- By board: "board/id=1"
- By company: "company/id=123"
- By priority: "priority/id\>=3"
- By date range: "dateEntered \> \[2024-01-01T00:00:00Z\]"

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Tickets](https://developer.connectwise.com/manage/rest#/Tickets)

[New-CWMTicket]()

[Update-CWMTicket]()

[Remove-CWMTicket]()

