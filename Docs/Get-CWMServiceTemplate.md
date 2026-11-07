---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version: https://developer.connectwise.com/manage/rest#/ServiceTemplates
schema: 2.0.0
---

# Get-CWMServiceTemplate

## SYNOPSIS
Retrieves service templates from ConnectWise Manage.

## SYNTAX

```
Get-CWMServiceTemplate [[-id] <Int32>] [-count] [[-condition] <String>] [[-orderBy] <String>]
 [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>] [[-pageSize] <Int32>]
 [[-fields] <String[]>] [-all] [<CommonParameters>]
```

## DESCRIPTION
Gets service ticket templates from ConnectWise Manage.
Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

This function calls the ConnectWise Manage API endpoint: GET /service/templates

## EXAMPLES

### EXAMPLE 1
```
Get-CWMServiceTemplate -all
```

Retrieves every service template.

### EXAMPLE 2
```
Get-CWMServiceTemplate -id 15
```

Retrieves service template 15.

### EXAMPLE 3
```
Get-CWMServiceTemplate -condition "name contains 'Onboarding'" -fields @('id', 'name')
```

Retrieves the ID and name of templates whose name contains 'Onboarding'.

## PARAMETERS

### -id
The unique identifier of a specific service template.
When specified, returns only that template (GET /service/templates/{id}).
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching templates (GET /service/templates/count).

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
Filter templates using ConnectWise Manage condition syntax.
Format: "field operator value"
Example: "name contains 'Onboarding'"

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
Example: "name asc"

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
Example: @('id', 'name')

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
Retrieve all matching templates by automatically handling pagination.

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
### Returns service template objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /service/templates
- GET /service/templates/{id}
- GET /service/templates/count

Originally proposed by jadamwilson in PR #77

## RELATED LINKS

[https://developer.connectwise.com/manage/rest#/ServiceTemplates](https://developer.connectwise.com/manage/rest#/ServiceTemplates)

