---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMKnowledgeBaseArticle

## SYNOPSIS
Updates a knowledge base article in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMKnowledgeBaseArticle [-id] <Int32> [-Operation] <String> [-Path] <String> [[-Value] <Object>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMKnowledgeBaseArticle [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing knowledge base article.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.

This function calls the ConnectWise Manage API endpoint: PATCH /service/knowledgeBaseArticles/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'resolution' -Value 'Reinstall the client, then reboot.'
```

Replaces the resolution text of article 42.

### EXAMPLE 2
```
Update-CWMKnowledgeBaseArticle -id 42 -Operation replace -Path 'title' -Value 'Reset VPN client' -WhatIf
```

Shows the request that would be sent without changing the article.

### EXAMPLE 3
```
Update-CWMKnowledgeBaseArticle -id 42 -PatchOperations @(
    @{ op = 'replace'; path = 'title'; value = 'Reset VPN client' }
    @{ op = 'replace'; path = 'resolution'; value = 'Reinstall the client, then reboot.' }
)
```

Changes the title and resolution of article 42 in one request.

## PARAMETERS

### -id
The ID of the knowledge base article to update (required).
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

### -Operation
The patch operation to perform: 'add', 'replace' or 'remove'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The article property to change, for example 'title' or 'resolution'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The new value for the property.
Required for 'add' and 'replace'; not needed for 'remove'.
Use -Value $null to set the property to null.

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PatchOperations
Several patch operations to apply in one request.
Each is a hashtable or PSCustomObject with
op, path and (except for 'remove') value.
'value' is left out of 'remove' operations.

```yaml
Type: System.Object[]
Parameter Sets: Bulk
Aliases:

Required: True
Position: Named
Default value: None
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
### Returns the updated knowledge base article.
## NOTES
Endpoint: PATCH /service/knowledgeBaseArticles/{id}

Requested in GitHub issue #59.

## RELATED LINKS

[Get-CWMKnowledgeBaseArticle]()

[New-CWMKnowledgeBaseArticle]()

[Remove-CWMKnowledgeBaseArticle]()

[https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles](https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles)

