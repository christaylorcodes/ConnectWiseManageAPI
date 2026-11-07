---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest
schema: 2.0.0
---

# Get-CWMDocument

## SYNOPSIS
Gets documents, or downloads a document.

## SYNTAX

### ID
```
Get-CWMDocument [-id <Int32>] [-download] [-OutFile <String>] [-count] [-condition <String>]
 [-orderBy <String>] [-childConditions <String>] [-customFieldConditions <String>] [-page <Int32>]
 [-pageSize <Int32>] [-fields <String[]>] [-all] [<CommonParameters>]
```

### Record
```
Get-CWMDocument -recordId <Int32> -recordType <String> [-count] [-condition <String>] [-orderBy <String>]
 [-childConditions <String>] [-customFieldConditions <String>] [-page <Int32>] [-pageSize <Int32>]
 [-fields <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the documents attached to a record (-recordType and -recordId), the metadata of one document
(-id), or the file content of one document (-id -download).
Calls GET /system/documents, GET
/system/documents/{id}, GET /system/documents/{id}/download or GET /system/documents/count.

## EXAMPLES

### EXAMPLE 1
```
Get-CWMDocument -recordType Ticket -recordId 1234 -all
```

Lists the documents attached to service ticket 1234.

### EXAMPLE 2
```
Get-CWMDocument -id 55 -download
```

Downloads the content of document 55.

## PARAMETERS

### -id
The id of a single document.
Alias: documentId

```yaml
Type: System.Int32
Parameter Sets: ID
Aliases: documentId

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -download
With -id, download the file content of the document (GET /system/documents/{id}/download) instead of its
metadata.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
With -id -download, write the file content to this path and return the file instead of the bytes.

```yaml
Type: System.String
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordId
The id of the record whose documents are returned.
Use with -recordType.

```yaml
Type: System.Int32
Parameter Sets: Record
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordType
The type of the record whose documents are returned, for example Ticket, Company or Opportunity.
Use
with -recordId.

```yaml
Type: System.String
Parameter Sets: Record
Aliases:

Required: True
Position: Named
Default value: None
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
Filter in ConnectWise Manage condition syntax, for example "id\>100".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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

