---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://marketplace.connectwise.com/docs/redoc/manage/company.html#tag/ContactCommunications/paths/~1company~1contacts~1{id}~1communications/post
schema: 2.0.0
---

# New-CWMDocument

## SYNOPSIS
Will allow you to upload a document and attach it to an item.

## SYNTAX

```
New-CWMDocument [-recordType] <String> [-recordId] <Int32> [-title] <String> [-FilePath] <FileInfo>
 [[-FileName] <String>] [[-Private] <Boolean>] [[-ReadOnly] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Will allow you to upload a document and attach it to an item. You can also set some permissions for the document.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-CWMDocument -recordType 'Ticket' -recordId 123 -title 'NewDoc' -FilePath 'C:\temp\test.txt'
```

Will upload test.txt to the ticket 123 with a title of NewDoc.

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

### -FileName
Name of the file when uploaded. Will default to the original file name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Full path to the file to be uploaded.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Private
If true the document will not be shown in the customer portal.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadOnly
If true only the owner can update the file.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

### -recordId
The ID of the item you are attaching the document to.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordType
The type of record are you trying to attach the document to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Ticket, Agreement, Company, Configuration, Contact, Expense, Opportunity, PurchaseOrder, Project, SalesOrder, ServiceTemplate, Rma

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
Title of the uploaded document.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES
Author: Chris Taylor Date: 7/2/2020

## RELATED LINKS

[https://developer.connectwise.com/Products/Manage/REST#/Documents/getSystemDocumentsUploadsample](https://developer.connectwise.com/Products/Manage/REST#/Documents/getSystemDocumentsUploadsample)
