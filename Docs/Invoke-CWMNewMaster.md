---
external help file: ConnectWiseManageAPI-help.xml
Module Name: ConnectWiseManageAPI
online version:
schema: 2.0.0
---

# Invoke-CWMNewMaster

## SYNOPSIS
Generic POST request handler for creating new ConnectWise Manage records.

## SYNTAX

```
Invoke-CWMNewMaster [[-Arguments] <Object>] [[-Endpoint] <String>] [[-Skip] <String[]>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Master function for all create (POST) operations in the module.
Converts function parameters to JSON body and submits to the API.

Used by all New-CWM* functions (New-CWMTicket, New-CWMCompany, etc.).
Automatically filters out PowerShell common parameters and skipped parameters.

This function calls the ConnectWise Manage API endpoint: POST {Endpoint}

## EXAMPLES

### EXAMPLE 1
```
$NewArguments = @{
    summary = "New ticket"
    company = @{ id = 250 }
    board = @{ id = 1 }
}
Invoke-CWMNewMaster -Arguments $NewArguments -Endpoint '/service/tickets'
```

Creates a new ticket.

## PARAMETERS

### -Arguments
Hashtable containing the properties for the new record.
Common parameters and those in $Skip are automatically filtered out.

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
The API endpoint path (e.g., '/service/tickets', '/company/companies')

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
Common parameters are automatically skipped.

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
- Called by all New-CWM* functions
- Supports -WhatIf and -Confirm
- Automatically filters PowerShell common parameters
- Verbose and -WhatIf output masks secrets (password, token, privateKey, secret, memberHash)
- Converts parameters to JSON body
- Writes a warning when the response is a single record with id 0.
PR #82 reported that
  POST /company/companies/{id}/serviceTemplates without a company returns a record with id 0
  and creates nothing.
The warning is based on PR #82 by mdewart-Centre.

## RELATED LINKS

[Invoke-CWMWebRequest]()

[New-CWMTicket]()

[New-CWMCompany]()

