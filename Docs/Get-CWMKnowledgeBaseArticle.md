---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMKnowledgeBaseArticle

## SYNOPSIS
Retrieves knowledge base articles from ConnectWise Manage.

## SYNTAX

```
Get-CWMKnowledgeBaseArticle [[-id] <Int32>] [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets knowledge base articles from the ConnectWise Manage service module.
Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /service/knowledgeBaseArticles

## EXAMPLES

### EXAMPLE 1
```
Get-CWMKnowledgeBaseArticle -id 42
```

Retrieves the knowledge base article with ID 42.

### EXAMPLE 2
```
Get-CWMKnowledgeBaseArticle -condition "title contains 'VPN'" -all
```

Retrieves every knowledge base article whose title contains 'VPN'.

### EXAMPLE 3
```
Get-CWMKnowledgeBaseArticle -count
```

Returns the number of knowledge base articles.

## PARAMETERS

### -id
The unique identifier of a specific knowledge base article.
When specified, returns only that article (GET /service/knowledgeBaseArticles/{id}).
Alias: articleId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: articleId

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching articles instead of the articles themselves
(GET /service/knowledgeBaseArticles/count).

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
Filter articles using ConnectWise Manage condition syntax.
Format: "field operator value"
Operators: =, !=, \<, \>, \<=, \>=, contains, like, in
Multiple conditions can be combined with 'and' or 'or'
Example: "title contains 'VPN'"

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
Example: "id desc"

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
Example: @('id', 'title', 'issue', 'resolution')

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
Retrieve all matching articles by automatically handling pagination.
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
### Returns knowledge base article objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /service/knowledgeBaseArticles
- GET /service/knowledgeBaseArticles/{id}
- GET /service/knowledgeBaseArticles/count

Requested in GitHub issue #59.

## RELATED LINKS

[New-CWMKnowledgeBaseArticle]()

[Update-CWMKnowledgeBaseArticle]()

[Remove-CWMKnowledgeBaseArticle]()

[https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles](https://developer.connectwise.com/manage/rest#/KnowledgeBaseArticles)

