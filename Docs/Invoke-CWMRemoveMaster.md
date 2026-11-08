---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMRemoveMaster

## SYNOPSIS
Generic DELETE request handler for removing ConnectWise Manage records.

## SYNTAX

```
Invoke-CWMRemoveMaster [[-Endpoint] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Master function for all delete (DELETE) operations in the module.
Permanently removes records from the ConnectWise Manage system.

Used by all Remove-CWM* functions (Remove-CWMTicket, Remove-CWMCompany, etc.).
Supports -WhatIf and -Confirm for safety.

This function calls the ConnectWise Manage API endpoint: DELETE {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
Invoke-CWMRemoveMaster -Endpoint '/service/tickets/12345'
```

Deletes ticket with ID 12345.

## PARAMETERS

### -Endpoint
The API endpoint path including the ID to delete.
Format: '/service/tickets/12345', '/company/companies/250'

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
- Called by all Remove-CWM* functions
- Supports -WhatIf and -Confirm for safety
- Returns 204 (No Content) on success
- Deletion is permanent and cannot be undone

## RELATED LINKS

[Invoke-CWMWebRequest]()

[Remove-CWMTicket]()

[Remove-CWMCompany]()

