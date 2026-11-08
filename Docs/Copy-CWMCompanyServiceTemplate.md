---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Copy-CWMCompanyServiceTemplate

## SYNOPSIS
Copies a company service template in ConnectWise Manage.

## SYNTAX

```
Copy-CWMCompanyServiceTemplate [-parentId] <Int32> [-id] <Int32> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Calls the 'copy' action of a company service template.
The request is a POST with no body.

This function calls the ConnectWise Manage API endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/copy

## EXAMPLES

### EXAMPLE 1
```
Copy-CWMCompanyServiceTemplate -parentId 250 -id 15
```

Copies service template 15 of company 250.

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
The ID of the company service template to copy (required).
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
Endpoint: POST /company/companies/{parentId}/serviceTemplates/{id}/copy

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Get-CWMCompanyServiceTemplate]()

[Invoke-CWMActionMaster]()

[https://developer.connectwise.com/manage/rest](https://developer.connectwise.com/manage/rest)

