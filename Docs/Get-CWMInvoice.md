---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/Invoices
schema: 2.0.0
---

# Get-CWMInvoice

## SYNOPSIS
Retrieves invoices from ConnectWise Manage.

## SYNTAX

```
Get-CWMInvoice [[-id] <Int32>] [-pdf] [[-OutFile] <String>] [-count] [[-condition] <String>]
 [[-orderBy] <String>] [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets finance invoices from ConnectWise Manage.
Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /finance/invoices

## EXAMPLES

### EXAMPLE 1
```
Get-CWMInvoice -id 1001
```

Retrieves invoice 1001.

### EXAMPLE 2
```
Get-CWMInvoice -condition "company/id=250" -orderBy "id desc" -all
```

Retrieves every invoice for company 250, newest first.

### EXAMPLE 3
```
Get-CWMInvoice -condition "company/id=250" -count
```

Returns the number of invoices for company 250.

### EXAMPLE 4
```
Get-CWMInvoice -id 1001 -pdf -OutFile 'C:\Temp\Invoice-1001.pdf'
```

Saves invoice 1001 as a PDF.

## PARAMETERS

### -id
The unique identifier of a specific invoice.
When specified, returns only that invoice (GET /finance/invoices/{id}).
Alias: invoiceId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: invoiceId

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -pdf
With -id, download the invoice as a PDF (GET /finance/invoices/{id}/pdf).
Returns the PDF as a byte
array, or writes it to -OutFile.

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

### -OutFile
With -id -pdf, write the PDF to this path and return the file instead of the bytes.

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

### -count
Returns only the count of matching invoices (GET /finance/invoices/count).

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
Filter invoices using ConnectWise Manage condition syntax.
Format: "field operator value"
Operators: =, !=, \<, \>, \<=, \>=, contains, like, in
Multiple conditions can be combined with 'and' or 'or'
Example: "company/id=250"

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
Example: @('id', 'invoiceNumber', 'company', 'total')

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
Retrieve all matching invoices by automatically handling pagination.
Makes multiple API calls if necessary.
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
### Returns invoice objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /finance/invoices
- GET /finance/invoices/{id}
- GET /finance/invoices/count
- GET /finance/invoices/{id}/pdf

Originally proposed by jadamwilson in PR #77

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/Invoices](https://developer.connectwise.com/manage/rest#/Invoices)

