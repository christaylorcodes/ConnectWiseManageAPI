---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMServiceTemplateResource

## SYNOPSIS
Retrieves the resources assigned to a service template in ConnectWise Manage.

## SYNTAX

```
Get-CWMServiceTemplateResource [-parentId] <Int32> [[-id] <Int32>] [-count] [[-condition] <String>]
 [[-orderBy] <String>] [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [[-fields] <String[]>] [[-pageId] <Int32>] [-all]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the resources (members) assigned to a service template.
Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /service/templates/{parentId}/resources

## EXAMPLES

### EXAMPLE 1
```
Get-CWMServiceTemplateResource -parentId 15 -all
```

Retrieves every resource of service template 15.

### EXAMPLE 2
```
Get-CWMServiceTemplateResource -templateId 15 -resourceId 3
```

Retrieves resource 3 of service template 15.

## PARAMETERS

### -parentId
The ID of the service template (required).
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of a specific resource.
When specified, returns only that resource.
Alias: resourceId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: resourceId

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching resources.

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
Filter resources using ConnectWise Manage condition syntax.
Example: "member/identifier='jdoe'"

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

### -pageId
Starts forward-only pagination at the page identified by this value.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
Retrieve all matching resources by automatically handling pagination.

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
### Returns service template resource objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /service/templates/{parentId}/resources
- GET /service/templates/{parentId}/resources/{id}
- GET /service/templates/{parentId}/resources/count

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMServiceTemplate]()

[New-CWMServiceTemplateResource]()

[Set-CWMServiceTemplateResource]()

[Update-CWMServiceTemplateResource]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

