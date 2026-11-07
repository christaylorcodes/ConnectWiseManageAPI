---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMDocument

## SYNOPSIS
Uploads a document or links a URL to a ConnectWise Manage record.

## SYNTAX

### URL
```
New-CWMDocument -recordType <String> -recordId <Int32> -title <String> -URL <String> [-Private <Boolean>]
 [-ReadOnly <Boolean>] [-isAvatar <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### File
```
New-CWMDocument -recordType <String> -recordId <Int32> -title <String> -FilePath <FileInfo>
 [-FileName <String>] [-Private <Boolean>] [-ReadOnly <Boolean>] [-isAvatar <Boolean>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a document attached to a record (ticket, company, project, ...).
Either uploads a
local file (-FilePath) or links a URL (-URL).

The request is sent as multipart/form-data.
The body is built as a byte array: the form
fields and part headers are UTF-8 text and the file content is copied byte for byte, so
binary files upload unchanged on both Windows PowerShell 5.1 and PowerShell 7.

This function calls the ConnectWise Manage API endpoint: POST /system/documents

## EXAMPLES

### EXAMPLE 1
```
New-CWMDocument -recordType Ticket -recordId 12345 -title 'Screenshot' -FilePath 'C:\Temp\error.png'
```

Uploads error.png to ticket 12345.

### EXAMPLE 2
```
New-CWMDocument -recordType Company -recordId 250 -title 'Runbook' -URL 'https://wiki.example.com/runbook'
```

Links a URL to company 250.

## PARAMETERS

### -recordType
The type of record to attach the document to, e.g.
'Ticket', 'Company' or 'Project'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recordId
The ID of the record to attach the document to.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
The title of the document.
Line breaks are replaced with a space.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -URL
A URL to link instead of uploading a file.

```yaml
Type: System.String
Parameter Sets: URL
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Path to the local file to upload.
Must be a file, not a folder.

```yaml
Type: System.IO.FileInfo
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
The file name to send to ConnectWise Manage.
Defaults to the name of -FilePath.
Double quotes, carriage returns and line feeds are replaced with '_'.

```yaml
Type: System.String
Parameter Sets: File
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Private
Whether the document is private.
Default: $true

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReadOnly
Whether the document is read-only.
Default: $false

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -isAvatar
Whether the document is an avatar image.
Default: $false

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

## RELATED LINKS

[Get-CWMDocument]()

[Remove-CWMDocument]()

[https://developer.connectwise.com/Products/ConnectWise_PSA/REST](https://developer.connectwise.com/Products/ConnectWise_PSA/REST)

