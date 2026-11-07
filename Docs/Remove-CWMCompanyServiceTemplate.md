---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Remove-CWMCompanyServiceTemplate

## SYNOPSIS
Removes a service template from a company in ConnectWise Manage.

## SYNTAX

```
Remove-CWMCompanyServiceTemplate [-parentId] <Int32> [-id] <Int32>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a company service template.
Supports -WhatIf and -Confirm.

This function calls the ConnectWise Manage API endpoint: DELETE /company/companies/{parentId}/serviceTemplates/{id}

## EXAMPLES

### EXAMPLE 1
```
Remove-CWMCompanyServiceTemplate -parentId 250 -id 15
```

Deletes service template 15 of company 250.

### EXAMPLE 2
```
Remove-CWMCompanyServiceTemplate -companyId 250 -templateId 15 -WhatIf
```

Shows the request that would be sent without deleting anything.

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
The ID of the company service template to delete (required).
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

## NOTES
Endpoint: DELETE /company/companies/{parentId}/serviceTemplates/{id}

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMCompanyServiceTemplate]()

[New-CWMCompanyServiceTemplate]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

