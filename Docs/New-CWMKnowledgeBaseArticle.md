---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# New-CWMKnowledgeBaseArticle

## SYNOPSIS
Creates a knowledge base article in ConnectWise Manage.

## SYNTAX

```
New-CWMKnowledgeBaseArticle [-title] <String> [-issue] <String> [-resolution] <String> [[-locationId] <Int32>]
 [[-businessUnitId] <Int32>] [[-board] <Hashtable>] [[-categoryId] <Int32>] [[-subCategoryId] <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new knowledge base article in the ConnectWise Manage service module.
The bound parameters are sent as the JSON body of the request.

This function calls the ConnectWise Manage API endpoint: POST /service/knowledgeBaseArticles

## EXAMPLES

### EXAMPLE 1
```
New-CWMKnowledgeBaseArticle -title 'Reset VPN client' -issue 'VPN client will not connect' -resolution 'Reinstall the client and reboot.'
```

Creates a new knowledge base article.

### EXAMPLE 2
```
$Article = @{
    title      = 'Printer offline'
    issue      = 'Printer shows offline on all workstations'
    resolution = 'Power cycle the printer and re-add the port.'
    board      = @{ id = 1 }
}
New-CWMKnowledgeBaseArticle @Article
```

Creates an article linked to service board 1 using splatting.

## PARAMETERS

### -title
The title of the article (required).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -issue
The issue or problem the article describes (required).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -resolution
The resolution or answer for the issue (required).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -locationId
The ID of the location the article belongs to.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -businessUnitId
The ID of the business unit the article belongs to.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -board
A reference to the service board for the article.
Example: @{ id = 1 }

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -categoryId
The ID of the knowledge base category.

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

### -subCategoryId
The ID of the knowledge base sub-category.

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

### PSCustomObject
### Returns the created knowledge base article.
## NOTES
Endpoint: POST /service/knowledgeBaseArticles

Requested in GitHub issue #59.

## RELATED LINKS

[Get-CWMKnowledgeBaseArticle]()

[Update-CWMKnowledgeBaseArticle]()

[Remove-CWMKnowledgeBaseArticle]()

[https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles](https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles)

