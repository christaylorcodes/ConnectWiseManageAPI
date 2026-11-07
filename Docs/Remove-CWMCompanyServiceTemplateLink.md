---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMCompanyServiceTemplateLink

## SYNOPSIS
Unlinks a company service template in ConnectWise Manage.

## SYNTAX

```
Remove-CWMCompanyServiceTemplateLink [-parentId] <Int32> [-id] <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Calls the 'unlink' action of a company service template.
The request is a POST with no body;
the template itself is not deleted (use Remove-CWMCompanyServiceTemplate for that).

This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/unlink

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMCompanyServiceTemplateLink -parentId 250 -id 15
```

Unlinks service template 15 of company 250.

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
Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/unlink

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Add-CWMCompanyServiceTemplateLink]()

[Remove-CWMCompanyServiceTemplate]()

[Invoke-CWMActionMaster]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

