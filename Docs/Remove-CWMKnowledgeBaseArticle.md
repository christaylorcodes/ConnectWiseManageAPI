---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMKnowledgeBaseArticle

## SYNOPSIS
Deletes a knowledge base article from ConnectWise Manage.

## SYNTAX

```
Remove-CWMKnowledgeBaseArticle [-id] <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Permanently removes a knowledge base article by ID.
Like the other Remove-CWM* functions, it does not prompt by default; use -Confirm to be prompted
or -WhatIf to see what would be deleted.

This function calls the ConnectWise Manage API endpoint: DELETE /service/knowledgeBaseArticles/{id}

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMKnowledgeBaseArticle -id 42 -Confirm
```

Prompts for confirmation, then deletes article 42.

### EXAMPLE 2
```
Remove-CWMKnowledgeBaseArticle -id 42 -WhatIf
```

Shows what would be deleted without deleting it.

## PARAMETERS

### -id
The ID of the knowledge base article to delete (required).
Alias: articleId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: articleId

Required: True
Position: 1
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

## NOTES
Endpoint: DELETE /service/knowledgeBaseArticles/{id}

Requested in GitHub issue #59.

## RELATED LINKS

[Get-CWMKnowledgeBaseArticle]()

[New-CWMKnowledgeBaseArticle]()

[Update-CWMKnowledgeBaseArticle]()

[https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles](https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles)

