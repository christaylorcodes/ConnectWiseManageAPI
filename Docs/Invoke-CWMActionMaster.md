---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMActionMaster

## SYNOPSIS
Generic POST request handler for ConnectWise Manage action endpoints that take no request body.

## SYNTAX

```
Invoke-CWMActionMaster [[-Endpoint] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Master function for action endpoints, such as
/company/companies/{parentId}/serviceTemplates/{id}/link, that are triggered by a POST with no body.
Unlike Invoke-CWMNewMaster, no body and no content type are sent.

Used by action functions such as Add-CWMCompanyServiceTemplateLink and Copy-CWMCompanyServiceTemplate.

This function calls the ConnectWise Manage API endpoint: POST {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
Invoke-CWMActionMaster -Endpoint '/company/companies/250/serviceTemplates/15/link'
```

Links company service template 15 of company 250.

### EXAMPLE 2
```
Invoke-CWMActionMaster -Endpoint '/company/companies/250/serviceTemplates/15/copy' -WhatIf
```

Shows the request that would be sent, without sending it.

## PARAMETERS

### -Endpoint
The API endpoint path of the action, e.g.
'/company/companies/250/serviceTemplates/15/link'.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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

## NOTES
Author: Chris Taylor

Internal Function:
- Called by action functions (Add-/Remove-CWMCompanyServiceTemplateLink, Copy-CWMCompanyServiceTemplate)
- Supports -WhatIf and -Confirm
- The response, when there is one, is converted with ConvertFrom-CWMJson

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Invoke-CWMNewMaster]()

[Add-CWMCompanyServiceTemplateLink]()

