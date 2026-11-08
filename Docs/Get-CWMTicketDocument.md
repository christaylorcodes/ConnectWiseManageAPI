---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Get-CWMTicketDocument

## SYNOPSIS
Gets the documents attached to a service ticket.

## SYNTAX

```
Get-CWMTicketDocument [-parentId] <Int32> [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the full documents attached to a service ticket.
Calls
GET /system/documents?recordType=Ticket&recordId={parentId} through Get-CWMDocument; -count calls
/system/documents/count.

GET /service/tickets/{id}/documents is not used: it returns only id references, and the ConnectWise API
documentation points to this /system/documents query instead.
Download a document's content with
Get-CWMDocument -id \<id\> -download.

## EXAMPLES

### EXAMPLE 1
```
Get-CWMTicketDocument -ticketId 1234 -all
```

Retrieves every document attached to ticket 1234.

### EXAMPLE 2
```
Get-CWMTicketDocument -ticketId 1234 | ForEach-Object { Get-CWMDocument -id $_.id -download -OutFile "C:\Temp\$($_.fileName)" }
```

Saves every document of ticket 1234 to C:\Temp.

## PARAMETERS

### -parentId
The id of the service ticket.
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
Return only the number of matching documents instead of the records.

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
Filter in ConnectWise Manage condition syntax, for example "title contains 'invoice'".

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
Sort order as 'field asc' or 'field desc', for example 'id desc'.

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
Filter on child (list) fields, in condition syntax.

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
Filter on custom field values, in condition syntax.

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
The page number to return.
Use with -pageSize.

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
The number of records per page.
Without it the API's default page size applies.

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
Only return these fields, for example @('id', 'title').

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
Retrieve every matching record, handling pagination automatically.

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

## NOTES

## RELATED LINKS

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

