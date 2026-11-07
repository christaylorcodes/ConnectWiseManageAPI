---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMSetMaster

## SYNOPSIS
Generic PUT request handler for replacing ConnectWise Manage records.

## SYNTAX

```
Invoke-CWMSetMaster [[-Arguments] <Object>] [[-Endpoint] <String>] [[-Skip] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Master function for replace (PUT) operations.
The whole record is replaced with the properties
passed in $Arguments, so properties that are not included may be cleared by the API.
To change
only some fields, use Invoke-CWMUpdateMaster (PATCH) instead.

Used by Set-CWM* functions such as Set-CWMCompanyServiceTemplate.
PowerShell common parameters, the parameters in $Skip, and the route ids (id, parentId,
grandparentId) are left out of the body.

This function calls the ConnectWise Manage API endpoint: PUT {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
$SetArguments = @{
    name    = 'Monthly maintenance'
    summary = 'Monthly maintenance'
    board   = @{ id = 1 }
    status  = @{ id = 16 }
}
Invoke-CWMSetMaster -Arguments $SetArguments -Endpoint '/company/companies/250/serviceTemplates/15'
```

Replaces company service template 15 of company 250.

## PARAMETERS

### -Arguments
Hashtable (usually $PSBoundParameters) containing the properties of the record.
If it contains Body, that value is sent as is and the other properties are ignored.

```yaml
Type: System.Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Endpoint
The API endpoint path including the record id, e.g.
'/company/companies/250/serviceTemplates/15'.

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

### -Skip
Array of parameter names to exclude from the request body.
Common parameters and route ids are always skipped.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
- Called by Set-CWM* functions
- Supports -WhatIf and -Confirm
- Sends 'application/json; charset=utf-8', like Invoke-CWMNewMaster and Invoke-CWMUpdateMaster
- The response is converted with ConvertFrom-CWMJson

Based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Invoke-CWMUpdateMaster]()

[Set-CWMCompanyServiceTemplate]()

