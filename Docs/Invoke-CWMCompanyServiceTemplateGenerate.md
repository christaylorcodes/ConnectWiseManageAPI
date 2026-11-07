---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMCompanyServiceTemplateGenerate

## SYNOPSIS
Runs the 'generate' action of a company service template in ConnectWise Manage.

## SYNTAX

```
Invoke-CWMCompanyServiceTemplateGenerate [-parentId] <Int32> [-id] <Int32>
 [[-generateAllRecordsFlag] <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Calls the 'generate' action of a company service template.
The body contains
generateAllRecordsFlag when it is specified, otherwise it is an empty JSON object.

This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/generate

## EXAMPLES

### EXAMPLE 1
```
Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15
```

Runs the generate action for service template 15 of company 250.

### EXAMPLE 2
```
Invoke-CWMCompanyServiceTemplateGenerate -parentId 250 -id 15 -generateAllRecordsFlag $true
```

Runs the generate action with generateAllRecordsFlag set to true.

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
The ID of the company service template (required).
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

### -generateAllRecordsFlag
Sent as generateAllRecordsFlag in the request body.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

### PSCustomObject
### Returns the API response, when there is one.
## NOTES
Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/generate

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMCompanyServiceTemplate]()

[Invoke-CWMNewMaster]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

