---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Get-CWMCompanyServiceTemplate

## SYNOPSIS
Retrieves the service templates of a company in ConnectWise Manage.

## SYNTAX

```
Get-CWMCompanyServiceTemplate [-parentId] <Int32> [[-id] <Int32>] [-count] [[-condition] <String>]
 [[-orderBy] <String>] [[-childConditions] <String>] [[-customFieldConditions] <String>] [[-page] <Int32>]
 [[-pageSize] <Int32>] [[-fields] <String[]>] [[-pageId] <Int32>] [-all]
 [<CommonParameters>]
```

## DESCRIPTION
Gets the service (ticket) templates attached to a company.
Supports direct ID lookup, filtering, sorting, pagination, field selection and counts.

For the system-wide service templates, use Get-CWMServiceTemplate (GET /service/templates).

This function calls the ConnectWise Manage API endpoint: GET /company/companies/{parentId}/serviceTemplates

## EXAMPLES

### EXAMPLE 1
```
Get-CWMCompanyServiceTemplate -parentId 250 -all
```

Retrieves every service template of company 250.

### EXAMPLE 2
```
Get-CWMCompanyServiceTemplate -companyId 250 -templateId 15
```

Retrieves service template 15 of company 250.

## PARAMETERS

### -parentId
The ID of the company (required).
Alias: companyId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: companyId

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
The ID of a specific company service template.
When specified, returns only that template.
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -count
Returns only the count of matching templates.

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
Example: "name contains 'Maintenance'"

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
Example: @('id', 'name')

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
### Returns company service template objects, or an integer if -count is specified.
## NOTES
Endpoints:
- GET /company/companies/{parentId}/serviceTemplates
- GET /company/companies/{parentId}/serviceTemplates/{id}
- GET /company/companies/{parentId}/serviceTemplates/count

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[New-CWMCompanyServiceTemplate]()

[Set-CWMCompanyServiceTemplate]()

[Update-CWMCompanyServiceTemplate]()

[Remove-CWMCompanyServiceTemplate]()

[Get-CWMServiceTemplate]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

