---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Update-CWMCompanyServiceTemplate

## SYNOPSIS
Updates a company service template in ConnectWise Manage.

## SYNTAX

### Single (Default)
```
Update-CWMCompanyServiceTemplate [-parentId] <Int32> [-id] <Int32> [-Operation] <String> [-Path] <String>
 [[-Value] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Bulk
```
Update-CWMCompanyServiceTemplate [-parentId] <Int32> [-id] <Int32> -PatchOperations <Object[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Applies JSON Patch operations to an existing company service template.
Use -Operation, -Path and -Value for one change, or -PatchOperations for several changes in one request.
To replace the whole template, use Set-CWMCompanyServiceTemplate.

This function calls the ConnectWise Manage API endpoint: PATCH /company/companies/{parentId}/serviceTemplates/{id}

## EXAMPLES

### EXAMPLE 1
```
Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -Operation replace -Path 'summary' -Value 'Monthly maintenance'
```

Replaces the summary of service template 15 of company 250.

### EXAMPLE 2
```
Update-CWMCompanyServiceTemplate 250 15 replace summary 'Monthly maintenance'
```

The same change, using positional parameters.

### EXAMPLE 3
```
Update-CWMCompanyServiceTemplate -parentId 250 -id 15 -PatchOperations @(
    @{ op = 'replace'; path = 'summary'; value = 'Monthly maintenance' }
    @{ op = 'replace'; path = 'priority'; value = @{ id = 4 } }
)
```

Changes the summary and priority in one request.

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
The ID of the company service template to update (required).
Alias: templateId

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: templateId

Required: True
Position: 2
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The template property to change, for example 'summary' or 'priority'.

```yaml
Type: System.String
Parameter Sets: Single
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
The new value for the property.
Required for 'add' and 'replace'; not needed for 'remove'.
Use -Value $null to set a property to null.

```yaml
Type: System.Object
Parameter Sets: Single
Aliases:

Required: False
Position: 5
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
### Returns the updated company service template.
## NOTES
Endpoint: PATCH /company/companies/{parentId}/serviceTemplates/{id}

Based on PR #82 by mdewart-Centre, which accepted only -PatchOperations; -Operation/-Path/-Value were
added to match the other Update-CWM* functions.

## RELATED LINKS

[Get-CWMCompanyServiceTemplate]()

[Set-CWMCompanyServiceTemplate]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

